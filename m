From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 12/12] ASoC: rsnd: add Multi channel support
Date: Sat, 19 Dec 2015 11:37:09 +0000
Message-ID: <20151219113709.GG5727@sirena.org.uk>
References: <87egeliyaz.wl%kuninori.morimoto.gx@renesas.com>
 <87wpsdhje9.wl%kuninori.morimoto.gx@renesas.com>
 <20151218200448.GA1476@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="U2airnvjqUwLRQVR"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20151218200448.GA1476@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Simon <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Linux-DT <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--U2airnvjqUwLRQVR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 18, 2015 at 02:04:51PM -0600, Rob Herring wrote:
> On Thu, Dec 17, 2015 at 03:00:10AM +0000, Kuninori Morimoto wrote:

> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> > ---
> >  .../devicetree/bindings/sound/renesas,rsnd.txt     |  18 ++++

> For the binding:

> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

Rob, it looks like something's up with your mail system - I'm getting
two copies of all your mails.  It looks like I'm getting one copy sent
with TLS and one copy sent without TLS both from rob-hp-laptop with
different message IDs:

Delivered-To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 5C46E204A2;
        Sat, 19 Dec 2015 04:17:58 +0000 (UTC)
Received: from rob-hp-laptop (unknown [68.66.83.131])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0AEF20490;
        Sat, 19 Dec 2015 04:17:56 +0000 (UTC)
Message-ID: <20151219041755.GG14936@rob-hp-laptop>
        (sfid-20151219_041801_069806_5E8B0949)

and

Delivered-To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id B6B4E204AF
        for <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>; Sat, 19 Dec 2015 04:19:20 +0000 (UTC)
Received: from rob-hp-laptop (unknown [68.66.83.131])
        by mail.kernel.org (Postfix) with ESMTP id 02201204D2
        for <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>; Sat, 19 Dec 2015 04:19:20 +0000 (UTC)
Received: by rob-hp-laptop (Postfix, from userid 1000)
        id D0F442C02FD; Fri, 18 Dec 2015 22:09:13 -0600 (CST)
...
Message-Id: <20151219040913.D0F442C02FD@rob-hp-laptop>
        (sfid-20151219_041922_802186_2104CD68)

--U2airnvjqUwLRQVR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWdUFkAAoJECTWi3JdVIfQXaEH/1giThAeFoxiCh5SWbiUHZaE
XxJv/u/2XsZrQw59mbbJERWF7DPFC2gdFQiDmHijttWirQ5UrLYAQw1WXd1jxDjB
3WAk3/uys25AkgzqxeNNvFlAu5uG3vaOS+k3KFV39w/e8tsImrFl572hjXYeqX9N
+iv6gDp8i7/Qc7O63cdaKBZ8l6qHVikOZZl7bbzgbLepT0MptqzFcsQdwG8IBiUs
Nzw3H+dcxRS3R1iPAEn9WCt2qW7MoGsDEcxLnYTkDn4vW0oMYCjE9hi6HzIVHY4B
Fkjl9HWRaxsNbvXVKpZsxe1xxJ5ddTXJJCO6ZUYuOKh7WVoOEKX/IesB+qetdjM=
=Lke/
-----END PGP SIGNATURE-----

--U2airnvjqUwLRQVR--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
