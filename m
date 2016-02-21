From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/4] ASoC: wm9713: add binding for WM9713
	codec
Date: Sun, 21 Feb 2016 10:49:20 +0900
Message-ID: <20160221014920.GK18327@sirena.org.uk>
References: <1455979079-9030-1-git-send-email-robert.jarzmik@free.fr>
 <20160220171459.GA18327@sirena.org.uk>
 <871t87z1gz.fsf@belgarion.home>
 <20160220195925.GF18327@sirena.org.uk>
 <87twl3xgud.fsf@belgarion.home>
 <20160220211659.GG18327@sirena.org.uk>
 <878u2fxbp9.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1007473726150181594=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 88C81265134
 for <alsa-devel@alsa-project.org>; Sun, 21 Feb 2016 02:49:54 +0100 (CET)
In-Reply-To: <878u2fxbp9.fsf@belgarion.home>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Takashi Iwai <tiwai@suse.com>, linux-arm-kernel@lists.infradead.org, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org


--===============1007473726150181594==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="C8M3rclghDj+srEw"
Content-Disposition: inline


--C8M3rclghDj+srEw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Feb 20, 2016 at 11:24:02PM +0100, Robert Jarzmik wrote:

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

> Mark Brown <broonie@kernel.org> writes:
> > On Sat, Feb 20, 2016 at 09:32:58PM +0100, Robert Jarzmik wrote:

> > It will eumerate the AC'97 bus by itself and does not need the CODEC to
> > be described.

> I think I still don't get it.

> So let's rephrase it another way : how will the function wm9713_probe() be
> called, ie. what is the possible function backtrace leading to that call ?

It will not be called, the generic AC'97 code will be used.

> > They should be created as a function of enumerating the CODEC.  If you
> > use the genric AC'97 stuff it doesn't use ASoC at all and this happens
> > as a side effect.

> I don't get that either. For me sound/soc/pci/ac97/ac97_codec.c is PCI specific,
> not generic, so what is "generic AC'97 stuff" ? I will never be able to use it
> as on my platforms CONFIG_PCI=n.

That is the generic code, there is no PCI dependency.

> Do you have a devicetree example somewhere, with (ac97 host, audio codec) pair I
> can have a look at to understand ?

Some Atmel boards do this IIRC, as does the AACI driver (via AMBA but
same effect).

--C8M3rclghDj+srEw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWyRefAAoJECTWi3JdVIfQItoH/20quO5ommbkLrV0bB2Wor1w
/Fiaob4R3usLxkfuVCC4QTMfsufXW2kTSvVbRdEUMMuDXORyDuax/tyPK0iXTcpM
Uyb++lhukLTwZ6JHJRKUkNwhJVZrDeG0mOhHfwFnMRHICHO5o95B5+szAG4Whust
Hkw37exXkFxsaymvEcxG1ArZnFSQ9uRd23bz0k1vqivTudikTzmE0MzalPH8GJNw
qu51BF3Do+w4V3qybiJf9GCe5t6/mi++R9a+y1ddOCROGAw6MhCstSOtBGBpTtda
fACfvHknd4BG+M8Dvvwfy3ANk5VA0CxMyqgzK3KNqwQDt8VRAiNMhgDRQmldFmg=
=pC3E
-----END PGP SIGNATURE-----

--C8M3rclghDj+srEw--

--===============1007473726150181594==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1007473726150181594==--
