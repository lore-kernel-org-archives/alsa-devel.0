From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [PATCH] ALSA: HDMI - Enable HBR feature on Intel
	chips
Date: Tue, 28 Aug 2012 00:53:09 -0700
Message-ID: <20120828075309.GA8479@localhost>
References: <1346136381-26087-1-git-send-email-xingchao.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id E3E9A265FAF
 for <alsa-devel@alsa-project.org>; Tue, 28 Aug 2012 09:53:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1346136381-26087-1-git-send-email-xingchao.wang@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Wang Xingchao <xingchao.wang@intel.com>
Cc: tiwai@suse.de, anssi.hannula@iki.fi, alsa-devel@alsa-project.org, alanwww1@xbmc.org
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 28, 2012 at 02:46:21PM +0800, Wang Xingchao wrote:
> HDMI channel remapping apparently effects HBR packets on Intel's chips.
> For compressed non-PCM audio, use "straight-through" channel mapping.
> For uncompressed multi-channel pcm audio, use normal mapping.

Xingchao, have you also tested the legacy 2/5/6/8-channel HDMI PCM playbacks?

> Signed-off-by: Wang Xingchao <xingchao.wang@intel.com>
> Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>
> ---
>  sound/pci/hda/patch_hdmi.c |   50 +++++++++++++++++++++++++++-----------------
>  1 file changed, 31 insertions(+), 19 deletions(-)
> 
> diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
> index d9439c5..fda89e3 100644
> --- a/sound/pci/hda/patch_hdmi.c
> +++ b/sound/pci/hda/patch_hdmi.c
> @@ -231,6 +231,11 @@ static struct cea_channel_speaker_allocation channel_allocations[] = {
>  { .ca_index = 0x01,  .speakers = {   0,    0,   0,   0,   0,  LFE,  FR,  FL } },
>  				 /* Dolby Surround */
>  { .ca_index = 0x02,  .speakers = {   0,    0,   0,   0,  FC,    0,  FR,  FL } },
> +{ .ca_index = 0x03,  .speakers = {   0,    0,   0,   0,  FC,  LFE,  FR,  FL } },
> +{ .ca_index = 0x04,  .speakers = {   0,    0,   0,  RC,   0,    0,  FR,  FL } },
> +{ .ca_index = 0x05,  .speakers = {   0,    0,   0,  RC,   0,  LFE,  FR,  FL } },
> +{ .ca_index = 0x06,  .speakers = {   0,    0,   0,  RC,  FC,    0,  FR,  FL } },
> +{ .ca_index = 0x07,  .speakers = {   0,    0,   0,  RC,  FC,  LFE,  FR,  FL } },

What are you doing here? Please check the comment above
channel_allocations[] for the ordering rule.

>  				 /* surround40 */
>  { .ca_index = 0x08,  .speakers = {   0,    0,  RR,  RL,   0,    0,  FR,  FL } },
>  				 /* surround41 */
> @@ -239,22 +244,15 @@ static struct cea_channel_speaker_allocation channel_allocations[] = {
>  { .ca_index = 0x0a,  .speakers = {   0,    0,  RR,  RL,  FC,    0,  FR,  FL } },
>  				 /* surround51 */
>  { .ca_index = 0x0b,  .speakers = {   0,    0,  RR,  RL,  FC,  LFE,  FR,  FL } },
> -				 /* 6.1 */
> -{ .ca_index = 0x0f,  .speakers = {   0,   RC,  RR,  RL,  FC,  LFE,  FR,  FL } },
> -				 /* surround71 */
> -{ .ca_index = 0x13,  .speakers = { RRC,  RLC,  RR,  RL,  FC,  LFE,  FR,  FL } },
> -
> -{ .ca_index = 0x03,  .speakers = {   0,    0,   0,   0,  FC,  LFE,  FR,  FL } },
> -{ .ca_index = 0x04,  .speakers = {   0,    0,   0,  RC,   0,    0,  FR,  FL } },
> -{ .ca_index = 0x05,  .speakers = {   0,    0,   0,  RC,   0,  LFE,  FR,  FL } },
> -{ .ca_index = 0x06,  .speakers = {   0,    0,   0,  RC,  FC,    0,  FR,  FL } },
> -{ .ca_index = 0x07,  .speakers = {   0,    0,   0,  RC,  FC,  LFE,  FR,  FL } },
>  { .ca_index = 0x0c,  .speakers = {   0,   RC,  RR,  RL,   0,    0,  FR,  FL } },
>  { .ca_index = 0x0d,  .speakers = {   0,   RC,  RR,  RL,   0,  LFE,  FR,  FL } },
>  { .ca_index = 0x0e,  .speakers = {   0,   RC,  RR,  RL,  FC,    0,  FR,  FL } },
> +{ .ca_index = 0x0f,  .speakers = {   0,   RC,  RR,  RL,  FC,  LFE,  FR,  FL } },
>  { .ca_index = 0x10,  .speakers = { RRC,  RLC,  RR,  RL,   0,    0,  FR,  FL } },
>  { .ca_index = 0x11,  .speakers = { RRC,  RLC,  RR,  RL,   0,  LFE,  FR,  FL } },
>  { .ca_index = 0x12,  .speakers = { RRC,  RLC,  RR,  RL,  FC,    0,  FR,  FL } },
> +				 /* surround71 */
> +{ .ca_index = 0x13,  .speakers = { RRC,  RLC,  RR,  RL,  FC,  LFE,  FR,  FL } },
>  { .ca_index = 0x14,  .speakers = { FRC,  FLC,   0,   0,   0,    0,  FR,  FL } },
>  { .ca_index = 0x15,  .speakers = { FRC,  FLC,   0,   0,   0,  LFE,  FR,  FL } },
>  { .ca_index = 0x16,  .speakers = { FRC,  FLC,   0,   0,  FC,    0,  FR,  FL } },
> @@ -537,22 +535,36 @@ static void hdmi_debug_channel_mapping(struct hda_codec *codec,
>  
>  static void hdmi_setup_channel_mapping(struct hda_codec *codec,
>  				       hda_nid_t pin_nid,
> +				       hda_nid_t cvt_nid,
>  				       int ca)
>  {
>  	int i;
>  	int err;
> -
> -	if (hdmi_channel_mapping[ca][1] == 0) {
> -		for (i = 0; i < channel_allocations[ca].channels; i++)
> -			hdmi_channel_mapping[ca][i] = i | (i << 4);
> +	unsigned short val;
> +	int tmp_mapping[8];

Better to use pre-initialized hbr_mapping[] = { ... } and avoid changing code below.

> +	bool non_pcm = false;
> +
> +	val = snd_hda_codec_read(codec, cvt_nid, 0, AC_VERB_GET_DIGI_CONVERT_1, 0);
> +	non_pcm = !!(val & AC_DIG1_NONAUDIO);
> +
> +	if (hdmi_channel_mapping[ca][1] == 0 || non_pcm) {
> +		for (i = 0; i < channel_allocations[ca].channels; i++) {
> +			if (non_pcm)
> +				tmp_mapping[i] = i | (i << 4);
> +			else
> +				hdmi_channel_mapping[ca][i] = i | (i << 4);
> +		}
>  		for (; i < 8; i++)
> -			hdmi_channel_mapping[ca][i] = 0xf | (i << 4);
> +			if (non_pcm)
> +				tmp_mapping[i] = 0xf | (i << 4);
> +			else
> +				hdmi_channel_mapping[ca][i] = 0xf | (i << 4);
>  	}
>  
>  	for (i = 0; i < 8; i++) {
>  		err = snd_hda_codec_write(codec, pin_nid, 0,
>  					  AC_VERB_SET_HDMI_CHAN_SLOT,
> -					  hdmi_channel_mapping[ca][i]);
> +					  non_pcm ? tmp_mapping[i] : hdmi_channel_mapping[ca][i]);
>  		if (err) {
>  			snd_printdd(KERN_NOTICE
>  				    "HDMI: channel mapping failed\n");
> @@ -686,7 +698,7 @@ static bool hdmi_infoframe_uptodate(struct hda_codec *codec, hda_nid_t pin_nid,
>  }
>  
>  static void hdmi_setup_audio_infoframe(struct hda_codec *codec, int pin_idx,
> -					struct snd_pcm_substream *substream)
> +					hda_nid_t cvt_nid, struct snd_pcm_substream *substream)
>  {
>  	struct hdmi_spec *spec = codec->spec;
>  	struct hdmi_spec_per_pin *per_pin = &spec->pins[pin_idx];
> @@ -731,13 +743,13 @@ static void hdmi_setup_audio_infoframe(struct hda_codec *codec, int pin_idx,
>  	 * sizeof(*dp_ai) to avoid partial match/update problems when
>  	 * the user switches between HDMI/DP monitors.
>  	 */
> +	hdmi_setup_channel_mapping(codec, pin_nid, cvt_nid, ca);
>  	if (!hdmi_infoframe_uptodate(codec, pin_nid, ai.bytes,
>  					sizeof(ai))) {
>  		snd_printdd("hdmi_setup_audio_infoframe: "
>  			    "pin=%d channels=%d\n",
>  			    pin_nid,
>  			    channels);
> -		hdmi_setup_channel_mapping(codec, pin_nid, ca);

Why move hdmi_setup_channel_mapping() up? This might re-introduce the
half-second silence bug. Please do retest if you really need the move.

Background info:

commit ef18beded8ddbaafdf4914bab209f77e60ae3a18
Author: Wu Fengguang <fengguang.wu@intel.com>
Date:   Fri Dec 25 13:14:27 2009 +0800

    ALSA: hda - HDMI sticky stream tag support
    
    When we run the following commands in turn (with
    CONFIG_SND_HDA_POWER_SAVE_DEFAULT=0),
    
        speaker-test -Dhw:0,3 -c2 -twav  # HDMI
        speaker-test -Dhw:0,0 -c2 -twav  # Analog
    
    The second command will produce sound in the analog lineout _as well as_
    HDMI sink. The root cause is, device 0 "reuses" the same stream tag that
    was used by device 3, and the "intelhdmi - sticky stream id" patch leaves
    the HDMI codec in a functional state. So the HDMI codec happily accepts
    the audio samples which reuse its stream tag.
    
    The proposed solution is to remember the last device each azx_dev was
    assigned to, and prefer to
    1) reuse the azx_dev (and hence the stream tag) the HDMI codec last used
    2) or assign a never-used azx_dev for HDMI
    
    With this patch and the above two speaker-test commands,
    HDMI codec will use stream tag 8 and Analog codec will use 5.
    
    The stream tag used by HDMI codec won't be reused by others, as long
    as we don't run out of the 4 playback azx_dev's. The legacy Analog
    codec will continue to use stream tag 5 because its device id is 0
    (this is a bit tricky).

>  		hdmi_stop_infoframe_trans(codec, pin_nid);
>  		hdmi_fill_audio_infoframe(codec, pin_nid,
>  					    ai.bytes, sizeof(ai));
> @@ -1151,7 +1163,7 @@ static int generic_hdmi_playback_pcm_prepare(struct hda_pcm_stream *hinfo,
>  
>  	hdmi_set_channel_count(codec, cvt_nid, substream->runtime->channels);
>  
> -	hdmi_setup_audio_infoframe(codec, pin_idx, substream);
> +	hdmi_setup_audio_infoframe(codec, pin_idx, cvt_nid, substream);
>  
>  	pinctl = snd_hda_codec_read(codec, pin_nid, 0,
>  				    AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
> -- 
> 1.7.9.5
