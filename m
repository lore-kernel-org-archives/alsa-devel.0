From: Ville =?iso-8859-1?Q?P=E4tsi?= <drc@gimp.org>
Subject: Re: Miditech Midistart-2 USB keyboard
Date: Mon, 9 Aug 2004 18:44:25 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040809154425.GD2203@torni>
References: <20040809132737.GC2203@torni> <Pine.HPX.4.33n.0408091716270.20870-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.HPX.4.33n.0408091716270.20870-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> > > mstart-2.inf from the miditech.de driver package says:
> > >
> > > %USB\VID_4752&PID_0011.DeviceDesc%=MIDUSB.Dev, USB\VID_4752&PID_0011
> >
> > The mstart-2.inf from the driver cd has this:
> >
> > %USB\VID_7104&PID_2202.DeviceDesc%=MIDUSB.Dev, USB\VID_7104&PID_2202
> >
> 
> I think that you have an early version of the keyboard which
> apparently emulates a MIDI interface connected to a serial port,
> therefore the "Communications" device class.
> 
> You might be able to use the usbserial driver.

The usbserial driver didn't get used when I compiled it.

> (Please check if the mstart-2drv.sys is the same for both driver
> packages.)

That file is identical. All the files in the driver package you can
download from the Miditech homepage is dated 2003-11-08. The sys and the
ini-file are dated same on the cd version, but the inf file, the cpl
file and the install executable are newer (2003-11-11). The sys files
are identical in both.



-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
