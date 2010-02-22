From: Reimundo Heluani <rheluani@gmail.com>
Subject: Re: Macbook Air 2,1 - no mic nor main speakers
Date: Sun, 21 Feb 2010 22:30:58 -0800
Message-ID: <1266820258.3074.16.camel@vino>
References: <1265480879.2466.21.camel@vino>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.150])
	by alsa0.perex.cz (Postfix) with ESMTP id 483D810380D
	for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2010 07:31:01 +0100 (CET)
Received: by qw-out-1920.google.com with SMTP id 5so332253qwf.56
	for <alsa-devel@alsa-project.org>; Sun, 21 Feb 2010 22:31:00 -0800 (PST)
In-Reply-To: <1265480879.2466.21.camel@vino>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sat, 2010-02-06 at 10:27 -0800, Reimundo Heluani wrote:
> Hello list, this came up a year ago and Takashi's answer was "a broken
> bios". I was hoping someone here could point me to documentation to read
> in order to diagnose the problem if indeed is a broken bios. I don't
> want to start randombly reading the driver's code.
> 
> Macbook Air 2,1
> 2.6.32-gentoo-r3 SMP x86_64
> Alsa Driver 1.0.21 libs 1.0.22
> nVidia Corporation MCP79 High Definition Audio (rev b1)
> HDA NVidia at 0x93380000 irq 19
> 00:08.0 0403: 10de:0ac0 (rev b1)  Subsystem: 10de:cb79
> Codec: Realtek ALC889A
> 
> Booting with snd_hda_intel.model=mbp3 get sound on headphones, but not on mainspeakers. The mic never worked.
> 

Hello again, I found out that puting the pin in 0x18 as a PIN_OUT I get
sound in the internal speaker. Currently I can change patch_realtek.c to
load the driver using an "mba21" model and I get sound on the main
speaker. One of the (many) problems I have is that I need to use
something like

{0x18, AC_VERB_SET_PIN_WIDGET_CONTROL, (PIN_OUT | AC_PINCTL_VREF_50) } 

otherwise it goes into HiZ and I get no audio. Looking at that
patch_realtek.c I don't see anything similar. Anyway, I don't have a
clue about ALSA, I just started reading the HDA specification and looked
over patch_realtek.c and came up with the small change below to have a
working main speaker. I'd appreciate if you had any suggestion for the
mic or to point me towards the right documentation.

Sincerely, 

R.

*** patch_realtek.c.orig	Sun Feb 21 01:23:58 2010
--- patch_realtek.c	Sun Feb 21 19:42:13 2010
***************
*** 205,210 ****
--- 205,211 ----
  	ALC882_ASUS_A7J,
  	ALC882_ASUS_A7M,
  	ALC885_MACPRO,
+ 	ALC885_MBA21,
  	ALC885_MBP3,
  	ALC885_MB5,
  	ALC885_IMAC24,
***************
*** 6749,6754 ****
--- 6750,6766 ----
  	{ 8, alc882_sixstack_ch8_init },
  };
  
+ /* Macbook Air I have no clue how it works yet */
+ 
+ static struct hda_verb alc885_mba21_init[] = {
+ 	{ 0x18, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT },
+ 	{ } /* end */
+ };
+ 
+ static struct hda_channel_mode alc885_mba21_ch_modes[1] = {
+ 	{ 2, alc885_mba21_init },
+ };
+ 
  /*
   * macbook pro ALC885 can switch LineIn to LineOut without losing Mic
   */
***************
*** 7020,7025 ****
--- 7032,7045 ----
  	{ } /* end */
  };
  
+ 
+ static struct snd_kcontrol_new alc885_mba21_mixer[] = {
+ 	HDA_CODEC_VOLUME("Speaker Playback Volume", 0x0c, 0x00, HDA_OUTPUT),
+ 	HDA_BIND_MUTE	("Speaker Playback Switch", 0x0c, 0x02, HDA_OUTPUT),
+ 	{ }
+ };
+ 
+ 
  static struct snd_kcontrol_new alc885_mbp3_mixer[] = {
  	HDA_CODEC_VOLUME("Speaker Playback Volume", 0x0c, 0x00, HDA_OUTPUT),
  	HDA_BIND_MUTE   ("Speaker Playback Switch", 0x0c, 0x02, HDA_INPUT),
***************
*** 7444,7449 ****
--- 7464,7482 ----
  	{ }
  };
  
+ static struct hda_verb alc885_mba21_init_verbs[] = {
+ 	/*Internal Speaker Mixer*/
+ 	{0x0c, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_ZERO}, 
+     {0x0c, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
+ 	{0x0c, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1)},
+ 	/*Internal Speaker Pin*/
+ 	{0x18, AC_VERB_SET_PIN_WIDGET_CONTROL, (PIN_OUT |
AC_PINCTL_VREF_50) },
+ 	{0x18, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+ 	{0x18, AC_VERB_SET_CONNECT_SEL, 0x00},
+ 
+ 	{ }
+ };
+ 
  /* Macbook Pro rev3 */
  static struct hda_verb alc885_mbp3_init_verbs[] = {
  	/* Front mixer: unmute input/output amp left and right (volume = 0)
*/
***************
*** 7546,7551 ****
--- 7579,7593 ----
  	spec->autocfg.speaker_pins[1] = 0x1a;
  }
  
+ /* Macbook Air don't know how this works */
+ static void alc885_mba21_setup (struct hda_codec *codec)
+ {
+ 	struct alc_spec *spec = codec->spec;
+ 
+ 	spec->autocfg.speaker_pins[0] = 0x18;
+ }
+ 
+ 
  static void alc885_mbp3_setup(struct hda_codec *codec)
  {
  	struct alc_spec *spec = codec->spec;
***************
*** 8737,8742 ****
--- 8779,8785 ----
  	[ALC882_ASUS_A7M]	= "asus-a7m",
  	[ALC885_MACPRO]		= "macpro",
  	[ALC885_MB5]		= "mb5",
+ 	[ALC885_MBA21]		= "mba21",
  	[ALC885_MBP3]		= "mbp3",
  	[ALC885_IMAC24]		= "imac24",
  	[ALC883_3ST_2ch_DIG]	= "3stack-2ch-dig",
***************
*** 8969,8974 ****
--- 9012,9032 ----
  		.input_mux = &alc882_capture_source,
  		.dig_out_nid = ALC882_DIGOUT_NID,
  	},
+ 	[ALC885_MBA21] = {
+ 		.mixers = { alc885_mba21_mixer }, 
+ 		.init_verbs = { alc885_mba21_init_verbs, alc880_gpio1_init_verbs },
+ 		.num_dacs = 2,
+ 		.dac_nids = alc882_dac_nids,
+ 		.hp_nid = 0x04,
+ 		.channel_mode = alc885_mba21_ch_modes,
+ 		.num_channel_mode = ARRAY_SIZE(alc885_mba21_ch_modes),
+ 		.input_mux = &alc882_capture_source,
+ 		.dig_out_nid = ALC882_DIGOUT_NID,
+ 		.dig_in_nid = ALC882_DIGIN_NID,
+ 		.unsol_event = alc_automute_amp_unsol_event,
+ 		.setup = alc885_mba21_setup,
+ 		.init_hook = alc_automute_amp,
+ 	},
  	[ALC885_MBP3] = {
  		.mixers = { alc885_mbp3_mixer, alc882_chmode_mixer },
  		.init_verbs = { alc885_mbp3_init_verbs,
