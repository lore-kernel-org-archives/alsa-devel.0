From: Scott Bahling <sbahling@suse.com>
Subject: Re: Controlling the Tascam FW-1884
Date: Sat, 08 Sep 2018 13:21:36 +0200
Message-ID: <985b1f6dc5b0af2aae049e0b6fcf976ab400d34d.camel@suse.com>
References: <9cec059e1ff1a558f21a3f0729c5a69a3d506573.camel@suse.com>
 <0e469670-0520-5953-230b-8d2da5e4c357@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9041587535866738461=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id E3585267818
 for <alsa-devel@alsa-project.org>; Sat,  8 Sep 2018 13:21:46 +0200 (CEST)
In-Reply-To: <0e469670-0520-5953-230b-8d2da5e4c357@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org


--===============9041587535866738461==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-PDuM4zpOA5GOue5C/+cy"


--=-PDuM4zpOA5GOue5C/+cy
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2018-09-08 at 11:53 +0900, Takashi Sakamoto wrote:
> Hi Scott,
> (C.Ced to alsa-devel, ffado-devel)
>=20
<snip>

>=20
> When enabling multiplexing messages to isochronous packet,
> demultiplexer should be implemented to ALSA firewire-tascam driver,
> but not yet. You can see my initial RFC in alsa-devel[1]. This patch
> enables userspace applications to perform the demultiplexing, however
> this idea easily brings cache-coherency problems due to page mapping
> between kernel/userspace and impossible to be applied. We need to
> investigate another idea to achieve the demultiplexing in kernel
> land.

Thanks for the information! I read the RFC and your initial code. Why
did you remove the virtual MIDI port code that was part of the RFC code
(I don't see it upstream)? Did it not work? What I have discovered is
that in "computer control" mode the unit sends MIDI messages via the
virtual midi port (control port). The Tascam Native protocol as well as
the other emulations like Mackie are routed via that virtual midi port
and never touch the physical midi ports.

So the secret might be enabling the virtual midi ports - but it's still
not clear to me if those ports are created/mapped within the FW-1884,
or need to be created on the host OS based on the isochronous packet
data. The latter would be more work.

> As another option, according to page 26 in 'TASCAM FW-1884 Owner's
> Manual', when programming Keys to port 1-4, system could receive MIDI
> messages from control surface of FW-1884. However, I've not
> investigated
> it.

I tested this using a supported OS to program the FW-1884 controls to
midi. It works, and the settings are nonvolatile. With this, all
controls can be assigned, but it's one way control from the FW-1884
outward. There appears to be no way to control the motorized faders or
panel indicators from the application towards the FW-1884 in this mode.

<snip>

> User manuals are documents to which we can refer. The most vendors
> licenses their drivers/software with EULA and in most cases it can't
> allow users to binary-based reverse engineering.
>=20
> All of my work are done with external protocol analyzer unit on
> IEEE 1394 bus. When working to implement drivers, I
> read/classified/parsed content of many packets sniffed by the analyzer.
> An initial idea of libhinawa/hinawa-utils is to assist this my work.

Right. That's what I meant by reverse engineering - analyzing the
traffic and device behavior to understand the protocols.

> I heard FFADO developers uses some ways for this type of work:
>   - Usage of host controller of TI PCILynx and driver module
> (nosy.ko)
>   - Windows application; bushound[2]

Yep. Read about all that already ;) It sounds like I could take your
RFC code, build a custom kernel, and start analyzing the status and
control messages to get a better understanding of what is happening at
that layer.

> However, this type of work takes you long time, so I don't necessarily
> recommend you. It's 2018 and I think you can find alternative control
> surfaces on USB. If you take long time to make devices available on
> GNU/Linux, it's better to select devices on 'live' buses instead of
> 'legacy' buses such as IEEE 1394 bus, IMO. In a case of USB, wireshark
> with usbcap is the easiest way for us to sniff packets on Windows.

Understood, but hacking is part of the fun, and this is looking like a
really nice piece of equipment (better than modern control surfaces I
have looked at in my price range). Legacy buses don't scare me. I'm
still running my main audio capture card on legacy PCI bus.

Thanks for the ground work you have already done!

Regards,

Scott


--=-PDuM4zpOA5GOue5C/+cy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQjvzoZ9RLbHiUT/sAst8aI6UpxIFAluTsMAACgkQAst8aI6U
pxKj3g//VeRErB2WEbjp2om78ChxhhPy9RoiALh4Q3Z3Mot0StmwjVA2AhLJwcO7
Smr5NQSeYrPESkb2HjFjAs9nk0Vmp49qj6DL1xHhMxS5faRk9mfX57JPREJjTP8k
y+AJkFOl3c6zvg8MfCPyHveBnG27RAw98egBX8OS+aez+3MNEhwPUr4rfjEE/C6M
AmxFTF8xGDlkMr9oYItimA7483JPDES7j+tHE0tLNjCGH0zeeiI2asSLjtiKwhKS
YcH5rpQTCb55/Wj+nixpj6yhe31zLReNpNT+ajz+U5gJ5RC1rZcpxHIZkXmcH1+3
9mtrqZmh+SPC9d/7X01i4wx3SAzLadob7HciQE5oWQPhMSrZDK4pJIfrQv/8Qkf0
CZFZd3c2d5tMNfElKx0omgRhBXMEDjJZVmkmDgkqnHaiLxxNXpVEVT6NaKmcy1F3
nES8hSwx/2/CGKZYNvgilr+8fMZL51m4NjQ06nax8eX1Vwwg+o0KE1/YB10rZFCu
ORf9l4N8Fgf6bBUYXhs5wzzLQqJq292EQUsgI7AoC8KslGW5ZfQMNK+Mqdcu14Tn
xSy0Oi9yFtx7vXkQ7fU3XYkXi+3yS1LnViQdLbK9lm80Lvc5Z2rCcww+dhvtmU+W
YfIeIw/Yy8f6SbYBzsBvh3lIaxh50aZRq0x7n4J9160wY5TSTmg=
=zkFR
-----END PGP SIGNATURE-----

--=-PDuM4zpOA5GOue5C/+cy--


--===============9041587535866738461==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9041587535866738461==--
