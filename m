From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] patch_ca0132.c: Handle SBZ and R3Di sound
	cards
Date: Mon, 23 Apr 2018 16:01:40 +0900
Message-ID: <761fa48e-0805-e165-e46c-0a3f8a94adc7@sakamocchi.jp>
References: <1524445866-3586-1-git-send-email-conmanx360@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id DD08C2671EA
 for <alsa-devel@alsa-project.org>; Mon, 23 Apr 2018 09:01:43 +0200 (CEST)
In-Reply-To: <1524445866-3586-1-git-send-email-conmanx360@gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Connor McAdams <conmanx360@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Apr 23 2018 10:11, Connor McAdams wrote:
> This patch adds support for the Sound Blaster Z and the Recon3Di.
> 
> With the current version, both cards only had one output supported, and
> none of the inputs were working. This patch adds support for all
> outputs and inputs, digital and analog. It also adds support for the
> onboard DSP effects for both input and output.
> 
> This patch changes the control names for both cards to accommodate
> surround sound controls. The main effect switches, "PlayEnhancement" for
> output, and "CrystalVoice" for input, have been changed to "Enable
> OutFX" for output, and "Enable InFX" for input to make them more clear.
> Also, all DSP related effects have the prefix "FX:" attached to them, to
> make it more clear that "Enable *dir*FX" enables or disables them.
> Controls have also been added to change the effect levels of the
> individual effects, through a volume slider.
> 
> This patch also adds support for alternative firmware for both cards,
> under the names "ctefx-sbz.bin" for the Sound Blaster Z, and
> "ctefx-r3di.bin" for the Recon3Di. These firmwares are not necessary
> however, and there is a switch to use the original ctefx.bin file if
> neither alternative firmwares are detected.
> 
> This patch also adds the ability to set the DSP volume, which is set
> with a decibel value sent in floating point.
> 
> The only issue I'm aware of at this point is an "Unexpected TLV callback
> for slave Front Playback Volume", which relates to the vmaster control.
> For some reason, the TLV data doesn't match the rest of the controls,
> even though they seem to share the same tlv function.
> 
> Signed-off-by: Connor McAdams <conmanx360@gmail.com>

At first, I welcome you and your work based on reverse engineering[1]
for this patch.

However, as a reviewer, I should point 6 items to improve it and
to avoid regressions or disorders. If you have enough time and
motivation to post next v2 patchset, please take care of items below.


1. Original code of 'patch_ca0132.c' doesn't support suspend/resume,
while your patch tries. This means that the new suspend/resume
functionality affects to current supported cards. This can easily
results in disorder if regression tests are inadequate for the cards.
However, your aim is not for the functionality and it's better to
introduce these codes in the other opportunity; e.g. in patchset after
merging patchset for SBZ/R3Di.


2. This patch includes some read-only reference tables; e.g.
float_vol_db_lookup. In this case, it's better to add 'const' qualifier
to locate the symbol in read-only section of ELF binary. Unexpected
change brings protection fault and developers easily find to fix it in
development time. For example:

2.1. 'static const unsigned int' can be used:

+/*
+ * Default values for the effect slider controls, they are in order of 
their
+ * effect NID's. Surround, Crystalizer, Dialog Plus, Smart Volume, and then
+ * X-bass.
+ */
+static unsigned int effect_slider_defaults[] = {67, 65, 50, 74, 50};

2.2. 'static const char *const' can be used:

+/* Strings for Input Source Enum Control */
+static char *in_src_str[3] = {"Rear Mic", "Line", "Front Mic" };


3.This patch changes permission of this file. This is not preferable.
Keep the permission as is.

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
old mode 100644
new mode 100755


4. The purpose of this patch is to add support for SBZ/R3Di, on the
other hand it includes some minor code changes. It's better to let
developers/reviewers focus on significant changes. For example:

4.1.Conversions from spaces to tab.

@@ -536,41 +729,41 @@ enum hda_cmd_vendor_io {
   */
  enum control_flag_id {
  	/* Connection manager stream setup is bypassed/enabled */
-	CONTROL_FLAG_C_MGR                  = 0,
+	CONTROL_FLAG_C_MGR		    = 0,

4.2.Renaming macro

@@ -39,10 +40,11 @@
  /* Enable this to see controls for tuning purpose. */
  /*#define ENABLE_TUNING_CONTROLS*/

-#define FLOAT_ZERO	0x00000000
...
+#define FLOAT_0	0x00000000

4.3.Additions of line breaks

@@ -4732,6 +7522,7 @@ static int ca0132_prepare_verbs(struct hda_codec 
*codec)
  	return 0;
  }

+
  static int patch_ca0132(struct hda_codec *codec)
  {
  	struct ca0132_spec *spec;

4.4.Replacement of ARRAY_SIZE(array) with sizeof(array)/sizeof(array[0])

@@ -3635,8 +5213,10 @@ static int ca0132_voicefx_put(struct snd_kcontrol 
*kcontrol,
  	struct ca0132_spec *spec = codec->spec;
  	int i, err = 0;
  	int sel = ucontrol->value.enumerated.item[0];
+	unsigned int items = sizeof(ca0132_voicefx_presets)
+				/ sizeof(struct ct_voicefx_preset);

-	if (sel >= ARRAY_SIZE(ca0132_voicefx_presets))
+	if (sel >= items)


5. This patch is big. If possible, please make a patchset with several
small patches. As a quick glance, this patch can be split into below
parts in this order:

  1.introduce new QUIRK_XXX entry and firmware loading
  2.apply unique pincfgs
  3.retrieve/release iomap
  4.new shutdown routines
  5.add/change helper functions
  6.add alt_select_in()/_out()
  7.add ca0132_alt_dsp_volume_put()
  8.add ca0132_alt_set_vipsource()
  9-xx.add unique ctl elements such as 'Mic Boost Capture Switch'.

Smaller patches are easily reviewed, then applied. On the other hand,
bigger patches easily include mistakes and bugs, then not applied
so-easily.


6. This patch includes a 'FIXME'.

+/*FIXME Figure out why the program will not compile with these. */
+/*
  static const DECLARE_TLV_DB_SCALE(voice_focus_db_scale, 2000, 100, 0);
  static const DECLARE_TLV_DB_SCALE(eq_db_scale, -2400, 100, 0);
-
+*/
  static int add_tuning_control(struct hda_codec *codec,
  				hda_nid_t pnid, hda_nid_t nid,
  				const char *name, int dir)
@@ -3089,7 +3713,7 @@ static int add_tuning_control(struct hda_codec *codec,
  		knew.info = voice_focus_ctl_info;
  		knew.get = tuning_ctl_get;
  		knew.put = voice_focus_ctl_put;
-		knew.tlv.p = voice_focus_db_scale;
+//		knew.tlv.p = voice_focus_db_scale;
  		break;
  	case MIC_SVM:
  		knew.info = mic_svm_ctl_info;
@@ -3100,7 +3724,7 @@ static int add_tuning_control(struct hda_codec *codec,
  		knew.info = equalizer_ctl_info;
  		knew.get = tuning_ctl_get;
  		knew.put = equalizer_ctl_put;
-		knew.tlv.p = eq_db_scale;
+//		knew.tlv.p = eq_db_scale;
  		break;
  	default:
  		return 0;

 From my interesting, could I request you to explain about the reason
deeper? This comes from your concern about the vmaster control elements?


At last, feel free to add me to CC list in next time you post v2
patchset. I'm willing to review it ;)
(But I with to receive patchset with smaller patches.)

[1] [alsa-devel] Fixing the CA0132 driver for Sound Blaster Z
http://mailman.alsa-project.org/pipermail/alsa-devel/2018-February/131598.html


Thanks

Takashi Sakamoto
