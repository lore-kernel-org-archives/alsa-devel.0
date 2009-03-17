From: Andreas Mohr <andi-5+Cda9B46AM@public.gmane.org>
Subject: Re: [alsa-devel] Bugs on aspire one A150
Date: Tue, 17 Mar 2009 17:18:28 +0100
Message-ID: <20090317161828.GA32756@rhlx01.hs-esslingen.de>
References: <20090316173000.GA25647@rhlx01.hs-esslingen.de> <s5hiqm9pe1g.wl%tiwai@suse.de> <20090316180638.GB25647@rhlx01.hs-esslingen.de> <s5htz5tyzyg.wl%tiwai@suse.de> <20090316212227.GA29471@rhlx01.hs-esslingen.de> <s5hfxhczinh.wl%tiwai@suse.de> <20090317100500.GA16029@rhlx01.hs-esslingen.de> <20090317103845.GA26007@rhlx01.hs-esslingen.de> <20090317104755.GA1446@rhlx01.hs-esslingen.de> <s5h3adcpf1i.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <s5h3adcpf1i.wl%tiwai-l3A5Bk7waGM@public.gmane.org>
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
Cc: Andreas Mohr <andi-5+Cda9B46AM@public.gmane.org>, Maxim Levitsky <maximlevitsky-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Kernel Testers List <kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Hi,

On Tue, Mar 17, 2009 at 12:25:13PM +0100, Takashi Iwai wrote:
> At Tue, 17 Mar 2009 11:47:55 +0100,
> Andreas Mohr wrote:
> > > Fortemedia device names include FM2018-380, not sure yet which one is in
> > > Aspire One.
> > > 
> > > http://www.fortemedia.com/products/index.htm
> > > ( especially http://www.fortemedia.com/products/fm1182.htm )
> > 
> > http://www.wpgholdings.com/event/S/SACg_04_ForteMedia_SAM.pdf
> > mentions "FM201x" and www.sacg.com.tw (this one could be useful!).
> > Searching Google "FM201[0-9] Fortemedia" comes up with FM2010 and
> > FM2018 and thus
> > http://www.hengdasheng.com.cn/uploadfile/391/cfile/2008102414057847.pdf
> > which is a relatively informative datasheet.
> 
> I'm not sure whether FM2018 is on a netbook.  Rather my guess is it's
> a digital-mic component by FortMedia together with their software
> library for SAM handling.

I had the same thoughts later. Since they use an extensive SAM handling
library, there probably isn't such a chip, otherwise they probably
wouldn't need it ;)
Could you thus implement a nice beam-forming sound evaluation SAM
library for ALSA pretty pretty please? ;)
...or, is that SAM library available to us given that it exists in the
factory install? If so, then one should probably make good use of it...

> BTW, a simple "fix" for the mono capture problem, you can patch
> the config file for HD-audio in alsa-lib like below.  Then the first
> channel will be used for mono capture instead of averages.
> Give it a try.
> 
> (But, this won't fix programs that prefer "hw" access such as
>  pulseaudio, of course.)

I'm not *quite* sure whether this is really what you meant,
but I patched /usr/share/alsa/cards/HDA-Intel.conf (libasound2
1.0.18-1ubuntu7) in exactly this way and then did
arecord -Dplughw:0 -fdat -c1 test.wav; aplay test.wav
but well, with equal slider positions there was no audio again.

Andreas
