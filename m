From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: [PATCH v2] hda: add IbexPeak/Clarkdale HDMI model
	with static	cvt/pin number
Date: Mon, 3 Aug 2009 14:59:10 +0800
Message-ID: <20090803065910.GA10219@localhost>
References: <20090801122700.GA17330@localhost>
	<20090802084855.GA22895@localhost> <s5hvdl58k5u.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 5E92B245F9
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Aug 2009 08:59:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hvdl58k5u.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Jaroslav Kysela <jkysela@redhat.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 03, 2009 at 02:51:25PM +0800, Takashi Iwai wrote:
> At Sun, 2 Aug 2009 16:48:55 +0800,
> Wu Fengguang wrote:
> > 
> > The new IbexPeak HDMI codec has 3 pin nodes and 2 converter nodes.
> > Here we assume only the first ones will be used.
> > 
> > Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
> > ---
> > 
> > Comparing with v1, the only change is the rename of codec from "P55"
> > to "Q57". The dynamic data structure will be introduced by future
> > patches.
> 
> OK, applied now.

Thank you!

> The needed change would be pretty easy, just change cvt_nid to
> spec->cvt_nid, etc...

Ah OK. I'll put the members into intel_hdmi_spec instead of the
planned hda_codec.

Thanks,
Fengguang

> > 
> >  sound/pci/hda/patch_intelhdmi.c |  104 +++++++++++++++---------------
> >  1 file changed, 52 insertions(+), 52 deletions(-)
> > 
> > --- sound-2.6.orig/sound/pci/hda/patch_intelhdmi.c
> > +++ sound-2.6/sound/pci/hda/patch_intelhdmi.c
> > @@ -33,8 +33,8 @@
> >  #include "hda_codec.h"
> >  #include "hda_local.h"
> >  
> > -#define CVT_NID		0x02	/* audio converter */
> > -#define PIN_NID		0x03	/* HDMI output pin */
> > +static hda_nid_t cvt_nid;	/* audio converter */
> > +static hda_nid_t pin_nid;	/* HDMI output pin */
> >  
> >  #define INTEL_HDMI_EVENT_TAG		0x08
> >  
> > @@ -44,30 +44,6 @@ struct intel_hdmi_spec {
> >  	struct hdmi_eld sink_eld;
> >  };
> >  
> > -static struct hda_verb pinout_enable_verb[] = {
> > -	{PIN_NID, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
> > -	{} /* terminator */
> > -};
> > -
> > -static struct hda_verb unsolicited_response_verb[] = {
> > -	{PIN_NID, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN |
> > -						  INTEL_HDMI_EVENT_TAG},
> > -	{}
> > -};
> > -
> > -static struct hda_verb def_chan_map[] = {
> > -	{CVT_NID, AC_VERB_SET_HDMI_CHAN_SLOT, 0x00},
> > -	{CVT_NID, AC_VERB_SET_HDMI_CHAN_SLOT, 0x11},
> > -	{CVT_NID, AC_VERB_SET_HDMI_CHAN_SLOT, 0x22},
> > -	{CVT_NID, AC_VERB_SET_HDMI_CHAN_SLOT, 0x33},
> > -	{CVT_NID, AC_VERB_SET_HDMI_CHAN_SLOT, 0x44},
> > -	{CVT_NID, AC_VERB_SET_HDMI_CHAN_SLOT, 0x55},
> > -	{CVT_NID, AC_VERB_SET_HDMI_CHAN_SLOT, 0x66},
> > -	{CVT_NID, AC_VERB_SET_HDMI_CHAN_SLOT, 0x77},
> > -	{}
> > -};
> > -
> > -
> >  struct hdmi_audio_infoframe {
> >  	u8 type; /* 0x84 */
> >  	u8 ver;  /* 0x01 */
> > @@ -244,11 +220,12 @@ static void hdmi_write_dip_byte(struct h
> >  static void hdmi_enable_output(struct hda_codec *codec)
> >  {
> >  	/* Unmute */
> > -	if (get_wcaps(codec, PIN_NID) & AC_WCAP_OUT_AMP)
> > -		snd_hda_codec_write(codec, PIN_NID, 0,
> > +	if (get_wcaps(codec, pin_nid) & AC_WCAP_OUT_AMP)
> > +		snd_hda_codec_write(codec, pin_nid, 0,
> >  				AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE);
> >  	/* Enable pin out */
> > -	snd_hda_sequence_write(codec, pinout_enable_verb);
> > +	snd_hda_codec_write(codec, pin_nid, 0,
> > +			    AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT);
> >  }
> >  
> >  /*
> > @@ -256,8 +233,8 @@ static void hdmi_enable_output(struct hd
> >   */
> >  static void hdmi_start_infoframe_trans(struct hda_codec *codec)
> >  {
> > -	hdmi_set_dip_index(codec, PIN_NID, 0x0, 0x0);
> > -	snd_hda_codec_write(codec, PIN_NID, 0, AC_VERB_SET_HDMI_DIP_XMIT,
> > +	hdmi_set_dip_index(codec, pin_nid, 0x0, 0x0);
> > +	snd_hda_codec_write(codec, pin_nid, 0, AC_VERB_SET_HDMI_DIP_XMIT,
> >  						AC_DIPXMIT_BEST);
> >  }
> >  
> > @@ -266,20 +243,20 @@ static void hdmi_start_infoframe_trans(s
> >   */
> >  static void hdmi_stop_infoframe_trans(struct hda_codec *codec)
> >  {
> > -	hdmi_set_dip_index(codec, PIN_NID, 0x0, 0x0);
> > -	snd_hda_codec_write(codec, PIN_NID, 0, AC_VERB_SET_HDMI_DIP_XMIT,
> > +	hdmi_set_dip_index(codec, pin_nid, 0x0, 0x0);
> > +	snd_hda_codec_write(codec, pin_nid, 0, AC_VERB_SET_HDMI_DIP_XMIT,
> >  						AC_DIPXMIT_DISABLE);
> >  }
> >  
> >  static int hdmi_get_channel_count(struct hda_codec *codec)
> >  {
> > -	return 1 + snd_hda_codec_read(codec, CVT_NID, 0,
> > +	return 1 + snd_hda_codec_read(codec, cvt_nid, 0,
> >  					AC_VERB_GET_CVT_CHAN_COUNT, 0);
> >  }
> >  
> >  static void hdmi_set_channel_count(struct hda_codec *codec, int chs)
> >  {
> > -	snd_hda_codec_write(codec, CVT_NID, 0,
> > +	snd_hda_codec_write(codec, cvt_nid, 0,
> >  					AC_VERB_SET_CVT_CHAN_COUNT, chs - 1);
> >  
> >  	if (chs != hdmi_get_channel_count(codec))
> > @@ -294,7 +271,7 @@ static void hdmi_debug_channel_mapping(s
> >  	int slot;
> >  
> >  	for (i = 0; i < 8; i++) {
> > -		slot = snd_hda_codec_read(codec, CVT_NID, 0,
> > +		slot = snd_hda_codec_read(codec, cvt_nid, 0,
> >  						AC_VERB_GET_HDMI_CHAN_SLOT, i);
> >  		printk(KERN_DEBUG "HDMI: ASP channel %d => slot %d\n",
> >  						slot >> 4, slot & 0x7);
> > @@ -307,7 +284,7 @@ static void hdmi_parse_eld(struct hda_co
> >  	struct intel_hdmi_spec *spec = codec->spec;
> >  	struct hdmi_eld *eld = &spec->sink_eld;
> >  
> > -	if (!snd_hdmi_get_eld(eld, codec, PIN_NID))
> > +	if (!snd_hdmi_get_eld(eld, codec, pin_nid))
> >  		snd_hdmi_show_eld(eld);
> >  }
> >  
> > @@ -322,11 +299,11 @@ static void hdmi_debug_dip_size(struct h
> >  	int i;
> >  	int size;
> >  
> > -	size = snd_hdmi_get_eld_size(codec, PIN_NID);
> > +	size = snd_hdmi_get_eld_size(codec, pin_nid);
> >  	printk(KERN_DEBUG "HDMI: ELD buf size is %d\n", size);
> >  
> >  	for (i = 0; i < 8; i++) {
> > -		size = snd_hda_codec_read(codec, PIN_NID, 0,
> > +		size = snd_hda_codec_read(codec, pin_nid, 0,
> >  						AC_VERB_GET_HDMI_DIP_SIZE, i);
> >  		printk(KERN_DEBUG "HDMI: DIP GP[%d] buf size is %d\n", i, size);
> >  	}
> > @@ -340,15 +317,15 @@ static void hdmi_clear_dip_buffers(struc
> >  	int size;
> >  	int pi, bi;
> >  	for (i = 0; i < 8; i++) {
> > -		size = snd_hda_codec_read(codec, PIN_NID, 0,
> > +		size = snd_hda_codec_read(codec, pin_nid, 0,
> >  						AC_VERB_GET_HDMI_DIP_SIZE, i);
> >  		if (size == 0)
> >  			continue;
> >  
> > -		hdmi_set_dip_index(codec, PIN_NID, i, 0x0);
> > +		hdmi_set_dip_index(codec, pin_nid, i, 0x0);
> >  		for (j = 1; j < 1000; j++) {
> > -			hdmi_write_dip_byte(codec, PIN_NID, 0x0);
> > -			hdmi_get_dip_index(codec, PIN_NID, &pi, &bi);
> > +			hdmi_write_dip_byte(codec, pin_nid, 0x0);
> > +			hdmi_get_dip_index(codec, pin_nid, &pi, &bi);
> >  			if (pi != i)
> >  				snd_printd(KERN_INFO "dip index %d: %d != %d\n",
> >  						bi, pi, i);
> > @@ -376,9 +353,9 @@ static void hdmi_fill_audio_infoframe(st
> >  		sum += params[i];
> >  	ai->checksum = - sum;
> >  
> > -	hdmi_set_dip_index(codec, PIN_NID, 0x0, 0x0);
> > +	hdmi_set_dip_index(codec, pin_nid, 0x0, 0x0);
> >  	for (i = 0; i < sizeof(ai); i++)
> > -		hdmi_write_dip_byte(codec, PIN_NID, params[i]);
> > +		hdmi_write_dip_byte(codec, pin_nid, params[i]);
> >  }
> >  
> >  /*
> > @@ -465,6 +442,8 @@ static int hdmi_setup_channel_allocation
> >  static void hdmi_setup_channel_mapping(struct hda_codec *codec,
> >  					struct hdmi_audio_infoframe *ai)
> >  {
> > +	int i;
> > +
> >  	if (!ai->CA)
> >  		return;
> >  
> > @@ -473,7 +452,11 @@ static void hdmi_setup_channel_mapping(s
> >  	 * ALSA sequence is front/surr/clfe/side?
> >  	 */
> >  
> > -	snd_hda_sequence_write(codec, def_chan_map);
> > +	for (i = 0; i < 8; i++)
> > +		snd_hda_codec_write(codec, cvt_nid, 0,
> > +				    AC_VERB_SET_HDMI_CHAN_SLOT,
> > +				    (i << 4) | i);
> > +
> >  	hdmi_debug_channel_mapping(codec);
> >  }
> >  
> > @@ -597,7 +580,6 @@ static struct hda_pcm_stream intel_hdmi_
> >  	.substreams = 1,
> >  	.channels_min = 2,
> >  	.channels_max = 8,
> > -	.nid = CVT_NID, /* NID to query formats and rates and setup streams */
> >  	.ops = {
> >  		.open    = intel_hdmi_playback_pcm_open,
> >  		.close   = intel_hdmi_playback_pcm_close,
> > @@ -613,6 +595,9 @@ static int intel_hdmi_build_pcms(struct 
> >  	codec->num_pcms = 1;
> >  	codec->pcm_info = info;
> >  
> > +	/* NID to query formats and rates and setup streams */
> > +	intel_hdmi_pcm_playback.nid = cvt_nid;
> > +
> >  	info->name = "INTEL HDMI";
> >  	info->pcm_type = HDA_PCM_TYPE_HDMI;
> >  	info->stream[SNDRV_PCM_STREAM_PLAYBACK] = intel_hdmi_pcm_playback;
> > @@ -636,8 +621,9 @@ static int intel_hdmi_init(struct hda_co
> >  {
> >  	hdmi_enable_output(codec);
> >  
> > -	snd_hda_sequence_write(codec, unsolicited_response_verb);
> > -
> > +	snd_hda_codec_write(codec, pin_nid, 0,
> > +			    AC_VERB_SET_UNSOLICITED_ENABLE,
> > +			    AC_USRSP_EN | INTEL_HDMI_EVENT_TAG);
> >  	return 0;
> >  }
> >  
> > @@ -657,7 +643,7 @@ static struct hda_codec_ops intel_hdmi_p
> >  	.unsol_event		= intel_hdmi_unsol_event,
> >  };
> >  
> > -static int patch_intel_hdmi(struct hda_codec *codec)
> > +static int do_patch_intel_hdmi(struct hda_codec *codec)
> >  {
> >  	struct intel_hdmi_spec *spec;
> >  
> > @@ -667,7 +653,7 @@ static int patch_intel_hdmi(struct hda_c
> >  
> >  	spec->multiout.num_dacs = 0;	  /* no analog */
> >  	spec->multiout.max_channels = 8;
> > -	spec->multiout.dig_out_nid = CVT_NID;
> > +	spec->multiout.dig_out_nid = cvt_nid;
> >  
> >  	codec->spec = spec;
> >  	codec->patch_ops = intel_hdmi_patch_ops;
> > @@ -679,13 +665,27 @@ static int patch_intel_hdmi(struct hda_c
> >  	return 0;
> >  }
> >  
> > +static int patch_intel_hdmi(struct hda_codec *codec)
> > +{
> > +	cvt_nid = 0x02;
> > +	pin_nid = 0x03;
> > +	return do_patch_intel_hdmi(codec);
> > +}
> > +
> > +static int patch_intel_hdmi_ibexpeak(struct hda_codec *codec)
> > +{
> > +	cvt_nid = 0x02;
> > +	pin_nid = 0x04;
> > +	return do_patch_intel_hdmi(codec);
> > +}
> > +
> >  static struct hda_codec_preset snd_hda_preset_intelhdmi[] = {
> >  	{ .id = 0x808629fb, .name = "G45 DEVCL",  .patch = patch_intel_hdmi },
> >  	{ .id = 0x80862801, .name = "G45 DEVBLC", .patch = patch_intel_hdmi },
> >  	{ .id = 0x80862802, .name = "G45 DEVCTG", .patch = patch_intel_hdmi },
> >  	{ .id = 0x80862803, .name = "G45 DEVELK", .patch = patch_intel_hdmi },
> >  	{ .id = 0x80862804, .name = "G45 DEVIBX", .patch = patch_intel_hdmi },
> > -	{ .id = 0x80860054, .name = "G45 DEVIBX", .patch = patch_intel_hdmi },
> > +	{ .id = 0x80860054, .name = "Q57 DEVIBX", .patch = patch_intel_hdmi_ibexpeak },
> >  	{ .id = 0x10951392, .name = "SiI1392 HDMI",     .patch = patch_intel_hdmi },
> >  	{} /* terminator */
> >  };
> > 
