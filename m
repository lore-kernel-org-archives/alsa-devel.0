From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/1] ASoC: codecs: Enable AB8500 CODEC for
	Device Tree
Date: Tue, 21 Aug 2012 13:39:51 +0100
Message-ID: <20120821123951.GC7995@opensource.wolfsonmicro.com>
References: <1344527268-5964-1-git-send-email-lee.jones@linaro.org>
 <1344527268-5964-9-git-send-email-lee.jones@linaro.org>
 <s5h628lu0q9.wl%tiwai@suse.de> <20120820113427.GN8450@gmail.com>
 <20120820143653.GE26991@opensource.wolfsonmicro.com>
 <20120821115123.GE26899@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4576343411482066344=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C7083265F36
 for <alsa-devel@alsa-project.org>; Tue, 21 Aug 2012 14:39:51 +0200 (CEST)
In-Reply-To: <20120821115123.GE26899@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lee Jones <lee.jones@linaro.org>
Cc: alsa-devel@alsa-project.org, linus.walleij@stericsson.com, arnd@arndb.de, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============4576343411482066344==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FsscpQKzF/jJk6ya"
Content-Disposition: inline


--FsscpQKzF/jJk6ya
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 21, 2012 at 12:51:24PM +0100, Lee Jones wrote:
> On Mon, Aug 20, 2012 at 03:36:53PM +0100, Mark Brown wrote:

> > > From: Lee Jones <lee.jones@linaro.org>
> > > Date: Fri, 27 Jul 2012 08:50:05 +0100

> > Please resend this series with all the acks you've got rather than
> > mixing incremental updates in like this.

> I'm waiting until I have a few more Acks before I resend the entire
> patch-set again. Actually it's you and one other that I'm waiting for
> to review (and Ack as necessary) the ones requested by Linus, then=20
> resend with the corrections.

Well, I'm the person who's going to apply the patches so I'm unlikely
to ack them...  I was waiting for arch/arm review before I looked at
them due to the number of resends.

> > Please also send patches in
> > the format documented in SubmittingPatches.

> That's a big document, most of which I guess I'm adhering to. Care to
> be a little more specific?

The bit I quoted is the main example, you're including random mail
headers in the body of the mail.

--FsscpQKzF/jJk6ya
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQM4FEAAoJEFJkBDiqVpZ4ZbwP/3Rrw6cfLXtYAQRAOcQSyPrz
8VTcx+RAof1yWzgwx4wYArNN4XWicdlktJLP3cc0fA7wAwTAPR9gu2fuSraU5NnQ
GSi5X7F0KbdPrJt6UeMdFEW/xSjTFq6yEltutW8NGJfcbsBarF/xXclrnJdhA00r
5WP6mcUIDkZUsmLnMXPKH60uTbHmttejy5l5NL0t1XuE9BwFwr8+Ms0rmxPLNhDL
RLFvmXRVBoO2Z7+2d4xsVCpO1DT5xnbmTfiWOHwEg5UH8k7YpqixYNBSQ4odQnlt
cKlp0a8ctwZLpt8Aw9HWyj9mf5yoHHpdpKR8g0xYfqW0V1THqkdyUiRKBoJBcca0
9Nko1eDF+H80ajC8rMHGOiwTDQ+6oqoe/j1UKM/DaF5WLC4ThQqOBytgccEEw2p/
tlj/3SCjMSWFQut/0G9I61r6NDrCILpRwTCVny/dNXkzQtZtkBQR6eHunlqAEUvH
Q3gXaY/5t5Nd6MEwawORvS17Syou4nYNE7jYn8ZsEuIvs/PoLIN3PHc5PK1a3P9x
JwpOu8FIHLMZ/UZAaKI+G6v1Hf2l/QhVL1MByIa9M+sA8IzQthOOrM2wEcqTv8H8
Q8FTxCPD8RAJiBVHWDiA81zO7avq5YW29vrFyIvL8ZtZUeE9rEsfN/PI1P0I9Bu0
+8T0p5SjC9SkiTmGt1JZ
=oWck
-----END PGP SIGNATURE-----

--FsscpQKzF/jJk6ya--

--===============4576343411482066344==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4576343411482066344==--
