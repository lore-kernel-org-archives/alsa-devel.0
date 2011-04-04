From: sudarshan.bisht@nokia.com
Subject: [PATCH 4/4 v2] alsa-lib: fixed coverity reported
	issues under "USE_AFTER_FREE" checker.
Date: Mon,  4 Apr 2011 10:27:56 +0300
Message-ID: <1301902076-32126-4-git-send-email-sudarshan.bisht@nokia.com>
References: <1301902076-32126-1-git-send-email-sudarshan.bisht@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-da01.nokia.com (smtp.nokia.com [147.243.128.24])
	by alsa0.perex.cz (Postfix) with ESMTP id A524C2446E
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Apr 2011 09:30:22 +0200 (CEST)
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
 modules/mixer/simple/python.c |    1 +
 src/control/control_hw.c      |    1 +
 src/mixer/mixer.c             |    1 -
 src/mixer/simple_abst.c       |    2 ++
 4 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/modules/mixer/simple/python.c b/modules/mixer/simple/python.c
index c822c52..784d9a0 100644
--- a/modules/mixer/simple/python.c
+++ b/modules/mixer/simple/python.c
@@ -663,6 +663,7 @@ pymixer_attach_hctl(struct pymixer *pymixer, PyObject *args)
 		return NULL;
 	err = snd_mixer_attach_hctl(pymixer->mixer, hctl);
 	if (err < 0) {
+		snd_hctl_close(hctl);
 		PyErr_Format(PyExc_RuntimeError, "Cannot attach hctl: %s", snd_strerror(err));
 		return NULL;
 	}
diff --git a/src/control/control_hw.c b/src/control/control_hw.c
index cf258b4..16c4987 100644
--- a/src/control/control_hw.c
+++ b/src/control/control_hw.c
@@ -414,6 +414,7 @@ int snd_ctl_hw_open(snd_ctl_t **handle, const char *name, int card, int mode)
 	if (err < 0) {
 		close(fd);
 		free(hw);
+		return err;
 	}
 	ctl->ops = &snd_ctl_hw_ops;
 	ctl->private_data = hw;
diff --git a/src/mixer/mixer.c b/src/mixer/mixer.c
index 85d843f..5e5789a 100644
--- a/src/mixer/mixer.c
+++ b/src/mixer/mixer.c
@@ -228,7 +228,6 @@ int snd_mixer_attach_hctl(snd_mixer_t *mixer, snd_hctl_t *hctl)
 		return -ENOMEM;
 	err = snd_hctl_nonblock(hctl, 1);
 	if (err < 0) {
-		snd_hctl_close(hctl);
 		free(slave);
 		return err;
 	}
diff --git a/src/mixer/simple_abst.c b/src/mixer/simple_abst.c
index 9e9aaf5..127d8d2 100644
--- a/src/mixer/simple_abst.c
+++ b/src/mixer/simple_abst.c
@@ -336,6 +336,8 @@ int snd_mixer_simple_basic_register(snd_mixer_t *mixer,
 		err = find_module(class, top);
 	if (err >= 0)
 		err = snd_mixer_attach_hctl(mixer, priv->hctl);
+		if(err < 0) 
+			 goto __error;		
 	if (err >= 0) {
 		priv->attach_flag = 1;
 		err = snd_mixer_class_register(class, mixer);
-- 
1.7.0.4
