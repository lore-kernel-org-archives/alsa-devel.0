From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [alsa-devel] XMOS UAC2
Date: Thu, 9 Aug 2012 22:17:42 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1208092214420.614-100000@netrider.rowland.org>
References: <50241B0B.1050301@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <50241B0B.1050301-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "adelias-Y8qEzhMunLxMo1R+fwTmgw@public.gmane.org" <adelias-Y8qEzhMunLxMo1R+fwTmgw@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-usb <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 9 Aug 2012, Daniel Mack wrote:

> (Cc linux-usb)
>=20
> On 09.08.2012 21:59, adelias-Y8qEzhMunLxMo1R+fwTmgw@public.gmane.org wrote:
> > I've attached the dmesg of each.
> >=20
> > On 9/8/2012 10:45 =EC=EC, Daniel Mack wrote:
> >> > On 09.08.2012 21:33, adelias wrote:
> >>> >> I have an XMOS Reference board with the latest firmware (v3.3)=
=2E With
> >>> >> ALSA 1.0.23 it enumerates and functions properly. With ALSA 1.=
0.25 it
> >>> >> appears to enumerate properly after boot up but will not outpu=
t sound.
> >>> >> Removing and reinserting snd-usb-audio with modprobe doesn't h=
elp. Only
> >>> >> after I reset it by unpluging and repluging the usb cable will=
 it
> >>> >> function as it should.
> >> >
> >> > Could you provide the full boot logs of both scenarios please?
> >=20
> > dmesg.1.0.24
>=20
> Thanks. To summarize, you're not only using two different versions of
> ALSA but two versions of the kernel (2.6.37 vs 3.0.36+), and the prob=
lem
> is not caused by ALSA but by the USB host controller driver (see belo=
w).
>=20
> Is there any reason why you can't update to a more recent kernel (3.5=
)?


> > [   47.410000] [sw-ehci2]: sw_usb_disable_ehci
> > [   47.420000] [sw-ehci2]: remove, pdev->name: sw-ehci, pdev->id: 2=
, sw_ehci: 0xc05fe800
> > [   47.440000] sw-ehci sw-ehci.2: remove, state 1
> > [   47.440000] usb usb3: USB disconnect, device number 1
> > [   47.450000] BUG: scheduling while atomic: swapper/1/0x40000002
> > [   47.460000] Modules linked in:
> > [   47.470000] [<c0036e80>] (unwind_backtrace+0x0/0xe0) from [<c03c=
263c>] (__schedule+0x5c/0x4ec)
> > [   47.480000] [<c03c263c>] (__schedule+0x5c/0x4ec) from [<c00517fc=
>] (__cond_resched+0x14/0x20)
> > [   47.500000] [<c00517fc>] (__cond_resched+0x14/0x20) from [<c03c2=
b64>] (_cond_resched+0x34/0x44)
> > [   47.520000] [<c03c2b64>] (_cond_resched+0x34/0x44) from [<c02457=
94>] (wakeup_source_unregister+0xc/0x18)
> > [   47.530000] [<c0245794>] (wakeup_source_unregister+0xc/0x18) fro=
m [<c0245964>] (device_wakeup_disable+0x64/0x78)
> > [   47.550000] [<c0245964>] (device_wakeup_disable+0x64/0x78) from =
[<c02447ac>] (device_pm_remove+0x48/0x58)
> > [   47.570000] [<c02447ac>] (device_pm_remove+0x48/0x58) from [<c02=
3d144>] (device_del+0x34/0x168)
> > [   47.590000] [<c023d144>] (device_del+0x34/0x168) from [<c02847f4=
>] (usb_disconnect+0x9c/0xf8)
> > [   47.600000] [<c02847f4>] (usb_disconnect+0x9c/0xf8) from [<c0287=
244>] (usb_remove_hcd+0xb8/0x174)
> > [   47.620000] [<c0287244>] (usb_remove_hcd+0xb8/0x174) from [<c029=
5bbc>] (sw_ehci_hcd_remove+0x9c/0x104)
> > [   47.640000] [<c0295bbc>] (sw_ehci_hcd_remove+0x9c/0x104) from [<=
c0295cec>] (sw_usb_disable_ehci+0xc8/0xf0)
> > [   47.650000] [<c0295cec>] (sw_usb_disable_ehci+0xc8/0xf0) from [<=
c0295ed0>] (sw_ehci_hcd_probe+0x1bc/0x228)
> > [   47.670000] [<c0295ed0>] (sw_ehci_hcd_probe+0x1bc/0x228) from [<=
c02409c4>] (platform_drv_probe+0x14/0x18)

What is this sw-ehci driver?  It isn't in the standard kernel.  Why
does it disable a host controller from within the probe routine?

And why does it do this while it is in an atomic context?

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
