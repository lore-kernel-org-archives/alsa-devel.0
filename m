From: Stephen Warren <swarren@nvidia.com>
Subject: Re: Support MCP89 hdmi audio
Date: Fri, 30 Jul 2010 10:36:37 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF02FD6DF17B@HQMAIL01.nvidia.com>
References: <6B4D417B830BC44B8026029FD256F7F1C29D065C70@HKMAIL01.nvidia.com>
	<s5hr5ix2dzb.wl%tiwai@suse.de>
	<6B4D417B830BC44B8026029FD256F7F1C29D065C72@HKMAIL01.nvidia.com>
	<6B4D417B830BC44B8026029FD256F7F1C29D065C7E@HKMAIL01.nvidia.com>
	<s5h39v4vskw.wl%tiwai@suse.de>
	<6B4D417B830BC44B8026029FD256F7F1C29D065C86@HKMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 82F1D243FC
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Jul 2010 19:36:21 +0200 (CEST)
In-Reply-To: <6B4D417B830BC44B8026029FD256F7F1C29D065C86@HKMAIL01.nvidia.com>
Content-Language: en-US
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
Cc: 'alsa-devel' <alsa-devel@alsa-project.org>, Wei Ni <wni@nvidia.com>
List-Id: alsa-devel@alsa-project.org

Takashi,

I also work for NVIDIA and am starting to work on some audio-related issues.

I'd like to get familiar with the flow of patches; where things get applied
first and how they flow to public ALSA and kernel repositories, so:

I see the patch below has shown up in the snapshots at:

ftp://ftp.kernel.org/pub/linux/kernel/people/tiwai/alsa/alsa-driver/

What repository is that a snapshot of; a private repository of yours?

However, I can't find the patch anywhere at:

http://git.alsa-project.org/

I'm mainly asking, because I want to work with distro kernel maintainers to
get this patch into distros, rather than waiting for new distro versions to ship,
which even then might not pick up a kernel with this patch the first time around.
However, before I do that, I need to find a sane public upstream location that
shows the patch is acceptable upstream.

Thanks for any pointers. Apologies if this is already documented somewhere,
although I couldn't see anything obvious on alsa-project.org.

Wei Ni wrote:
> Sent: Wednesday, July 28, 2010 5:30 AM
> Subject: RE: Support MCP89 hdmi audio
> 
> Hi, Takashi
> Sorry, it's later to reply.
> Yes, this patch is fine, I think it could be checked in.
> 
...
> Takashi Iwai wrote:
> > Sent: Wednesday, July 21, 2010 8:53 PM
> > Subject: Re: Support MCP89 hdmi audio
> > ...
> > Yes.  The patch below does similar thing.
> > Could you give it a try?
> >
> > ---
> > diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
> > index 86067ee..2fc5396 100644
> > --- a/sound/pci/hda/patch_hdmi.c
> > +++ b/sound/pci/hda/patch_hdmi.c
> > @@ -52,6 +52,10 @@ struct hdmi_spec {
> >  	 */
> >  	struct hda_multi_out multiout;
> >  	unsigned int codec_type;
> > +
> > +	/* misc flags */
> > +	/* PD bit indicates only the update, not the current state */
> > +	unsigned int old_pin_detect:1;
> >  };
> >
> >
> > @@ -616,6 +620,9 @@ static void hdmi_setup_audio_infoframe(struct hda_codec *codec, hda_nid_t nid,
> >   * Unsolicited events
> >   */
> >
> > +static void hdmi_present_sense(struct hda_codec *codec, hda_nid_t pin_nid,
> > +			       struct hdmi_eld *eld);
> > +
> >  static void hdmi_intrinsic_event(struct hda_codec *codec, unsigned int res)
> >  {
> >  	struct hdmi_spec *spec = codec->spec;
> > @@ -632,6 +639,12 @@ static void hdmi_intrinsic_event(struct hda_codec *codec, unsigned int res)
> >  	if (index < 0)
> >  		return;
> >
> > +	if (spec->old_pin_detect) {
> > +		if (pind)
> > +			hdmi_present_sense(codec, tag, &spec->sink_eld[index]);
> > +		pind = spec->sink_eld[index].monitor_present;
> > +	}
> > +
> >  	spec->sink_eld[index].monitor_present = pind;
> >  	spec->sink_eld[index].eld_valid = eldv;
> >
> > diff --git a/sound/pci/hda/patch_nvhdmi.c b/sound/pci/hda/patch_nvhdmi.c
> > index 3c10c0b..b0652ac 100644
> > --- a/sound/pci/hda/patch_nvhdmi.c
> > +++ b/sound/pci/hda/patch_nvhdmi.c
> > @@ -478,6 +478,7 @@ static int patch_nvhdmi_8ch_89(struct hda_codec *codec)
> >
> >  	codec->spec = spec;
> >  	spec->codec_type = HDA_CODEC_NVIDIA_MCP89;
> > +	spec->old_pin_detect = 1;
> >
> >  	if (hdmi_parse_codec(codec) < 0) {
> >  		codec->spec = NULL;
> > @@ -508,6 +509,7 @@ static int patch_nvhdmi_8ch_7x(struct hda_codec *codec)
> >  	spec->multiout.max_channels = 8;
> >  	spec->multiout.dig_out_nid = nvhdmi_master_con_nid_7x;
> >  	spec->codec_type = HDA_CODEC_NVIDIA_MCP7X;
> > +	spec->old_pin_detect = 1;
> >
> >  	codec->patch_ops = nvhdmi_patch_ops_8ch_7x;
> >
> > @@ -528,6 +530,7 @@ static int patch_nvhdmi_2ch(struct hda_codec *codec)
> >  	spec->multiout.max_channels = 2;
> >  	spec->multiout.dig_out_nid = nvhdmi_master_con_nid_7x;
> >  	spec->codec_type = HDA_CODEC_NVIDIA_MCP7X;
> > +	spec->old_pin_detect = 1;
> >
> >  	codec->patch_ops = nvhdmi_patch_ops_2ch;

-- 
nvpublic
