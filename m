From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/4] ASoC: mmp: add audio dma support
Date: Tue, 29 May 2012 14:14:11 +0100
Message-ID: <20120529131410.GB3954@opensource.wolfsonmicro.com>
References: <1337929863-31885-3-git-send-email-zhangfei.gao@marvell.com>
	<1337932416.1580.2.camel@vkoul-udesk3>
	<20120525080500.GB24149@n2100.arm.linux.org.uk>
	<CAMj5Bkhc46zqY5AbJkc=-h02taP_esxrqpNu--aYtZZcVcPK6A@mail.gmail.com>
	<20120525094231.GC24149@n2100.arm.linux.org.uk>
	<CAMj5BkjhCakuZdUcA+P_nbETi8tnYK5Ok6HMWTG61whZXwCD6g@mail.gmail.com>
	<1338268734.1580.26.camel@vkoul-udesk3>
	<20120529073334.GA12217@n2100.arm.linux.org.uk>
	<20120529090215.GA3954@opensource.wolfsonmicro.com>
	<20120529092129.GE12217@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4969891636576543820=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20120529092129.GE12217@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
Cc: Vinod Koul <vinod.koul@linux.intel.com>, Eric Miao <eric.y.miao@gmail.com>, Leo Yan <leoy@marvell.com>, alsa-devel@alsa-project.org, Haojian Zhuang <haojian.zhuang@gmail.com>, Liam Girdwood <lrg@ti.com>, Chao Xie <cxie4@marvell.com>, Qiao Zhou <zhouqiao@marvell.com>, Zhangfei Gao <zhangfei.gao@marvell.com>, zhangfei gao <zhangfei.gao@gmail.com>, alsa-devel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============4969891636576543820==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="24zk1gE8NUlDmwG9"
Content-Disposition: inline


--24zk1gE8NUlDmwG9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 29, 2012 at 10:21:29AM +0100, Russell King - ARM Linux wrote:
> On Tue, May 29, 2012 at 10:02:15AM +0100, Mark Brown wrote:

> > What is the issue with the current code - it *looks* like you want to
> > use the component device for the DMA as the struct device with dmaengine
> > but I don't understand the issue that's created if we don't (and why
> > things appear to be working for people as they are).

> Look.  It's very very very very simple.

> What does the DMA API take?  A struct device.  What struct device?  Some
> random struct device for something in the system, or what?  No, it takes
> the struct device for the _device_ in the system which is _performing_
> the DMA.

I'm assuming that you mean the client rather than the DMA controller
itself (which we must already have found)?  That makes sense,=20

> If you persist in not wanting to care about this, then I'm afraid I'll
> ignore soc-dmaengine-pcm.c entirely as to me its totally bolloxed code.
> What I have as my own version (now with cyclic DMA support) is IMHO a
> far superior and more correct implementation.

I'm sorry, I'm not sure what you mean when you say "if you persist"?
The mail I replied to was the first time I'd seen mention of this issue
at all.  I have to confess I haven't read every dmaengine thread in
detail, they're quite large and when they talk about generic issues they
seem to be focusing pretty much entirely on going over the issues with
the completion callbacks.

It would be enormously helpful if you could submit some code here (you
did once post a link to it but I don't recall it getting sent to the
list), probably as a replacement for the existing code if you don't want
to fix the existing code.  Even though API changes are going to be
required hopefully it should be relatively straightforward to convert
the existing users over to the new API, everything should at least be
following a common pattern so once one device is converted the rest
should be simple.  This seems much more likely to get us somewhere than
the current situation.

Currently we seem to have nobody actually working on this code in
mainline, as far as I can tell you and Vinod are the only people with
any active interest at a framework level (with Vinod's mostly being at
the dmaengine rather than ASoC level; I don't have any hardware with any
sort of dmaengine support) and because you have this out of tree
implementation you're working on you're mostly just offering feedback in
these driver review threads where apparently chunks of it are getting
missed.  Nobody else seems to be showing much inclination to get
involved so it seems unlikely to collide with other work.

--24zk1gE8NUlDmwG9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPxMubAAoJEBus8iNuMP3dOS8P/01HBv9Nkj+Y9M3NOwa9wB2U
4yo0g+5nuThlSTjlJnHAEdnRqkrL9vCYZv2nOvhWwjR23736yQPBVA5RrgvYgtPc
vw1BlBtdylKzSN2+RP/aDN7Z06M5xp1deiRcP2SN1dW108Th+LTIVSx9Z5+GD82v
SOEzTBQyjDlHjqmJP588iLuVWVVUdgFHhY+u1TyUbGgwpqZtGinX7M8vBXkwkZru
w1KkeMSCWybyYNVNTenVZXucTTz0++jRlBn2wGoq+y77HQyiRmOkcmeZCFzRhCVa
XlsBVKZyG+VTcXkCiWBGkUjO02nNJp9Uno5t0Aac1V4ypiSDodaZyvtrU9/O547T
XSY3X38vna0n/j8wIOPc0gSGDL/uTLRyYa3llJPtG0Zuy2RTjqcSN2meHqZPZLFx
mePWYobl4+mzjIsrr3hz2LJYDQiqt/Apo3GgDqIq+51PngnHx5q0kVgwjfcf8Ps9
TBk79OwFR5xSgpeDC2VViZtBIAaahUNEytlDm0k7ZNSG1lTHcje3kqDoa3XVxCpe
28D76hHxb5ChKa4sIkOpj5NZc2rM6EXFl+mveQu9Za7KGTNIQw6NszcW6sp/zd+8
Fv5p+8G9roVyJFRQwXy4wJZPK2tCBazUwXaIpznluZ0lkl8auFtUBqY+YwZh0VZ5
O4mZlMiJIcjSjiMO8xBh
=wXi4
-----END PGP SIGNATURE-----

--24zk1gE8NUlDmwG9--
--
To unsubscribe from this list: send the line "unsubscribe alsa-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


--===============4969891636576543820==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4969891636576543820==--
