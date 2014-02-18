From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 005/102] ASoC: adau1373: Remove superfluous
	const
Date: Tue, 18 Feb 2014 12:32:17 +0100
Message-ID: <1392723148-12597-3-git-send-email-tiwai@suse.de>
References: <1392723148-12597-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 7EDBA26533B
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 12:32:33 +0100 (CET)
In-Reply-To: <1392723148-12597-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

As SOC_ENUM_SINGLE_DECL() itself contains const modifier now, we can
reduce const from its users.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/adau1373.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/adau1373.c b/sound/soc/codecs/adau1373.c
index eb836ed5271f..46b1595d7c50 100644
--- a/sound/soc/codecs/adau1373.c
+++ b/sound/soc/codecs/adau1373.c
@@ -345,15 +345,15 @@ static const char *adau1373_fdsp_sel_text[] = {
 	"Channel 5",
 };
 
-static const SOC_ENUM_SINGLE_DECL(adau1373_drc1_channel_enum,
+static SOC_ENUM_SINGLE_DECL(adau1373_drc1_channel_enum,
 	ADAU1373_FDSP_SEL1, 4, adau1373_fdsp_sel_text);
-static const SOC_ENUM_SINGLE_DECL(adau1373_drc2_channel_enum,
+static SOC_ENUM_SINGLE_DECL(adau1373_drc2_channel_enum,
 	ADAU1373_FDSP_SEL1, 0, adau1373_fdsp_sel_text);
-static const SOC_ENUM_SINGLE_DECL(adau1373_drc3_channel_enum,
+static SOC_ENUM_SINGLE_DECL(adau1373_drc3_channel_enum,
 	ADAU1373_FDSP_SEL2, 0, adau1373_fdsp_sel_text);
-static const SOC_ENUM_SINGLE_DECL(adau1373_hpf_channel_enum,
+static SOC_ENUM_SINGLE_DECL(adau1373_hpf_channel_enum,
 	ADAU1373_FDSP_SEL3, 0, adau1373_fdsp_sel_text);
-static const SOC_ENUM_SINGLE_DECL(adau1373_bass_channel_enum,
+static SOC_ENUM_SINGLE_DECL(adau1373_bass_channel_enum,
 	ADAU1373_FDSP_SEL4, 4, adau1373_fdsp_sel_text);
 
 static const char *adau1373_hpf_cutoff_text[] = {
@@ -362,7 +362,7 @@ static const char *adau1373_hpf_cutoff_text[] = {
 	"800Hz",
 };
 
-static const SOC_ENUM_SINGLE_DECL(adau1373_hpf_cutoff_enum,
+static SOC_ENUM_SINGLE_DECL(adau1373_hpf_cutoff_enum,
 	ADAU1373_HPF_CTRL, 3, adau1373_hpf_cutoff_text);
 
 static const char *adau1373_bass_lpf_cutoff_text[] = {
@@ -388,14 +388,14 @@ static const unsigned int adau1373_bass_tlv[] = {
 	5, 7, TLV_DB_SCALE_ITEM(1400, 150, 0),
 };
 
-static const SOC_ENUM_SINGLE_DECL(adau1373_bass_lpf_cutoff_enum,
+static SOC_ENUM_SINGLE_DECL(adau1373_bass_lpf_cutoff_enum,
 	ADAU1373_BASS1, 5, adau1373_bass_lpf_cutoff_text);
 
-static const SOC_VALUE_ENUM_SINGLE_DECL(adau1373_bass_clip_level_enum,
+static SOC_VALUE_ENUM_SINGLE_DECL(adau1373_bass_clip_level_enum,
 	ADAU1373_BASS1, 2, 7, adau1373_bass_clip_level_text,
 	adau1373_bass_clip_level_values);
 
-static const SOC_ENUM_SINGLE_DECL(adau1373_bass_hpf_cutoff_enum,
+static SOC_ENUM_SINGLE_DECL(adau1373_bass_hpf_cutoff_enum,
 	ADAU1373_BASS1, 0, adau1373_bass_hpf_cutoff_text);
 
 static const char *adau1373_3d_level_text[] = {
@@ -409,9 +409,9 @@ static const char *adau1373_3d_cutoff_text[] = {
 	"0.16875 fs", "0.27083 fs"
 };
 
-static const SOC_ENUM_SINGLE_DECL(adau1373_3d_level_enum,
+static SOC_ENUM_SINGLE_DECL(adau1373_3d_level_enum,
 	ADAU1373_3D_CTRL1, 4, adau1373_3d_level_text);
-static const SOC_ENUM_SINGLE_DECL(adau1373_3d_cutoff_enum,
+static SOC_ENUM_SINGLE_DECL(adau1373_3d_cutoff_enum,
 	ADAU1373_3D_CTRL1, 0, adau1373_3d_cutoff_text);
 
 static const unsigned int adau1373_3d_tlv[] = {
@@ -427,11 +427,11 @@ static const char *adau1373_lr_mux_text[] = {
 	"Stereo",
 };
 
-static const SOC_ENUM_SINGLE_DECL(adau1373_lineout1_lr_mux_enum,
+static SOC_ENUM_SINGLE_DECL(adau1373_lineout1_lr_mux_enum,
 	ADAU1373_OUTPUT_CTRL, 4, adau1373_lr_mux_text);
-static const SOC_ENUM_SINGLE_DECL(adau1373_lineout2_lr_mux_enum,
+static SOC_ENUM_SINGLE_DECL(adau1373_lineout2_lr_mux_enum,
 	ADAU1373_OUTPUT_CTRL, 6, adau1373_lr_mux_text);
-static const SOC_ENUM_SINGLE_DECL(adau1373_speaker_lr_mux_enum,
+static SOC_ENUM_SINGLE_DECL(adau1373_speaker_lr_mux_enum,
 	ADAU1373_LS_CTRL, 4, adau1373_lr_mux_text);
 
 static const struct snd_kcontrol_new adau1373_controls[] = {
-- 
1.8.5.2
