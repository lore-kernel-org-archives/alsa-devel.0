From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: hdspm: Fix zero-division
Date: Mon, 29 Feb 2016 17:19:43 +0100
Message-ID: <1456762783-2653-2-git-send-email-tiwai@suse.de>
References: <1456762783-2653-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 91584265DA4
 for <alsa-devel@alsa-project.org>; Mon, 29 Feb 2016 17:19:46 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id A2889ADB6
 for <alsa-devel@alsa-project.org>; Mon, 29 Feb 2016 16:19:45 +0000 (UTC)
In-Reply-To: <1456762783-2653-1-git-send-email-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

HDSPM driver contains a code issuing zero-division potentially in
system sample rate ctl code.  This patch fixes it by not processing
a zero or invalid rate value as a divisor, as well as excluding the
invalid value to be passed via the given ctl element.

Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/rme9652/hdspm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index b047b1ba48fd..a4a999a0317e 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -1601,6 +1601,9 @@ static void hdspm_set_dds_value(struct hdspm *hdspm, int rate)
 {
 	u64 n;
 
+	if (snd_BUG_ON(rate <= 0))
+		return;
+
 	if (rate >= 112000)
 		rate /= 4;
 	else if (rate >= 56000)
@@ -2215,6 +2218,8 @@ static int hdspm_get_system_sample_rate(struct hdspm *hdspm)
 		} else {
 			/* slave mode, return external sample rate */
 			rate = hdspm_external_sample_rate(hdspm);
+			if (!rate)
+				rate = hdspm->system_sample_rate;
 		}
 	}
 
@@ -2260,7 +2265,10 @@ static int snd_hdspm_put_system_sample_rate(struct snd_kcontrol *kcontrol,
 					    ucontrol)
 {
 	struct hdspm *hdspm = snd_kcontrol_chip(kcontrol);
+	int rate = ucontrol->value.integer.value[0];
 
+	if (rate < 27000 || rate > 207000)
+		return -EINVAL;
 	hdspm_set_dds_value(hdspm, ucontrol->value.integer.value[0]);
 	return 0;
 }
-- 
2.7.2
