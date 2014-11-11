From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Fix kerneldoc errors
Date: Tue, 11 Nov 2014 00:32:05 +0000
Message-ID: <20141111003205.GR3815@sirena.org.uk>
References: <1415637045-20868-1-git-send-email-tiwai@suse.de>
 <20141110175508.GD3815@sirena.org.uk>
 <s5hlhniswhy.wl-tiwai@suse.de>
 <20141110192211.GJ3815@sirena.org.uk>
 <s5hioimsvpm.wl-tiwai@suse.de>
 <20141110195802.GO3815@sirena.org.uk>
 <s5hfvdqss2h.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7827949862579219661=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A330226153F
 for <alsa-devel@alsa-project.org>; Tue, 11 Nov 2014 01:33:22 +0100 (CET)
In-Reply-To: <s5hfvdqss2h.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============7827949862579219661==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="63hYKvmiPmCTzAfQ"
Content-Disposition: inline


--63hYKvmiPmCTzAfQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 10, 2014 at 09:45:26PM +0100, Takashi Iwai wrote:
> Mark Brown wrote:

> > > I don't mind in which ways.  Showing and hiding have both pros and
> > > cons.  Please just fix your code before I pull for 3.19!

> > Well, I think someone who cares should fix it!  :P

> Heh, *we* agreed on fixing / enhancing documentation in the previous
> meeting.

I totally agree that someone should do that work :)

> > More seriously it's on the list but I'm having a hard time seeing it as
> > being super urgent - it's more in the nice to have range for me.

> Well, I see this a bit differently.  As discussed, we should be really
> more strict on documentation.  From now on, any new API function and
> struct should mandate kerneldoc comments.  At least, I'll watch out in
> the future pull request and patch reviews.  And, fixing these trivial
> kerneldoc makes things a bit easier; otherwise the new warnings will
> be buried in other old warnings.

Right, and I am enforcing that for new stuff.  Since we don't currently
generate linuxdoc outputs we don't currently get any warnings and I'm
not seeing much demand for the actual outputs (as opposed to the
comments in the code which are useful; AFAICT that's the way most people
consume linuxdoc).

--63hYKvmiPmCTzAfQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUYVkFAAoJECTWi3JdVIfQcs8H/2jeGHePdhP9khXKabdjZbqv
7HrN8x7b/XlISD/JJMmstyjB2iHDS3IhpH7DbCuHuh9G/V3YlacsCllQqcB7n45A
yWON6F3Yi5gauOTSgS879uVCTdoj+DETsDkzm3eKzpavUEv6emTJlvJmC7kfeMQc
Jt0quKZFVbmv5CC3DZL0lkz+5nwwN3RvG1m08ZeRcmIOrAgmCDjUhce7h+DDoRti
cM2E1yXXFTdMTe42WESKTyAmVeM18m4bjQUV0umR37BpWxaQ7cZubmbWyYlSQ2Lk
8oMcIeLtRvjDa3g2ZjQIuA3Mm8XsmkZU+0a4ORIhJsm1o/XJzW0hD2olh97zOxQ=
=8fVH
-----END PGP SIGNATURE-----

--63hYKvmiPmCTzAfQ--

--===============7827949862579219661==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7827949862579219661==--
