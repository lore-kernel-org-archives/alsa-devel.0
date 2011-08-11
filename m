From: =?utf-8?B?TWF0xJtq?= Laitl <matej@laitl.cz>
Subject: Re: Allocating buffers for USB transfers (again)
Date: Fri, 12 Aug 2011 01:50:01 +0200
Message-ID: <1451239.ZLFiT5MIDr@edgy>
References: <Pine.LNX.4.44L0.1108101025250.1917-100000@iolanthe.rowland.org> <3166003.Y8gKYdUrh9@edgy> <4E446873.9020508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4E446873.9020508@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: Sarah Sharp <sarah.a.sharp@linux.intel.com>, Alan Stern <stern@rowland.harvard.edu>, Florian Mickler <florian@mickler.org>, Oliver Neukum <oliver@neukum.org>, linux-usb@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>, pedrib@gmail.com, William Light <wrl@illest.net>, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, Robert Hancock <hancockrwd@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 12.=E2=80=AF8.=E2=80=AF2011 Daniel Mack wrote:
> > This patch actually makes the sound playback _worse_. Now I get str=
ange
> > squawks where previously at least first seconds of a song sounded
> > normally.
> >=20
> > However, I no longer get "zero length buffer submitted" or that "..=
=2E
> > Weird." debug messages, only several megabytes of: (should I post t=
hese
> > somewhere?)
> >=20
> > xhci_hcd 0000:05:00.0: Giveback URB ffff880114cec000, len =3D 880,
> > expected =3D 1000, status =3D -115
> > xhci_hcd 0000:05:00.0: Giveback URB ffff880114740000, len =3D 352,
> > expected =3D 1000, status =3D -115
> > xhci_hcd 0000:05:00.0: underrun event on endpoint
>=20
> Might be the hardware doesn't like this. As I said, the patch is blin=
dly=20
> written and I couldn't test it. Did you test this on a EHCI port as w=
ell?

Good point, this patch distorts the playback also on the EHCI port. (th=
e=20
playback seems to be 10 times slower than it should be)

Now I have to go, but I hope I'll get another patch from you tomorrow. =
:-)

Thanks,
               Matej
