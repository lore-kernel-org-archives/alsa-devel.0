From: Mark Brown <broonie@kernel.org>
Subject: Re: proposal: snd_pcm_start_at()
Date: Wed, 8 Oct 2014 15:18:32 +0100
Message-ID: <20141008141832.GZ4609@sirena.org.uk>
References: <1412260460.3891605.174362449.667FB9BE@webmail.messagingengine.com>
 <542D8E3F.4080400@linux.intel.com> <542E8FE4.4080904@eml.cc>
 <542F2216.7050801@linux.intel.com> <s5h61fxzg2y.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0623097560711018023=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F18C26046A
 for <alsa-devel@alsa-project.org>; Wed,  8 Oct 2014 16:18:58 +0200 (CEST)
In-Reply-To: <s5h61fxzg2y.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Tim Cussins <timcussins@eml.cc>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============0623097560711018023==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iuL7KOmW1iVG2alW"
Content-Disposition: inline


--iuL7KOmW1iVG2alW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 06, 2014 at 11:45:57AM +0200, Takashi Iwai wrote:

> I think some synchronized triggering mechanism is missing in API, too.
> There has been a similar request from others in the past (Digigram
> wanted to have such a feature), so maybe it's not so uncommon
> scenario.

Yes, I've had people ask me about this too, mainly around getting
multiple DSP streams synchronized.  It was a while ago and a bit edge
casey though.

--iuL7KOmW1iVG2alW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUNUe3AAoJECTWi3JdVIfQPGQH/1BddUplPYZiCyQ9D4wxeF8i
XVF3VA8kKYqpzTJQGZ99CC7scoPj9gf34820REkEtSkr8mUNRcKEYlUTOQISE1Z2
0vDtajxpD3CwEr+QAShhyAX6umOn6lfYw1SrT01ro4KFOL542uiWFjB66KQOjSVh
xc9UZNaCMAqy5QAJa9LSw4fPbLdizmT6tlYd/hoJyeJMfI4GyugTQ18vhXiMVmOp
4icTmbeJh8uUGqIQCwGaUSEApymFwd7Ml3mMaZVakZT/pzWtN3XnOltmG1a4bqyO
Yre2HuwSYQvp7MPHphL96rJu8kCqSO2sB17LmiaAHmkG2V5F11zI2fh2sg/R1MQ=
=uo67
-----END PGP SIGNATURE-----

--iuL7KOmW1iVG2alW--

--===============0623097560711018023==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0623097560711018023==--
