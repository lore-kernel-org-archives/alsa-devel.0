From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: [ALSA - driver 0002339]: No sound with ALC260 chip
Date: Thu, 10 Aug 2006 09:10:48 +0930 (CST)
Message-ID: <200608092340.k79NenXH015512@auster.physics.adelaide.edu.au>
References: <002001c6bbbf$ac896170$8801a8c0@dell4150>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <002001c6bbbf$ac896170$8801a8c0@dell4150> from "Lubomir Schmidt"
	at Aug 09, 2006 04:25:31 PM
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Lubomir Schmidt <017623780966@o2online.de>
Cc: alsa-devel@lists.sourceforge.net, jwoithe@physics.adelaide.edu.au
List-Id: alsa-devel@alsa-project.org

> > 2) do:
> >      rmmod snd-hda-intel
> >      rmmod snd-hda-codec
> Have worked( I had to enable the unload option in the kernel and rebuild
> alsa-driver,ieee80211,ipw2200)

Which upload option?

> > 3) try
> >      modprobe snd-hda-intel model=acer
> Have worked
> >    With a bit of luck this won't give any errors.  Use alsamixer and
> >    aplay (for example) to test sound and see if you get any joy.
> 
> I get a mistake when I try to start alsamixer -> alsamixer: function
> snd_ctl_open failed for default: No such device

Hmm, that would imply that the sound driver didn't find any suitable
hardware.  Perhaps try this again and post the last few lines of a
dmesg command run immediately after the modprobe.  This should tell us
what the snd-hda-intel found and what it did.

In another earlier post you also mentioned seeing timeout messages
in the dmesg output; do you get these all the time, or just sporadically?

> Should I try alsaconf?

Probably not at this stage.  While working out precisely what is going on
it's easier to stick with doing things manually.  Oh yes, it might also be
wise to see what is in your /etc/modules.d/alsa file and perhaps temporarily
removing it; that way we know there's no potential clash between what's in
that and what you try on the command line.

> Alsaconf sais that it will change some things in /etc/modules.d/alsa. Will
> it change the option "model=acer" again to default?

I suspect so, so let's leave alsaconf out of it for the moment.

Regards
  jonathan

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
