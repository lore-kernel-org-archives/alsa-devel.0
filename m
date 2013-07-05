From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCHv2 09/31] ALSA: hdspm - Enable AD/DA/PH gains
	and S/PDIF-Input select on AIO
Date: Fri,  5 Jul 2013 11:28:01 +0200
Message-ID: <1373016503-9474-10-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1373016503-9474-1-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-2-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-3-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-4-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-5-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-6-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-7-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-8-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-9-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1373016503-9474-9-git-send-email-adi@drcomp.erfurt.thur.de>
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

This patch uses the newly introduced HDSPM_CONTROL_TRISTATE functions to
create and expose the following ALSA controls:

   - Gain selection for Input, Output and Phones (HiGain, +4dBu, -10dbV)
   - S/PDIF Input select (Coaxial, Optical, Internal)

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index d9532c4..778fc23 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -4412,11 +4412,15 @@ static struct snd_kcontrol_new snd_hdspm_controls_aio[] = {
 	HDSPM_AUTOSYNC_SAMPLE_RATE("ADAT Frequency", 3),
 	HDSPM_AUTOSYNC_SAMPLE_RATE("TCO Frequency", 4),
 	HDSPM_AUTOSYNC_SAMPLE_RATE("SYNC IN Frequency", 5),
+	HDSPM_CONTROL_TRISTATE("S/PDIF Input", HDSPM_c0_Input0),
 	HDSPM_TOGGLE_SETTING("S/PDIF Out Optical", HDSPM_c0_Spdif_Opt),
 	HDSPM_TOGGLE_SETTING("S/PDIF Out Professional", HDSPM_c0_Pro),
 	HDSPM_TOGGLE_SETTING("ADAT internal (AEB/TEB)", HDSPM_c0_AEB1),
 	HDSPM_TOGGLE_SETTING("XLR Breakout Cable", HDSPM_c0_Sym6db),
-	HDSPM_TOGGLE_SETTING("Single Speed WordClock Out", HDSPM_c0_Wck48)
+	HDSPM_TOGGLE_SETTING("Single Speed WordClock Out", HDSPM_c0_Wck48),
+	HDSPM_CONTROL_TRISTATE("Input Level", HDSPM_c0_AD_GAIN0),
+	HDSPM_CONTROL_TRISTATE("Output Level", HDSPM_c0_DA_GAIN0),
+	HDSPM_CONTROL_TRISTATE("Phones Level", HDSPM_c0_PH_GAIN0)
 
 		/*
 		   HDSPM_INPUT_SELECT("Input Select", 0),
-- 
1.8.3.1
