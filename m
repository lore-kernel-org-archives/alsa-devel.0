From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [alsa-cvslog] CVS: alsa-kernel/Documentation
 ALSA-Configuration.txt,1.50,1.51
Date: Fri, 03 Sep 2004 14:58:29 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0409031427510.16124-100000@studcom.urz.uni-halle.de>
References: <s5hfz5zy1z4.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <s5hfz5zy1z4.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Clemens Ladisch wrote:
> > Log Message:
> > Summary: remove gameport/MIDI support
> >
> > snd-intel8x0's gameport/MIDI code has quite a few problems:  the port
> > addresses cannot be detected reliably (or not at all with newer LPC
> > bridge devices), joystick port address 0x208 isn't supported, the MIDI
> > interrupt isn't detected, PnP isn't supported, changing the port
> > addresses in the LPC bridge configuration doesn't affect the devices
> > in the Super-I/O chip connected to the LPC bus, and registering this
> > driver for the LPC bridge PCI device prevents other drivers using the
> > LPC's PCI id from loading later.
> >
> > All these problems can be cured by removing the offending code and
> > using the proper modules for these devices (ns558/snd-mpu401) instead.
>
> I agree with removal, but can ns558/mpu401 set up these pci
> configuration bits for ICH properly?

No, but intel8x0 wasn't able to do this either -- enabling some port
addresses in the LPC bridge doesn't change the configuration of the
actual device in the Super-I/O chip.  Only the BIOS knows how to do
this, so the driver must use PnP information for this.


Regards,
Clemens



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
