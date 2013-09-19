From: Adam Williamson <awilliam@redhat.com>
Subject: Re: No sound with Sony VAIO VPCZ1 (ALC889)
Date: Thu, 19 Sep 2013 13:44:42 -0700
Message-ID: <1379623482.2918.4.camel@adam>
References: <51D464A5.6040507@gmail.com> <51D59D60.9020105@gmail.com>
 <51D5FCFC.8010506@gmail.com> <s5hip0pwp49.wl%tiwai@suse.de>
 <51D6B56D.8050909@gmail.com> <s5h1u7dchqh.wl%tiwai@suse.de>
 <020e0ad5107eb4c2bb333468be58d7d3@www.happyassassin.net>
 <51D9F543.2070605@gmail.com>
 <c2cbc2323ce3a8e0df5f52de3ecb276c@www.happyassassin.net>
 <s5hvc4luem4.wl%tiwai@suse.de>
 <46b0590bfa4ffc836dde180f8ffe3c97@www.happyassassin.net>
 <s5hwqoycu0y.wl%tiwai@suse.de> <51DDD53A.8040502@gmail.com>
 <s5hbo69vf4z.wl%tiwai@suse.de> <51DE7B63.7060708@gmail.com>
 <s5hfvvlcs4o.wl%tiwai@suse.de> <51DE9D18.6010304@gmail.com>
 <51E4FD95.2080500@gmail.com> <s5hsizflykp.wl%tiwai@suse.de>
 <51E4FF18.2050208@gmail.com> <s5hoba2n9ve.wl%tiwai@suse.de>
 <51E59331.5000200@gmail.com> <s5hehaymho4.wl%tiwai@suse.de>
 <51E5D5F1.4020101@gmail.com> <s5hzjtllj7n.wl%tiwai@suse.de>
 <1379447519.24293.21.camel@adam> <s5hob7oahfl.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by alsa0.perex.cz (Postfix) with ESMTP id 83CEF261AF9
 for <alsa-devel@alsa-project.org>; Thu, 19 Sep 2013 22:44:47 +0200 (CEST)
In-Reply-To: <s5hob7oahfl.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Tormen <my.nl.abos@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2013-09-19 at 18:45 +0200, Takashi Iwai wrote:
> At Tue, 17 Sep 2013 12:51:59 -0700,
> Adam Williamson wrote:
> > 
> > On Wed, 2013-07-17 at 09:49 +0200, Takashi Iwai wrote:
> > 
> > > > echo "multi_io = no" 
> > > >  >/sys/devices/pci0000:00/0000:00:1b.0/sound/card0/hwC0D0/hints
> > > > echo "1" 
> > > >  >/sys/devices/pci0000:00/0000:00:1b.0/sound/card0/hwC0D0/reconfigure
> > > > 
> > > > http://www.alsa-project.org/db/?f=8494525c7988dc528a45cc1e45134666f3793d7a
> > > > 
> > > >    < Master >
> > > >    Headphone
> > > >    Speaker
> > > >    Mic
> > > >    Mic Boost
> > > >    Mic 1
> > > >    Mic Boost 1
> > > >    Beep
> > > >    Auto-Mute Mode    Enabled
> > > > 
> > > > AT THIS POINT IT WORKED !
> > > > 
> > > > But not automatically though ?!
> > > > I have to manually put in the hint.
> > > 
> > > Hm, so something clears the flag again (or prevents the flag
> > > working).  Could you try to figure out when and where no_multi_io flag
> > > is set and cleared, e.g. by adding printk()s in the code path?
> > 
> > So it looks like things stalled a bit here; if you still need info from
> > someone with an affected system I can try and do it, but you might need
> > to walk me through it / provide patches a bit more than the above, as
> > I'm just a dumb qa monkey :) If you can make it a bit more 'tab a, slot
> > b' I'll try and do the testing. Thanks!
> 
> Could you just try 3.12-rc1?

Sure, I'll get on that and get back to you.

I don't recall if we eventually established exactly how this is
'supposed to' work in the first place, but just in case we didn't, the
'extra' mic is input support on the headphone jack which is intended to
be used for noise cancelling. The system came with earphones that have
mics on the back of each ear, and the Windows install had a special
audio driver which used the input from those mics to do noise
cancelling.

I noticed yesterday PulseAudio can actually do noise cancelling now, so
I think we have the bits in place where we could use this 'as it was
intended to be used', perhaps: the 'extra input' should be available,
and PA should offer an output profile that is 'output over the headphone
jack with noise-cancelling based on input from the headphone jack'. That
would be the 'ideal' setup, I guess. (You can also actually use the
phones successfully as a headset, the mics pick up your own voice when
you talk quite well...)
-- 
Adam Williamson
Fedora QA Community Monkey
IRC: adamw | Twitter: AdamW_Fedora | XMPP: adamw AT happyassassin . net
http://www.happyassassin.net
