From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH] ALSA: emux: constify nrpn_conv_table structures
Date: Mon,  4 Jan 2016 17:50:47 +0100
Message-ID: <1451926247-29119-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <kernel-janitors-owner@vger.kernel.org>
Sender: kernel-janitors-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The nrpn_conv_table structures are never modified, so declare them as
const.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 sound/synth/emux/emux_nrpn.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/synth/emux/emux_nrpn.c b/sound/synth/emux/emux_nrpn.c
index 00fc005..9729a15 100644
--- a/sound/synth/emux/emux_nrpn.c
+++ b/sound/synth/emux/emux_nrpn.c
@@ -48,7 +48,8 @@ struct nrpn_conv_table {
  * convert NRPN/control values
  */
 
-static int send_converted_effect(struct nrpn_conv_table *table, int num_tables,
+static int send_converted_effect(const struct nrpn_conv_table *table,
+				 int num_tables,
 				 struct snd_emux_port *port,
 				 struct snd_midi_channel *chan,
 				 int type, int val, int mode)
@@ -179,7 +180,7 @@ static int fx_conv_Q(int val)
 }
 
 
-static struct nrpn_conv_table awe_effects[] =
+static const struct nrpn_conv_table awe_effects[] =
 {
 	{ 0, EMUX_FX_LFO1_DELAY,	fx_lfo1_delay},
 	{ 1, EMUX_FX_LFO1_FREQ,	fx_lfo1_freq},
@@ -266,7 +267,7 @@ static int gs_vib_delay(int val)
 	return -(val - 64) * gs_sense[FX_VIBDELAY] / 50;
 }
 
-static struct nrpn_conv_table gs_effects[] =
+static const struct nrpn_conv_table gs_effects[] =
 {
 	{32, EMUX_FX_CUTOFF,	gs_cutoff},
 	{33, EMUX_FX_FILTERQ,	gs_filterQ},
@@ -350,7 +351,7 @@ static int xg_release(int val)
 	return -(val - 64) * xg_sense[FX_RELEASE] / 64;
 }
 
-static struct nrpn_conv_table xg_effects[] =
+static const struct nrpn_conv_table xg_effects[] =
 {
 	{71, EMUX_FX_CUTOFF,	xg_cutoff},
 	{74, EMUX_FX_FILTERQ,	xg_filterQ},

