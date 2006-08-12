From: "Lubomir Schmidt" <017623780966@o2online.de>
Subject: Re: [ALSA - driver 0002339]: No sound with ALC260 chip
Date: Sat, 12 Aug 2006 22:06:47 +0200
Message-ID: <000901c6be4a$d86394e0$8801a8c0@dell4150>
References: <200608092340.k79NenXH015512@auster.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200608092340.k79NenXH015512@auster.physics.adelaide.edu.au>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net, jwoithe@physics.adelaide.edu.au
List-Id: alsa-devel@alsa-project.org

> > 2) do:
> >      rmmod snd-hda-intel
> >      rmmod snd-hda-codec
> Have worked( I had to enable the unload option in the kernel and rebuild
> alsa-driver,ieee80211,ipw2200)

Which upload option?
-> Not upload, unload option. I need the unload module option in the kernel.
Without it rmmod do not work.

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

->When i look into modprobe before i modprobe the driver and modprobe him
after that i can see 3 new messages:
#modprobe snd-hda-intel model=acer
ACPI: PCI Interrupt 0000:00:1b.0[A] -> Link [LNKA] -> GSI 10 (level, low) ->
IRQ 10
PCI: Setting latency timer of device 0000:00:1b.0 to 64
ALSA
/var/tmp/portage/alsa-driver-1.0.12_rc1-r1/work/alsa-driver-1.0.12rc1/pci/hd
a/../../alsa-kernel/pci/hda/hda_intel.c:525: hda_intel: azx_get_response
timeout, switching to single_cmd mode...


In another earlier post you also mentioned seeing timeout messages
in the dmesg output; do you get these all the time, or just sporadically?

->They are always comming when i start alsa (you see that in the message
above)

> Should I try alsaconf?

Probably not at this stage.  While working out precisely what is going on
it's easier to stick with doing things manually.  Oh yes, it might also be
wise to see what is in your /etc/modules.d/alsa file and perhaps temporarily
removing it; that way we know there's no potential clash between what's in
that and what you try on the command line.

->Ok, wont use alsaconf
Here is my /etc/modules.d/alsa: http://rafb.net/paste/results/Bi1ad944.html

> Alsaconf sais that it will change some things in /etc/modules.d/alsa. Will
> it change the option "model=acer" again to default?

I suspect so, so let's leave alsaconf out of it for the moment.

->Okay

Regards
  jonathan


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
