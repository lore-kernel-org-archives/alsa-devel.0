From: Mark Brown <broonie@kernel.org>
Subject: Re: DPCM: skip DAPM_STREAM_STOP event to BE,
 if still used by other FE
Date: Fri, 3 Jun 2016 01:18:42 +0100
Message-ID: <20160603001842.GY2282@sirena.org.uk>
References: <1464673532.31906.2.camel@mtkswgap22>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7639140675728423483=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AD89D266BF6
 for <alsa-devel@alsa-project.org>; Fri,  3 Jun 2016 02:18:53 +0200 (CEST)
In-Reply-To: <1464673532.31906.2.camel@mtkswgap22>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kai Chieh Chuang <kaichieh.chuang@mediatek.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============7639140675728423483==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KQ2iXOoQ638mtNze"
Content-Disposition: inline


--KQ2iXOoQ638mtNze
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 31, 2016 at 01:45:32PM +0800, Kai Chieh Chuang wrote:

> +		/* don't sent stop event if this BE is used by other FE */
> +		if (event == SND_SOC_DAPM_STREAM_STOP &&
> +		    be->dpcm[dir].users >= 1) {
> +			pr_warn("kc, %s(), be->dai_link->name %s skip stop event\n",
> __func__, be->dai_link->name);
> +			continue;
> +		}
> +
>  		snd_soc_dapm_stream_event(be, dir, event);
>  	}

If this isn't happening that seems like a bug, I'm a bit surprised
nobody else ran into it?  Shouldn't the counts of stream events that
happen be symmetric (ie, we get as many stops as starts), or are we
possibly missing some from things being switched in and out or something?

--KQ2iXOoQ638mtNze
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXUMzgAAoJECTWi3JdVIfQpRoH+gPY+irDmO9IXcpMkIG2+TA2
Zr5BniBUumtSXhReCqkP1AqB/U+aetsdvNkaGlfDKVWORsamxHZ+lsUu68tDVzAQ
kTS2Ti6CF4Azsus8aiSg1SXmvoaRvQFtDWNC82vcEwUQmqK8e5Pmy+80Ooc2nfQ1
Ux677+XXKcEj1CT115xuqYDRsjSR///+GXJTLXJ2EiMXAVMosk6nVJlzkQdhQpW6
hi77N78pCVopGjK3fzT1j9bvOWHfgqXxSDpzsV/WnNaxt7nbotSlq4tIVV6JjRaf
6Y+5bGFBsvEsNixlweJ//7QJaQB7eBCfOLaPGcIwdAI4/+7x7DjTbXUq1Ea+jZU=
=0SVP
-----END PGP SIGNATURE-----

--KQ2iXOoQ638mtNze--

--===============7639140675728423483==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7639140675728423483==--
