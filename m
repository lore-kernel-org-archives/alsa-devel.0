From: Martin Langer <martin-langer@gmx.de>
Subject: Re: usx2y: known problems with us122 and alsa-drivers-1.0.1?
Date: Sun, 11 Jan 2004 15:58:51 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040111145851.GA1248@tuba.home>
References: <1073762822.1019.14.camel@serrano> <200401111449.06508.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <200401111449.06508.annabellesgarden@yahoo.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: Bill Gribble <grib@billgribble.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, Jan 11, 2004 at 02:49:06PM +0100, Karsten Wiese wrote:
> Am Samstag, 10. Januar 2004 20:27 schrieben Sie:
> >
> > $ ls -l /dev/snd
> > total 0
> > crw-rw----    1 root     audio    116,   0 Dec 31  1969 controlC0
> > crw-rw----    1 root     audio    116,  32 Dec 31  1969 controlC1
> > crw-rw----    1 root     audio    116,   4 Dec 31  1969 hwC0D0
> > crw-rw----    1 root     audio    116,   8 Dec 31  1969 midiC0D0
> > crw-rw----    1 root     audio    116,  24 Dec 31  1969 pcmC0D0c
> > crw-rw----    1 root     audio    116,  16 Dec 31  1969 pcmC0D0p
> > crw-rw----    1 root     audio    116,  56 Dec 31  1969 pcmC1D0c
> > crw-rw----    1 root     audio    116,  48 Dec 31  1969 pcmC1D0p
> > crw-rw----    1 root     audio    116,  33 Dec 31  1969 timer

1969 ?

> >
> > When I attached the USB device, here's the message I saw in
> > /var/log/messages:
> >
> > Jan 10 12:50:10 serrano kernel: hub 3-0:1.0: new USB device on port 2,
> > assigned
> > address 5
> > Jan 10 12:50:10 serrano kernel: midi: probe of 3-2:1.0 failed with error
> > -5

That's strange.

> > Jan 10 12:50:11 serrano /etc/hotplug/usb/tascam_fw: load
> > /usr/share/alsa/firmware/usx2yloader/us122fw.ihx for 1604/8006/100 to
> > /proc/bus/usb/003/005
> > Jan 10 12:50:11 serrano kernel: usb 3-2: USB disconnect, address 5
> > Jan 10 12:50:13 serrano kernel: hub 3-0:1.0: new USB device on port 2,
> > assigned
> > address 6
> > Jan 10 12:50:13 serrano kernel: midi: probe of 3-2:1.0 failed with error
> > -5

I don't see /dev/snd/seq. Can that be the cause? I've only 2.4 experience
and there I use ./snddevices in alsa-driver for creating all the devices.

crw-rw----    1 root     audio    116,   1 28. Mai 2003  seq

And a fresh compiled alsa CVS runs fine with my us122. no problems and there
are no midi changes at all.

martin


-- 
The only nice thing about spam is that it doesn't ring.


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
