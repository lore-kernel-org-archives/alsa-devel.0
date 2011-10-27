From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 1/3] ALSA: hdspm - Fix MADI channel format in
	the status ioctl
Date: Thu, 27 Oct 2011 21:57:52 +0200
Message-ID: <1319745474-31542-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

SNDRV_HDSPM_IOCTL_GET_STATUS is supposed to query the current card
status, so we have to return what we receive on the MADI wire (RX), not
what we transmit (TX) to others. The latter is a config item to be
queried via SNDRV_HDSPM_IOCTL_GET_CONFIG.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 6e2f7ef..60a0b7d 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -6253,7 +6253,7 @@ static int snd_hdspm_hwdep_ioctl(struct snd_hwdep *hw, struct file *file,
 			status.card_specific.madi.madi_input =
 				(statusregister & HDSPM_AB_int) ? 1 : 0;
 			status.card_specific.madi.channel_format =
-				(statusregister & HDSPM_TX_64ch) ? 1 : 0;
+				(statusregister & HDSPM_RX_64ch) ? 1 : 0;
 			/* TODO: Mac driver sets it when f_s>48kHz */
 			status.card_specific.madi.frame_format = 0;
 
-- 
1.7.7.1
