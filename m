From: Jerome Forissier <jerome@taodyne.com>
Subject: [PATCH 1/2] Make snd_device_name_hint() thread-safe by
	locking a mutex
Date: Wed, 30 Jan 2013 16:22:16 +0100
Message-ID: <1359559337-15533-2-git-send-email-jerome@taodyne.com>
References: <1359559337-15533-1-git-send-email-jerome@taodyne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ubuntu (102.30.7.109.rev.sfr.net [109.7.30.102])
 by alsa0.perex.cz (Postfix) with ESMTP id 4175C26507C
 for <alsa-devel@alsa-project.org>; Wed, 30 Jan 2013 16:23:08 +0100 (CET)
In-Reply-To: <1359559337-15533-1-git-send-email-jerome@taodyne.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Jerome Forissier <jerome@taodyne.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Jerome Forissier <jerome@taodyne.com>
---
 src/control/namehint.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/src/control/namehint.c b/src/control/namehint.c
index 19352be..b30f75d 100644
--- a/src/control/namehint.c
+++ b/src/control/namehint.c
@@ -26,6 +26,9 @@
  */
 
 #include "local.h"
+#ifdef HAVE_LIBPTHREAD
+#include <pthread.h>
+#endif
 
 #ifndef DOC_HIDDEN
 struct hint_list {
@@ -44,6 +47,25 @@ struct hint_list {
 	int show_all;
 	char *cardname;
 };
+
+#ifdef HAVE_LIBPTHREAD
+static pthread_mutex_t snd_device_name_hint_mutex =
+                                PTHREAD_RECURSIVE_MUTEX_INITIALIZER_NP;
+#endif
+
+static inline void snd_device_name_hint_lock()
+{
+#ifdef HAVE_LIBPTHREAD
+	pthread_mutex_lock(&snd_device_name_hint_mutex);
+#endif
+}
+
+static inline void snd_device_name_hint_unlock()
+{
+#ifdef HAVE_LIBPTHREAD
+	pthread_mutex_unlock(&snd_device_name_hint_mutex);
+#endif
+}
 #endif
 
 static int hint_list_add(struct hint_list *list,
@@ -553,9 +575,13 @@ int snd_device_name_hint(int card, const char *iface, void ***hints)
 
 	if (hints == NULL)
 		return -EINVAL;
+	snd_device_name_hint_lock();
 	err = snd_config_update();
 	if (err < 0)
+	{
+		snd_device_name_hint_unlock();
 		return err;
+	}
 	list.list = NULL;
 	list.count = list.allocated = 0;
 	list.siface = iface;
@@ -574,7 +600,10 @@ int snd_device_name_hint(int card, const char *iface, void ***hints)
 	else if (strcmp(iface, "ctl") == 0)
 		list.iface = SND_CTL_ELEM_IFACE_MIXER;
 	else
+	{
+		snd_device_name_hint_unlock();
 		return -EINVAL;
+	}
 	list.show_all = 0;
 	list.cardname = NULL;
 	if (snd_config_search(snd_config, "defaults.namehint.showall", &conf) >= 0)
@@ -618,6 +647,7 @@ int snd_device_name_hint(int card, const char *iface, void ***hints)
       		snd_device_name_free_hint((void **)list.list);
       		if (list.cardname)
 	      		free(list.cardname);
+		snd_device_name_hint_unlock();
       		return err;
       	} else {
       		err = hint_list_add(&list, NULL, NULL);
@@ -627,6 +657,7 @@ int snd_device_name_hint(int card, const char *iface, void ***hints)
       		if (list.cardname)
 	      		free(list.cardname);
 	}
+	snd_device_name_hint_unlock();
       	return 0;
 }
 
-- 
1.8.1.2
