From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 007/102] ASoC: mc13783: Remove superfluous const
Date: Tue, 18 Feb 2014 12:32:19 +0100
Message-ID: <1392723148-12597-5-git-send-email-tiwai@suse.de>
References: <1392723148-12597-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 66352265282
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
 sound/soc/codecs/mc13783.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/mc13783.c b/sound/soc/codecs/mc13783.c
index 582c2bbd42cb..147c2e53797b 100644
--- a/sound/soc/codecs/mc13783.c
+++ b/sound/soc/codecs/mc13783.c
@@ -430,8 +430,8 @@ static const struct snd_kcontrol_new samp_ctl =
 static const char * const speaker_amp_source_text[] = {
 	"CODEC", "Right"
 };
-static const SOC_ENUM_SINGLE_DECL(speaker_amp_source, MC13783_AUDIO_RX0, 4,
-				  speaker_amp_source_text);
+static SOC_ENUM_SINGLE_DECL(speaker_amp_source, MC13783_AUDIO_RX0, 4,
+			    speaker_amp_source_text);
 static const struct snd_kcontrol_new speaker_amp_source_mux =
 	SOC_DAPM_ENUM("Speaker Amp Source MUX", speaker_amp_source);
 
@@ -439,8 +439,8 @@ static const char * const headset_amp_source_text[] = {
 	"CODEC", "Mixer"
 };
 
-static const SOC_ENUM_SINGLE_DECL(headset_amp_source, MC13783_AUDIO_RX0, 11,
-				  headset_amp_source_text);
+static SOC_ENUM_SINGLE_DECL(headset_amp_source, MC13783_AUDIO_RX0, 11,
+			    headset_amp_source_text);
 static const struct snd_kcontrol_new headset_amp_source_mux =
 	SOC_DAPM_ENUM("Headset Amp Source MUX", headset_amp_source);
 
-- 
1.8.5.2
