From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: Re: [PATCH] ALSA: hda - More pop noise fixes for Dell
	XPS 13 9333
Date: Fri, 08 Aug 2014 17:01:44 +0200
Message-ID: <9843979.89qKloOySd@xps13>
References: <20698834.dnBpTPPJ84@xps13> <2131050.SRuQOBkUIZ@xps13>
 <s5h61i3xp9p.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f47.google.com (mail-wg0-f47.google.com [74.125.82.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 96C9D265056
 for <alsa-devel@alsa-project.org>; Fri,  8 Aug 2014 17:02:07 +0200 (CEST)
Received: by mail-wg0-f47.google.com with SMTP id b13so5788373wgh.30
 for <alsa-devel@alsa-project.org>; Fri, 08 Aug 2014 08:02:07 -0700 (PDT)
In-Reply-To: <s5h61i3xp9p.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Friday 08 August 2014 12:13:38 you wrote:
> At Fri, 08 Aug 2014 10:49:25 +0200,
> Gabriele Mazzotta wrote:
> > 
> > On Friday 08 August 2014 08:11:18 Takashi Iwai wrote:
> > > At Thu, 07 Aug 2014 18:35:39 +0200,
> > > Gabriele Mazzotta wrote:
> > > > 
> > > > On init, mic-in is always set as input source, indipendently on what
> > > > is plugged in. Since setting/unsetting mic-in as input source causes
> > > > a pop noise, make sure the internal microphone is selected as input
> > > > source on boot.
> > > > 
> > > > On shutdown, make sure the codec is not suspended as that would cause
> > > > a pop noise.
> > > > 
> > > > Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
> > > > ---
> > > >  sound/pci/hda/hda_codec.c     |  2 ++
> > > >  sound/pci/hda/hda_codec.h     |  1 +
> > > >  sound/pci/hda/patch_realtek.c | 12 ++++++++++++
> > > >  3 files changed, 15 insertions(+)
> > > > 
> > > > diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
> > > > index 4c20277..92d8292 100644
> > > > --- a/sound/pci/hda/hda_codec.c
> > > > +++ b/sound/pci/hda/hda_codec.c
> > > > @@ -5348,6 +5348,8 @@ void snd_hda_bus_reboot_notify(struct hda_bus *bus)
> > > >  	if (!bus)
> > > >  		return;
> > > >  	list_for_each_entry(codec, &bus->codec_list, list) {
> > > > +		if (codec->resume_at_reboot)
> > > > +			hda_call_codec_resume(codec);
> > > 
> > > Do you really need the resume at reboot?  I thought the codec needs
> > > power down at reboot, i.e. rather it needs suspend.
> > 
> > Yes, the pop noise happens if it's suspended.
> 
> Then the patch is wrong in anyway.  You cannot call it
> unconditionally.  The codec might be still active, and calling resume
> in that state does re-initialize the whole things doubly.

Now I see that it's wrong. In addition, I guess it also breaks the build 
when CONFIG_PM is not set.

> > Now that I payed more attention, the pop noise happens only when 
> > rebooting the laptop and not when powering it down.
> > Also, the noise is heard quite late, I think the kernel is no longer 
> > running when I hear it.
> > I will try to better understand what is actually happening and why
> > resuming prevents the noise.
> 
> If so, it might be BIOS causes the noise by re-initializing the
> codec.

It seems that if 0x15 (Headphone playback switch) is in D0, the pop noise 
cannot be heard.
I tried to see using powertop whether it's worth making the current code more 
complex and force nid 0x15 in D0 only at reboot or not and I couldn't notice 
any major difference. Between 0x02, 0x15 and AFG only the last is causing a 
noticeable difference in the power consumption.

That said, I would simply add 0x15 to alc_power_filter_xps13(). I will send the 
patches soon.

Gabriele

> Takashi
> 
> > > Since you apply actually two individual changes, it's better to split
> > > patches: one for adding the power-down at reboot, another for
> > > initializing cur_mux properly.
> > > 
> > > Also, it's recommended to put a bugzilla link in the changelog, so
> > > that other people can follow the information and discussion.
> > > 
> > > Last but not least, please put maintainers to Cc at the next time, so
> > > that it won't be missed.
> > 
> > I will do it.
> > 
> > Thanks,
> > 
> > Gabriele
> > 
> > > 
> > > thanks,
> > > 
> > > Takashi
> > > 
> > > >  		if (hda_codec_is_power_on(codec) &&
> > > >  		    codec->patch_ops.reboot_notify)
> > > >  			codec->patch_ops.reboot_notify(codec);
> > > > diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
> > > > index 5825aa1..5c3c66e 100644
> > > > --- a/sound/pci/hda/hda_codec.h
> > > > +++ b/sound/pci/hda/hda_codec.h
> > > > @@ -366,6 +366,7 @@ struct hda_codec {
> > > >  	unsigned int cached_write:1;	/* write only to caches */
> > > >  	unsigned int dp_mst:1; /* support DP1.2 Multi-stream transport */
> > > >  	unsigned int dump_coef:1; /* dump processing coefs in codec proc file */
> > > > +	unsigned int resume_at_reboot:1; /* resume codec at reboot */
> > > >  #ifdef CONFIG_PM
> > > >  	unsigned int power_on :1;	/* current (global) power-state */
> > > >  	unsigned int d3_stop_clk:1;	/* support D3 operation without BCLK */
> > > > diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> > > > index b60824e..defaa2a 100644
> > > > --- a/sound/pci/hda/patch_realtek.c
> > > > +++ b/sound/pci/hda/patch_realtek.c
> > > > @@ -4018,8 +4018,20 @@ static void alc_fixup_dell_xps13(struct hda_codec *codec,
> > > >  {
> > > >  	if (action == HDA_FIXUP_ACT_PROBE) {
> > > >  		struct alc_spec *spec = codec->spec;
> > > > +		struct hda_input_mux *imux = &spec->gen.input_mux;
> > > > +		int i;
> > > > +
> > > >  		spec->shutup = alc_no_shutup;
> > > >  		codec->power_filter = alc_power_filter_xps13;
> > > > +		codec->resume_at_reboot = 1;
> > > > +
> > > > +		/* Make the internal mic the default input source. */
> > > > +		for (i = 0; i < imux->num_items; i++) {
> > > > +			if (spec->gen.imux_pins[i] == 0x12) {
> > > > +				spec->gen.cur_mux[0] = i;
> > > > +				break;
> > > > +			}
> > > > +		}
> > > >  	}
> > > >  }
> > > >  
> > > 
> > 
