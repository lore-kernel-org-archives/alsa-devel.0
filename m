From: sudarshan.bisht@nokia.com
Subject: [PATCH 1/2] alsa-lib: fixed coverity reported issues
	under "USE_AFTER_FREE" checker.
Date: Thu,  5 May 2011 16:05:30 +0300
Message-ID: <1304600730-24895-2-git-send-email-sudarshan.bisht@nokia.com>
References: <1304600730-24895-1-git-send-email-sudarshan.bisht@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa02.nokia.com (smtp.nokia.com [147.243.1.48])
	by alsa0.perex.cz (Postfix) with ESMTP id 935CA103832
	for <alsa-devel@alsa-project.org>;
	Thu,  5 May 2011 15:05:57 +0200 (CEST)
In-Reply-To: <1304600730-24895-1-git-send-email-sudarshan.bisht@nokia.com>
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
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

From: Sudarshan Bisht <sudarshan.bisht@nokia.com>

Coverity Static Analysis helps developers find hard-to-spot,
yet potentially crash-causing defects early in the development phase,
reducing the cost,time, and risk of software errors.

This patch has fixes for 1) a junk assignment and 2) memory freed at wrong location.

---
 src/control/control_hw.c |    1 +
 src/mixer/mixer.c        |    1 -
 2 files changed, 1 insertions(+), 1 deletions(-)

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
-- 
1.7.0.4
