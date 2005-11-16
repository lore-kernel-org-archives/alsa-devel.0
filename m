From: Eric Shattow <lucent@gmail.com>
Subject: Re: Problems with Hercules DJ Console and the usb-audio driver
Date: Wed, 16 Nov 2005 17:26:49 -0600
Message-ID: <2c746f620511161526u1c19a5f6i7e68ba9bb1d9e2d8@mail.gmail.com>
References: <20050914132346.GA18354@nittionio.nu>
	 <Pine.HPX.4.33n.0509141729220.16662-100000@studcom.urz.uni-halle.de>
	 <20051115153637.GA7100@nittionio.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20051115153637.GA7100@nittionio.nu>
Content-Disposition: inline
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

On 11/15/05, Daniel Svensson <nano@nittionio.nu> wrote:
> Just updated to kernel 2.6.15-rc1 and things have improved, however,
> still some problems left.
>
> > > 1. Classify the MIDI interface as standard MIDI interface.
> > The driver already did this, but a recent reorganization did not
> > handle this case correctly.
> >
> > This has now been fixed in CVS.
>
> Midi stuff _on_ the Hercules DJ Console works, but devices attached to
> the midi-in port doesn't work.
>
> > > 2. Ignore mixer errors.
> > I'll add another quirk for this to the driver.
>
> Mixer starts, but I don't know if it works as the output is broken.
>
> cannot get ctl value: req =3D 0x83, wValue =3D 0x800, wIndex =3D 0x200, t=
ype =3D 5
> 2:0: cannot get min/max values for control 8 (id 2)
> cannot get ctl value: req =3D 0x81, wValue =3D 0x800, wIndex =3D 0x200, t=
ype =3D 5
> cannot get ctl value: req =3D 0x81, wValue =3D 0x800, wIndex =3D 0x200, t=
ype =3D 5
>
> > > 3. Disable CONFIG_USB_BANDWIDTH
> > The USB bandwidth code is broken for all devices.
>
> Even though CONFIG_USB_BANDWIDTH is disabled I'm unable to get output
> working. I've tried with jack which works flawlessly with my internal
> soundcard but with hercules dj console I keep getting this from the
> kernel:
>
> ...
> frame 0 active: -84
> frame 0 active: -84
> ...
>
> Which in turn leads to jack being unable to start the playback.
>
> --
> Daniel Svensson <nano@nittionio.nu>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
> Register for a JBoss Training Course.  Free Certification Exam
> for All Training Attendees Through End of 2005. For more info visit:
> http://ads.osdn.com/?ad_id=3D7628&alloc_id=3D16845&op=3Dclick
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
>

Thank you for the update. I will also try this on my HPCDJ (windows
edition) device soon.

 Eric


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
