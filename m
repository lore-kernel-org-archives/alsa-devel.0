From: sudarshan.bisht@nokia.com
Subject: [PATCH] alsa-lib: fixed coverity reported issues under
	"USE_AFTER_FREE" checker.
Date: Thu, 17 Mar 2011 10:12:19 +0200
Message-ID: <1300349539-32209-2-git-send-email-sudarshan.bisht@nokia.com>
References: <1300349539-32209-1-git-send-email-sudarshan.bisht@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-da02.nokia.com (smtp.nokia.com [147.243.128.26])
	by alsa0.perex.cz (Postfix) with ESMTP id DC373103974
	for <alsa-devel@alsa-project.org>; Thu, 17 Mar 2011 09:13:57 +0100 (CET)
Received: from localhost.localdomain (esdhcp-heru02554.research.nokia.com
	[172.21.25.54])
	by mgw-da02.nokia.com (Switch-3.4.3/Switch-3.4.3) with ESMTP id
	p2H8DqZt015773
	for <alsa-devel@alsa-project.org>; Thu, 17 Mar 2011 10:13:55 +0200
In-Reply-To: <1300349539-32209-1-git-send-email-sudarshan.bisht@nokia.com>
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

From: Sudarshan <sudarshan.bisht@nokia.com>

---
 src/control/control_hw.c |    1 +
 src/mixer/mixer.c        |    2 +-
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/src/control/control_hw.c b/src/control/control_hw.c
index cf258b4..a8463c1 100644
--- a/src/control/control_hw.c
+++ b/src/control/control_hw.c
@@ -414,6 +414,7 @@ int snd_ctl_hw_open(snd_ctl_t **handle, const char *name, int card, int mode)
 	if (err < 0) {
 		close(fd);
 		free(hw);
+		hw = NULL;
 	}
 	ctl->ops = &snd_ctl_hw_ops;
 	ctl->private_data = hw;
diff --git a/src/mixer/mixer.c b/src/mixer/mixer.c
index 85d843f..0f4f1ac 100644
--- a/src/mixer/mixer.c
+++ b/src/mixer/mixer.c
@@ -205,7 +205,7 @@ int snd_mixer_attach(snd_mixer_t *mixer, const char *name)
 		return err;
 	err = snd_mixer_attach_hctl(mixer, hctl);
 	if (err < 0) {
-		snd_hctl_close(hctl);
+		/* ideally hctl should be freed here, but it's taken care in snd_mixer_attach_hctl*/	
 		return err;
 	}
 	return 0;
-- 
1.7.0.4
