From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: [ALSA - driver 0002339]: No sound with ALC260 chip
Date: Tue, 15 Aug 2006 15:34:38 +0930 (CST)
Message-ID: <200608150604.k7F64cxL008245@auster.physics.adelaide.edu.au>
References: <000901c6be4a$d86394e0$8801a8c0@dell4150>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <000901c6be4a$d86394e0$8801a8c0@dell4150> from "Lubomir Schmidt"
	at Aug 12, 2006 10:06:47 PM
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

> > Which upload option?
> Not upload, unload option. I need the unload module option in the kernel.

Ah.  Sorry, I should read things more clearly before I respond.

> Without it rmmod do not work.

Correct.

> > > > 3) try
> > > >      modprobe snd-hda-intel model=acer
> > > Have worked
> > > >    With a bit of luck this won't give any errors.  Use alsamixer and
> > > >    aplay (for example) to test sound and see if you get any joy.
> > > 
> > > I get a mistake when I try to start alsamixer -> alsamixer: function
> > > snd_ctl_open failed for default: No such device
> > 
> > Hmm, that would imply that the sound driver didn't find any suitable
> > hardware.  Perhaps try this again and post the last few lines of a
> > dmesg command run immediately after the modprobe.  This should tell us
> > what the snd-hda-intel found and what it did.
> 
> When i look into modprobe before i modprobe the driver and modprobe him
> after that i can see 3 new messages:
> #modprobe snd-hda-intel model=acer
> ACPI: PCI Interrupt 0000:00:1b.0[A] -> Link [LNKA] -> GSI 10 (level, low) ->
> IRQ 10
> PCI: Setting latency timer of device 0000:00:1b.0 to 64
> ALSA
> /var/tmp/portage/alsa-driver-1.0.12_rc1-r1/work/alsa-driver-1.0.12rc1/pci/hd
> a/../../alsa-kernel/pci/hda/hda_intel.c:525: hda_intel: azx_get_response
> timeout, switching to single_cmd mode...

Right.  The first two appear consistent with what I see.  However, I only
ever see "azx_get_response timeout" messages sporadically and for me they
don't seem to cause a problem.  However ...

> > In another earlier post you also mentioned seeing timeout messages
> > in the dmesg output; do you get these all the time, or just sporadically?
> 
> They are always comming when i start alsa (you see that in the message
> above)

That doesn't seem right.  On the basis of these tests it would appear that
Takashi's suggestion of there being a communication problem with the codec
seems likely.  That would also explain why nothing sound-related appears to
be working.  FYI the HDA architecture consists of the HDA interface itself
and an attached codec chip.  The above message could be indicating that
while the HDA controller (for want of a better word) is found, the codec
chip isn't responding or isn't repsonding properly.  It is the codec chip
which is responsible for the A-D and D-A conversions.

Once the snd-hda-intel module has loaded, do you see anything interesting
in /proc/asound/?

> Here is my /etc/modules.d/alsa: http://rafb.net/paste/results/Bi1ad944.html

Sorry, I never got to this email in time to see it - the above link had
expired by the time I tried it.

I'm not entirely sure what to suggest at this point; to me it appears that
there is a problem communicating with the codec chip which makes it
difficult to make further progress.  Is your laptop dual-boot?  If so, does
sound work correctly in the other OS?  Another (extremely remote)
possibility is that your laptop doesn't use an ALC260 codec but for some
reason it's being misdetected as an ALC260.  However, I can find no reference
on the web to the codec used in the Acer c204tmi notebook, so I guess for
the moment we have to assume that it really is an ALC260.  It would be nice
to confirm this somehow.

Regards
  jonathan

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
