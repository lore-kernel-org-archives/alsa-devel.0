From: sudarshan.bisht@nokia.com
Subject: [PATCH 3/3 v4] alsa-lib: fixed coverity reported
	issues under "USE_AFTER_FREE" checker.
Date: Mon,  4 Apr 2011 13:04:02 +0300
Message-ID: <1301911442-10898-1-git-send-email-sudarshan.bisht@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa02.nokia.com (smtp.nokia.com [147.243.1.48])
	by alsa0.perex.cz (Postfix) with ESMTP id 078011038DE
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Apr 2011 12:06:18 +0200 (CEST)
Received: from localhost.localdomain (esdhcp-heru025160.research.nokia.com
	[172.21.25.160])
	by mgw-sa02.nokia.com (Switch-3.4.3/Switch-3.4.3) with ESMTP id
	p34A6IGQ020035
	for <alsa-devel@alsa-project.org>; Mon, 4 Apr 2011 13:06:18 +0300
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Sudarshan Bisht <sudarshan.bisht@nokia.com>

Coverity Static Analysis helps developers find hard-to-spot,
yet potentially crash-causing defects early in the development phase,
reducing the cost,time, and risk of software errors.

This patch has a fix for conditions where 1) variable is used
evern after getting freed thus causing junk assignment and 2) double
free of memory.

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
index 9e9aaf5..c722b02 100644
--- a/src/mixer/simple_abst.c
+++ b/src/mixer/simple_abst.c
@@ -336,6 +336,8 @@ int snd_mixer_simple_basic_register(snd_mixer_t *mixer,
 		err = find_module(class, top);
 	if (err >= 0)
 		err = snd_mixer_attach_hctl(mixer, priv->hctl);
+		if (err < 0)
+			goto __error;
 	if (err >= 0) {
 		priv->attach_flag = 1;
 		err = snd_mixer_class_register(class, mixer);
-- 
1.7.0.4
