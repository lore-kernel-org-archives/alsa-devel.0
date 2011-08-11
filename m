From: =?utf-8?B?TWF0xJtq?= Laitl <matej@laitl.cz>
Subject: Re: Allocating buffers for USB transfers (again)
Date: Fri, 12 Aug 2011 01:29:53 +0200
Message-ID: <3166003.Y8gKYdUrh9@edgy>
References: <Pine.LNX.4.44L0.1108101025250.1917-100000@iolanthe.rowland.org> <20110811180507.GC5884@xanatos> <CACTFLAMcOMv4D8k-P24TAkPwLRgYps4hoO-vC1NH+cibcsrUFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACTFLAMcOMv4D8k-P24TAkPwLRgYps4hoO-vC1NH+cibcsrUFQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: Sarah Sharp <sarah.a.sharp@linux.intel.com>, Alan Stern <stern@rowland.harvard.edu>, Florian Mickler <florian@mickler.org>, Oliver Neukum <oliver@neukum.org>, linux-usb@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>, pedrib@gmail.com, William Light <wrl@illest.net>, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, Robert Hancock <hancockrwd@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 11.=E2=80=AF8.=E2=80=AF2011 Daniel Mack wrote:
> On Thu, Aug 11, 2011 at 8:05 PM, Sarah Sharp
> > Because according to Matej, he applied that patch, plus my patch to
> > reject zero-length buffers[1], and he saw debugging that indicated =
he
> > *did* see zero-length buffers.  Is there any chance your driver mig=
ht
> > submit a zero-length buffer in the middle of the isochronous URB
> > transfer array?
>=20
> Hmm, judging from the code, this can only ever happen if we receive a=
n
> inbound iso frame which has a valid status and an actual_length of
> zero. Also, it was not neccessary to catch this case for EHCI.
>=20
> Maetj, does this patch make any difference?

This patch actually makes the sound playback _worse_. Now I get strange=
=20
squawks where previously at least first seconds of a song sounded norma=
lly.

However, I no longer get "zero length buffer submitted" or that "... We=
ird."=20
debug messages, only several megabytes of: (should I post these somewhe=
re?)

xhci_hcd 0000:05:00.0: Giveback URB ffff880114cec000, len =3D 880, expe=
cted =3D=20
1000, status =3D -115
xhci_hcd 0000:05:00.0: Giveback URB ffff880114740000, len =3D 352, expe=
cted =3D=20
1000, status =3D -115
xhci_hcd 0000:05:00.0: underrun event on endpoint

Regards,
                 Matej
