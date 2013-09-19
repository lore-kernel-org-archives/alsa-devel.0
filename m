From: Adam Williamson <awilliam@redhat.com>
Subject: Re: No sound with Sony VAIO VPCZ1 (ALC889)
Date: Thu, 19 Sep 2013 15:10:23 -0700
Message-ID: <1379628623.2918.13.camel@adam>
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
 <1379623482.2918.4.camel@adam>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by alsa0.perex.cz (Postfix) with ESMTP id E3DD4261B1C
 for <alsa-devel@alsa-project.org>; Fri, 20 Sep 2013 00:10:27 +0200 (CEST)
In-Reply-To: <1379623482.2918.4.camel@adam>
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

On Thu, 2013-09-19 at 13:44 -0700, Adam Williamson wrote:
> On Thu, 2013-09-19 at 18:45 +0200, Takashi Iwai wrote:
> > At Tue, 17 Sep 2013 12:51:59 -0700,
> > Adam Williamson wrote:
> > > 
> > > On Wed, 2013-07-17 at 09:49 +0200, Takashi Iwai wrote:
> > > 
> > > > > echo "multi_io = no" 
> > > > >  >/sys/devices/pci0000:00/0000:00:1b.0/sound/card0/hwC0D0/hints
> > > > > echo "1" 
> > > > >  >/sys/devices/pci0000:00/0000:00:1b.0/sound/card0/hwC0D0/reconfigure
> > > > > 
> > > > > http://www.alsa-project.org/db/?f=8494525c7988dc528a45cc1e45134666f3793d7a
> > > > > 
> > > > >    < Master >
> > > > >    Headphone
> > > > >    Speaker
> > > > >    Mic
> > > > >    Mic Boost
> > > > >    Mic 1
> > > > >    Mic Boost 1
> > > > >    Beep
> > > > >    Auto-Mute Mode    Enabled
> > > > > 
> > > > > AT THIS POINT IT WORKED !
> > > > > 
> > > > > But not automatically though ?!
> > > > > I have to manually put in the hint.
> > > > 
> > > > Hm, so something clears the flag again (or prevents the flag
> > > > working).  Could you try to figure out when and where no_multi_io flag
> > > > is set and cleared, e.g. by adding printk()s in the code path?
> > > 
> > > So it looks like things stalled a bit here; if you still need info from
> > > someone with an affected system I can try and do it, but you might need
> > > to walk me through it / provide patches a bit more than the above, as
> > > I'm just a dumb qa monkey :) If you can make it a bit more 'tab a, slot
> > > b' I'll try and do the testing. Thanks!
> > 
> > Could you just try 3.12-rc1?
> 
> Sure, I'll get on that and get back to you.

3.12 RC1:

Internal speaker playback works
Headphone playback works
Internal mic is available as an input and works

Dedicated mic jack is NOT available as an input in GNOME control center
Input line from headphone/headset jack is NOT available as an input in
GNOME control center

pavucontrol shows Internal Microphone and Microphone inputs. If I plug
my headset into the dedicated mic jack, set the pavucontrol input to
Microphone, and fiddle with the headset, I see the volume levels
bouncing around, so it looks like that is the dedicated mic jack and it
works. There does not appear to be any input channel in PA that maps to
the input line from the headphone/headset jack. Jack sensing works -
input switches between "Microphone" and "Internal Microphone" as I plug
and unplug something from the dedicated mic jack.

alsamixer shows 'Mic', 'Mic 1' and 'Internal Mic' inputs; I can't get
pavucontrol to show any input level from a headset plugged into the
headset/headphone jack no matter how I twiddle with it, though.

Overall looking pretty good except for a bug in the GNOME control panel
applet for sound and the lack of handling of the input line from the
headphone/headset jack (I don't know if this ever worked in the past,
anyway, I only finally figured out what all the inputs actually are in
the context of this thread).
-- 
Adam Williamson
Fedora QA Community Monkey
IRC: adamw | Twitter: AdamW_Fedora | XMPP: adamw AT happyassassin . net
http://www.happyassassin.net
