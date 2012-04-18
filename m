From: Randy Dunlap <rdunlap@xenotime.net>
Subject: [PATCH] sound: fix core/vmaster.c kernel-doc warning
Date: Tue, 17 Apr 2012 17:03:42 -0700
Message-ID: <4F8E04DE.1030302@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from oproxy5-pub.bluehost.com (oproxy5-pub.bluehost.com
	[67.222.38.55]) by alsa0.perex.cz (Postfix) with SMTP id EC9B224548
	for <alsa-devel@alsa-project.org>;
	Wed, 18 Apr 2012 02:03:10 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

From: Randy Dunlap <rdunlap@xenotime.net>

Fix kernel-doc warning in sound/core/vmaster.c:

Warning(sound/core/vmaster.c:429): No description found for parameter 'private_data'

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 sound/core/vmaster.c |    1 +
 1 file changed, 1 insertion(+)

--- lnx-34-rc3.orig/sound/core/vmaster.c
+++ lnx-34-rc3/sound/core/vmaster.c
@@ -419,6 +419,7 @@ EXPORT_SYMBOL(snd_ctl_make_virtual_maste
  * snd_ctl_add_vmaster_hook - Add a hook to a vmaster control
  * @kcontrol: vmaster kctl element
  * @hook: the hook function
+ * @private_data: the private_data pointer to be saved
  *
  * Adds the given hook to the vmaster control element so that it's called
  * at each time when the value is changed.
