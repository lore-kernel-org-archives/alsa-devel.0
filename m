From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re: still interested in us224 support?
Date: Sun, 1 Feb 2004 13:58:06 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200402011358.07199.annabellesgarden@yahoo.de>
References: <20040111142515.GA1140@tuba.home> <200401301804.09400.david@robot-droid.com> <20040130201251.GA536@tuba.home>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040130201251.GA536@tuba.home>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Martin Langer <martin-langer@gmx.de>, David <david@robot-droid.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Am Freitag, 30. Januar 2004 21:12 schrieb Martin Langer:
> On Fri, Jan 30, 2004 at 06:04:09PM +0100, David wrote:
> > Le Jeudi 29 Janvier 2004 23:54, vous avez =E9crit :
> > > Jump to alsa-firmware/usx2yloader and place the attached us224.prepad
> > > file there. Part two of the job is patching two files there with the
> > > attached patchfile:
> > >
> > > patch -p0 < loader.patch
> >
> > Done, but even a ./configure && make && make install would copy
> > us224.prepad to /usr/local/share/alsa/firmware/usx2yloader/ so i copied
> > the file by myself.
>
> ok.
>
> > > and then run the typical install stuff...
> >
> > Now the control led is burning. I couldn't force aplay to use us224
> > instead of my maestro 2E, so i tried to cat a wav file to /dev/dspx. I
> > also tried to use xmms : it seems the file is played but with no sound.
>
> if the us224 is device number X:
> aplay -Dplughw:X,0 test.wav
>
> I guess it's in your case:
> aplay -Dplughw:1,0 test.wav
>
> For direct hardware access if the file is 44.1 or 48kHz and no alsa-lib
> conversion is necessary, it should be possible with:
> aplay -Dhw:1,0 test.wav
>
> > running alsamixer -c1 returns a "No mixer elems found" (i think it's
> > normal as under Windows there is also no mixing possibility).
>
> Well, that's the big difference to my 122 which is only an I/O interface
> and not a controller. My mixer is a 100% hardware solution but I guess the
> 224 is like the 428 and need a similar (the same ?) control interface.
> Perhaps the us428control (in alsa-tools) works out of the box for the 224
> too, but I've never looked inside that code. Karsten?

could work. but maybe some numbers identifying sliders or output mixers don=
't=20
fit us224. we would need info from tasam or usb snooping windoze or=20
braveheartedly testing on linux to know more.....
=2E..also i'm not completely shure if the snd-usb-usx2y's mmap interface is=
=20
initialized for us224 also. us428control talks to the driver with it.
Just give it a try.
>
> Karsten, how reacts the 428 without starting us428control? Simply no sound
> on playback? Or is there another point I've missed?

No sound on playback.
>
> I guess it's time to create some official 224 driver/loader patches for
> Alsa CVS now. Any objections?

You uncommented any section containing USB_ID_US224 in snd-usb-usx2y?
Also for trying on us224 please change=20
usbusx2yaudio.c line 1244
	    (usX2Y(card)->chip.dev->descriptor.idProduct =3D=3D USB_ID_US428 &&
to
	    (usX2Y(card)->chip.dev->descriptor.idProduct =3D=3D USB_ID_US224 &&

have fun,
Karsten



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
