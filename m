From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [partialy fixed] Creamware Noah,
 snd-usb-audio capable?
Date: Thu, 19 Feb 2004 09:21:45 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0402190913020.17744-100000@studcom.urz.uni-halle.de>
References: <1077130780.4682.32.camel@chief.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <1077130780.4682.32.camel@chief.local>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Hartmut Geissbauer <nwgbh@swissonline.ch>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hartmut Geissbauer wrote:
> Clemens Ladisch wrote:
> > > Might the patch(the code in it) for usbaudio.c you posted before be
> > > helpfull for the program?
> >
> > No. Please remove the patch.
>
> Done, except of the entries in usbquirks.h. Is it still needed?

No.  The quirk entry causes the driver to be loaded even for the first
configuration, which isn't needed anymore.

> Now by playing around with the settings in the build-in menu of the
> synthesizer, I discovered an entry named USBCom, that isn't described in
> the (so far well done) manual. You can switch it between Windows and
> Mac/Linux. I rememberd that I updated the firmware. (Now: 1.4.23, if
> anyone else is interested) So this menu entry might belong to this
> update.
>
> OK, with this setting, it is _not_ necessary to switch the configuration
> with your small but excellent tool to 2. There's now only _one_
> configuration  available, which represents  the audio and midi devices.

It's nice to see a device with built-in Linux support.  :-)

Please make an entry on http://qbik.ch/usb/devices/ and describe to
change the USBCom entry.

> The only thing that's missing now are the two playback ports.

Please show the output of "lsusb -v".


Regards,
Clemens




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
