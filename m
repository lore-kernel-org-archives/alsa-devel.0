From: "Wang, Xingchao" <xingchao.wang@intel.com>
Subject: Re: [PATCH] ALSA: hda - Set channels count for
	HBR	format
Date: Tue, 7 Aug 2012 08:03:08 +0000
Message-ID: <46B810F6945F7C4788E11DCE57EC48900FF42444@SHSMSX102.ccr.corp.intel.com>
References: <1344324022-17310-1-git-send-email-xingchao.wang@intel.com>
 <46B810F6945F7C4788E11DCE57EC48900FF42416@SHSMSX102.ccr.corp.intel.com>
 <s5h628vi1ka.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 47C00265E43
 for <alsa-devel@alsa-project.org>; Tue,  7 Aug 2012 09:33:30 +0200 (CEST)
In-Reply-To: <s5h628vi1ka.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org



> -----Original Message-----
> From: alsa-devel-bounces@alsa-project.org
> [mailto:alsa-devel-bounces@alsa-project.org] On Behalf Of Takashi Iwai
> Sent: Tuesday, August 07, 2012 3:50 PM
> To: Wang, Xingchao
> Cc: alsa-devel@alsa-project.org
> Subject: Re: [alsa-devel] [PATCH] ALSA: hda - Set channels count for HBR format
> 
> At Tue, 7 Aug 2012 07:40:40 +0000,
> Wang, Xingchao wrote:
> >
> > Hi Takashi,
> >
> > When test HBR feature, unless specify the channel number in command
> line(as below), alsa will be confused about the real channel number.
> >
> > aplay -D hdmi:DEV=1,AES0=0x06 -c8 -fs16_le -r192000
> > testi.dtshd.20120730.ma-71-24.spdif
> 
> But is_hbr_format() assumes the channels must be 8.
> 
> #define is_hbr_format(format) \
> 	((format & AC_FMT_TYPE_NON_PCM) && (format &
> AC_FMT_CHAN_MASK) == 7)
> 
> where format value is computed from runtime->channels in
> snd_hda_calc_stream_format().

Oh yes, thanks for clarification, I did not read this code carefully. :) 
I thought the case without setting channels number as 8 from pulseaudio and it's HBR stream in fact.

I've not test HBR stream playback from pulseaduio pass-through mode yet, when that happen and I will 
Write a new patch then.

So this patch is redundant, just ignore it.

Thanks
--xingchao
> 
> So, passing anything else than 8 is simply invalid as HBR.
> 
> > If the HBR stream is gone through pulseaudio(regarded as passthrough), the
> channels number is faked.
> 
> That is, this is simply a wrong operation.
> 
> 
> Takashi
> 
> >
> > Thanks
> > --xingchao
> >
> > > -----Original Message-----
> > > From: alsa-devel-bounces@alsa-project.org
> > > [mailto:alsa-devel-bounces@alsa-project.org] On Behalf Of Wang
> > > Xingchao
> > > Sent: Tuesday, August 07, 2012 3:20 PM
> > > To: alsa-devel@alsa-project.org; tiwai@suse.de
> > > Cc: Wang, Xingchao
> > > Subject: [alsa-devel] [PATCH] ALSA: hda - Set channels count for HBR
> > > format
> > >
> > > If it's HBR format, the channels count should be 8.
> > >
> > > Signed-off-by: Wang Xingchao <xingchao.wang@intel.com>
> > > ---
> > >  sound/pci/hda/patch_hdmi.c |    7 +++++--
> > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
> > > index ad319d4..ae4e67e 100644
> > > --- a/sound/pci/hda/patch_hdmi.c
> > > +++ b/sound/pci/hda/patch_hdmi.c
> > > @@ -1153,8 +1153,11 @@ static int
> > > generic_hdmi_playback_pcm_prepare(struct hda_pcm_stream *hinfo,
> > >  	struct hdmi_spec *spec = codec->spec;
> > >  	int pin_idx = hinfo_to_pin_index(spec, hinfo);
> > >  	hda_nid_t pin_nid = spec->pins[pin_idx].pin_nid;
> > > -
> > > -	hdmi_set_channel_count(codec, cvt_nid, substream->runtime->channels);
> > > +
> > > +	if (is_hbr_format(format))
> > > +		hdmi_set_channel_count(codec, cvt_nid, 8);
> > > +	else
> > > +		hdmi_set_channel_count(codec, cvt_nid,
> > > substream->runtime->channels);
> > >
> > >  	hdmi_setup_audio_infoframe(codec, pin_idx, substream);
> > >
> > > --
> > > 1.7.9.5
> > >
> > > _______________________________________________
> > > Alsa-devel mailing list
> > > Alsa-devel@alsa-project.org
> > > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> >
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
