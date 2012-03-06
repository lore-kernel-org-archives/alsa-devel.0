From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 15/20] ASoC: fsl: make fsl_ssi driver
 compilable on ARM/IMX
Date: Tue, 6 Mar 2012 16:54:27 +0000
Message-ID: <20120306165427.GY19635@opensource.wolfsonmicro.com>
References: <20120305000411.GL7363@n2100.arm.linux.org.uk>
	<4F54053F.9070502@freescale.com>
	<20120305002635.GA23798@opensource.wolfsonmicro.com>
	<20120306104015.GF17370@n2100.arm.linux.org.uk>
	<20120306120646.GH19635@opensource.wolfsonmicro.com>
	<20120306122516.GH17370@n2100.arm.linux.org.uk>
	<20120306123322.GP19635@opensource.wolfsonmicro.com>
	<s5h4nu17tdn.wl%tiwai@suse.de>
	<20120306133818.GV19635@opensource.wolfsonmicro.com>
	<20120306135259.GJ17370@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8434315182940938610=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 349C02432E
	for <alsa-devel@alsa-project.org>; Tue,  6 Mar 2012 17:54:30 +0100 (CET)
In-Reply-To: <20120306135259.GJ17370@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Sascha Hauer <s.hauer@pengutronix.de>, Tabi Timur-B04825 <B04825@freescale.com>, Shawn Guo <shawn.guo@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============8434315182940938610==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="j13PAD5Nz8dz2ik7"
Content-Disposition: inline


--j13PAD5Nz8dz2ik7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 06, 2012 at 01:52:59PM +0000, Russell King - ARM Linux wrote:

> Stop using the term "uniprocessor assmptions".

> Thinking that something is safe because you're running on a uniprocessor
> system is total bollocks at every level.

Feh, it's hardly a new term - it dates back to when those crazy x86 kids
first got their hands on this fancy new SMP stuff and started running
into issues.  It's coming from the fact that that was the first case to
change the assumptions that had previously existed so things broke on
SMP systems.

> What you mean is "single threaded assumptions".  Please use this term
> instead - it's what you actually mean.

If we're concerned about the name I'd not mention threads as that's
often confusing for people in these contexts as it's not always obvious
to everyone if or how interrupts count.  "Single execution context" or
even "old school Linux" are probably less ambiguous.

--j13PAD5Nz8dz2ik7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPVkEvAAoJEBus8iNuMP3d+koP/R88hw5tKSzXTA7et8dNwAf2
jmJRqjThaZEufFsQdgOafOKMeB7VTjsWs2FARib74rRcrWn/436lgdFQdIMmzmxb
lcELZEez9kWJg0lIKfM/5Rs4dTJv2PWd/x4G7O/2eh/bI8yv3aINy682W4JYxjda
NXjalJELVpRJP3gXkh8TKnv72d+AJ6Zh2cdvHqJ8jgBSPmmAlDNc4GmzGAgtt0PI
AXhnvVoIxkdKgkw2ejAV73D8UtHBnIpPjChZlDA1RyBRZJ348N66VakEcHJX/3fe
lI/vQH+BtYtr2z/zhWWYbT3Z1VKL7SPhcixErPJhUo1vUTS5Ke8jR2jRj5EHvP3m
GmY04AiTsnCMZtDQrKa1rYmya/zlXhGgWm8hiofOieA2HwUMLlLWVmCJ/VHUcI1S
BNVav8MkeSBB+7FolBF0UDBu/OhprUfF4OGMtkQIi4/euLA/cP1XsfHYA8Tx2TPy
lcxA9V7krcaZzRMTEuuRQUndSfk4+JZBNShi6J49DegPcu2BR1l06vpUNzMbm9ML
z6wsBIBGWFln7bL0ULzM209V2zum0KB5T3mcDV0wCtm0NIO0y/fcp6IuPpI6v+tL
uDgVGz3h4VKsiqe0XXkz+uEGjeXDFxlpIvkhhGtTkwywHnUDMmMNuNl9/4UhtzwN
A/owt+WXu4JMwOOSOocU
=j2/D
-----END PGP SIGNATURE-----

--j13PAD5Nz8dz2ik7--

--===============8434315182940938610==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8434315182940938610==--
