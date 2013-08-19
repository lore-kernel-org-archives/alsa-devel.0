From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 1/3] ALSA: hdspm - Fix default value in
	SNDRV_HDSPM_IOCTL_GET_LTC
Date: Mon, 19 Aug 2013 17:20:30 +0200
Message-ID: <1376925632-5831-2-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1376925632-5831-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1376925632-5831-1-git-send-email-adi@drcomp.erfurt.thur.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Use enum hdspm_ltc_format's fps_30 (corresponds to 4) instead of 30,
Other case branches return 1, 2 or 3 respectively, so 30 obviously is
wrong.

Since SNDRV_HDSPM_IOCTL_GET_LTC had never been working due to a
copy&paste error in hdspm.h, this change doesn't break userspace.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index ec6335e..e4d76a6 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -6311,7 +6311,7 @@ static int snd_hdspm_hwdep_ioctl(struct snd_hwdep *hw, struct file *file,
 				ltc.format = fps_2997;
 				break;
 			default:
-				ltc.format = 30;
+				ltc.format = fps_30;
 				break;
 			}
 			if (i & HDSPM_TCO1_set_drop_frame_flag) {
-- 
1.8.3.2
