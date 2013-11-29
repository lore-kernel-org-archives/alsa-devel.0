From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC] ALSA: add new alsa control byte extended
Date: Fri, 29 Nov 2013 12:27:19 +0000
Message-ID: <20131129122719.GW27568@sirena.org.uk>
References: <1385699397-18662-1-git-send-email-vinod.koul@intel.com>
 <s5hbo13fy6c.wl%tiwai@suse.de> <20131129074459.GE8834@intel.com>
 <s5hzjoneft5.wl%tiwai@suse.de> <52986123.5040004@perex.cz>
 <s5hsiufedxu.wl%tiwai@suse.de> <52986823.1050600@perex.cz>
 <20131129112505.GR27568@sirena.org.uk>
 <s5hpppjbg12.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4816096092834218094=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 43DDB26556D
 for <alsa-devel@alsa-project.org>; Fri, 29 Nov 2013 13:27:25 +0100 (CET)
In-Reply-To: <s5hpppjbg12.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============4816096092834218094==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MrbiU6dcJfOZ616B"
Content-Disposition: inline


--MrbiU6dcJfOZ616B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 29, 2013 at 12:31:37PM +0100, Takashi Iwai wrote:
> Mark Brown wrote:

> > I'd expect them to be handleable with standard tools, from a user
> > perspective these things are just another setting that gets applied when
> > changing use case like volumes and routing so manipulating the settings
> > in a separate place seems wrong - at the level where you're applying
> > them it's all part of the same set of data.

> Basically agreed, but OTOH, size matters, too.  What if there are a
> few MB data for several different control elements?  I don't think
> managing them in the same text alsa.state file is so sensible.

That's definitely something people doing tooling would need to consider
- there's also things like only saving changes or splitting the
  configuration up into reusable components rather than having complete
configs for each use case in order to keep the sizes down.  Even without
worrying about coefficients the sizes of the configuration files can get
large very quickly with a naive implementation.

--MrbiU6dcJfOZ616B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSmIgjAAoJELSic+t+oim94MsP/0gVQXBoYpssukgbYxuhWSJ5
afiQnKuoF31AjBzGLMEWevZl/acMFK8zqQgIURG2X+B8YFe1WJJZ43oYjGxMB2/u
0IKmwY78F8g758EK/R+hCAzKbKSEQID/GG2V9c3pzlSVgp9UrszsUfcP+FfhW89w
odqJJf0cN/vsdCx4ubamBXhrgeQ/gJa4/SUUKHyFNFwlzBHflc7WOt7BOjQNwxHH
AYjgsfzahWUqSW5T1r4W+xkVxE0PO837mo1FJtTrTklIrqC3r2eDY0XOxpERVTuG
Ywjof0kpGtYqB+1OdmkMPGJ/hxKtza6guzEhvMYWMgXVXniLGC3dMyQRkPAms3N9
eGvFr3471PgmDP4IiqJlknLq8hO2tgNJ2+0CNiiZ8+TIBCcblnRFtPs6gIYAeBc9
TB+9XGeKSkocPfgOreEjDE/tWyBDiZznUD3KthXkHlgeewnBbvEWjEqBkVpkX7tL
0XmZvf+eKmzGmyH3hYA2owAR/zSM1HIWX4EpKi6iD1J2Basu2diXejSvBm5BPLba
KRnNxIuTU5prpPajI9ux9s85L29GzXbqHEPyBFb9ENmfp873r6Ad0AtPkEw58/7o
8Vi2ZwkXVz9LRtrTlGWOJ4IIap2EC3+BRdFDxZxXEECzJqYlkl8kdz7S+wUR9k5t
RJDdH1ys7HRZ0N3n+vRo
=ZDPJ
-----END PGP SIGNATURE-----

--MrbiU6dcJfOZ616B--

--===============4816096092834218094==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4816096092834218094==--
