From: Daniel Svensson <nano@nittionio.nu>
Subject: Re: Problems with Hercules DJ Console and the usb-audio driver
Date: Tue, 15 Nov 2005 16:36:37 +0100
Message-ID: <20051115153637.GA7100@nittionio.nu>
References: <20050914132346.GA18354@nittionio.nu> <Pine.HPX.4.33n.0509141729220.16662-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.HPX.4.33n.0509141729220.16662-100000@studcom.urz.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Just updated to kernel 2.6.15-rc1 and things have improved, however,
still some problems left.

> > 1. Classify the MIDI interface as standard MIDI interface.
> The driver already did this, but a recent reorganization did not
> handle this case correctly.
> 
> This has now been fixed in CVS.

Midi stuff _on_ the Hercules DJ Console works, but devices attached to
the midi-in port doesn't work. 

> > 2. Ignore mixer errors.
> I'll add another quirk for this to the driver.

Mixer starts, but I don't know if it works as the output is broken.

cannot get ctl value: req = 0x83, wValue = 0x800, wIndex = 0x200, type = 5
2:0: cannot get min/max values for control 8 (id 2)
cannot get ctl value: req = 0x81, wValue = 0x800, wIndex = 0x200, type = 5
cannot get ctl value: req = 0x81, wValue = 0x800, wIndex = 0x200, type = 5

> > 3. Disable CONFIG_USB_BANDWIDTH
> The USB bandwidth code is broken for all devices.

Even though CONFIG_USB_BANDWIDTH is disabled I'm unable to get output
working. I've tried with jack which works flawlessly with my internal
soundcard but with hercules dj console I keep getting this from the
kernel:

...
frame 0 active: -84
frame 0 active: -84
...

Which in turn leads to jack being unable to start the playback.

-- 
Daniel Svensson <nano@nittionio.nu>


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
