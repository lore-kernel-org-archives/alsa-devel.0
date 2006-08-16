From: "Lubomir Schmidt" <017623780966@o2online.de>
Subject: Re: [ALSA - driver 0002339]: No sound with ALC260 chip
Date: Wed, 16 Aug 2006 16:56:54 +0200
Message-ID: <001801c6c144$3e447ad0$16b2a8c0@dell4150>
References: <s5hzme5x9r9.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hzme5x9r9.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: 'Takashi Iwai' <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>At Tue, 15 Aug 2006 15:34:38 +0930 (CST),
>Jonathan Woithe wrote:
> 
> > > Which upload option?
> > Not upload, unload option. I need the unload module option in the
>kernel.
> 
> Ah.  Sorry, I should read things more clearly before I respond.
> 
> > Without it rmmod do not work.
> 
> Correct.
> 
> > > > > 3) try
> > > > >      modprobe snd-hda-intel model=acer
> > > > Have worked
> > > > >    With a bit of luck this won't give any errors.  Use alsamixer
>and
> > > > >    aplay (for example) to test sound and see if you get any joy.
> > > > 
> > > > I get a mistake when I try to start alsamixer -> alsamixer: function
> > > > snd_ctl_open failed for default: No such device
> > > 
> > > Hmm, that would imply that the sound driver didn't find any suitable
> > > hardware.  Perhaps try this again and post the last few lines of a
> > > dmesg command run immediately after the modprobe.  This should tell us
> > > what the snd-hda-intel found and what it did.
> > 
> > When i look into modprobe before i modprobe the driver and modprobe him
> > after that i can see 3 new messages:
> > #modprobe snd-hda-intel model=acer
> > ACPI: PCI Interrupt 0000:00:1b.0[A] -> Link [LNKA] -> GSI 10 (level,
>low) ->
> > IRQ 10
> > PCI: Setting latency timer of device 0000:00:1b.0 to 64
> > ALSA
> >
/var/tmp/portage/alsa-driver-1.0.12_rc1-r1/work/alsa-driver->1.0.12rc1/pci/h
d
> > a/../../alsa-kernel/pci/hda/hda_intel.c:525: hda_intel: azx_get_response
> > timeout, switching to single_cmd mode...
> 
> Right.  The first two appear consistent with what I see.  However, I only
> ever see "azx_get_response timeout" messages sporadically and for me they
> don't seem to cause a problem.  However ...
> 
> > > In another earlier post you also mentioned seeing timeout messages
> > > in the dmesg output; do you get these all the time, or just
>sporadically?
> > 
> > They are always comming when i start alsa (you see that in the message
> > above)
> 
> That doesn't seem right.  On the basis of these tests it would appear that
> Takashi's suggestion of there being a communication problem with the codec
> seems likely.  That would also explain why nothing sound-related appears
to
> be working.  FYI the HDA architecture consists of the HDA interface itself
> and an attached codec chip.  The above message could be indicating that
> while the HDA controller (for want of a better word) is found, the codec
> chip isn't responding or isn't repsonding properly.  It is the codec chip
> which is responsible for the A-D and D-A conversions.

>Exactly.

>Lubomir, could you try the patch below?  The driver will switch to
>polling mode if the irq mode seems not working.  You'll see first a
>warning message if the mode is switched.
>The driver will switch to single-cmd mode after it if even polling
>mode doesn't work, too.

>Takashi


How can I install the patch? Should I add that lines manually to any
configuration file? When yes, in which one?

L.Schmidt




diff -r 5b67bba2d36f pci/hda/hda_intel.c
--- a/pci/hda/hda_intel.c	Tue Aug 08 21:13:42 2006 +0200
+++ b/pci/hda/hda_intel.c	Wed Aug 09 12:07:44 2006 +0200
@@ -332,6 +332,7 @@ struct azx {
 	int position_fix;
 	unsigned int initialized: 1;
 	unsigned int single_cmd: 1;
+	unsigned int polling_mode: 1;
 };
 
 /* driver types */
@@ -518,8 +519,23 @@ static unsigned int azx_rirb_get_respons
 	struct azx *chip = codec->bus->private_data;
 	int timeout = 50;
 
-	while (chip->rirb.cmds) {
+	for (;;) {
+		if (chip->polling_mode) {
+			spin_lock_irq(&chip->reg_lock);
+			azx_update_rirb(chip);
+			spin_unlock_irq(&chip->reg_lock);
+		}
+		if (! chip->rirb.cmds)
+			break;
 		if (! --timeout) {
+			if (! chip->polling_mode) {
+				snd_printk(KERN_WARNING "hda_intel: "
+					   "azx_get_response timeout, "
+					   "switching to polling
mode...\n");
+				chip->polling_mode = 1;
+				timeout = 50;
+				continue;
+			}
 			snd_printk(KERN_ERR
 				   "hda_intel: azx_get_response timeout, "
 				   "switching to single_cmd mode...\n");


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
