From: sudarshan.bisht@nokia.com
Subject: [PATCH 3/4 v2] alsa-lib: fixed coverity reported
	issues under "REVERSE_INULL" checker.
Date: Mon,  4 Apr 2011 10:27:55 +0300
Message-ID: <1301902076-32126-3-git-send-email-sudarshan.bisht@nokia.com>
References: <1301902076-32126-1-git-send-email-sudarshan.bisht@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-da01.nokia.com (smtp.nokia.com [147.243.128.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 8AAB62446A
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Apr 2011 09:30:20 +0200 (CEST)
In-Reply-To: <1301902076-32126-1-git-send-email-sudarshan.bisht@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Sudarshan <sudarshan.bisht@nokia.com>

---
 src/control/setup.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/src/control/setup.c b/src/control/setup.c
index eecda45..3606e5c 100644
--- a/src/control/setup.c
+++ b/src/control/setup.c
@@ -398,7 +398,7 @@ static int snd_config_get_ctl_elem_value(snd_config_t *conf,
 
 static int add_elem(snd_sctl_t *h, snd_config_t *_conf, snd_config_t *private_data)
 {
-	snd_config_t *conf;
+	snd_config_t *conf = NULL ;
 	snd_config_iterator_t i, next;
 	char *tmp;
 	int iface = SND_CTL_ELEM_IFACE_MIXER;
@@ -412,6 +412,9 @@ static int add_elem(snd_sctl_t *h, snd_config_t *_conf, snd_config_t *private_da
 	snd_config_t *value = NULL, *mask = NULL;
 	snd_sctl_elem_t *elem = NULL;
 	int err;
+	/* The last parameter of snd_config_expand() is an output parameter, and
+ 	 * it is guaranteed that this parameter is set when the function succeeds.
+	 */		
 	err = snd_config_expand(_conf, _conf, NULL, private_data, &conf);
 	if (err < 0)
 		return err;
-- 
1.7.0.4
