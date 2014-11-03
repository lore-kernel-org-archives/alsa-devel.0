From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Add Merrifield machine driver
Date: Mon, 3 Nov 2014 12:07:50 +0000
Message-ID: <20141103120750.GD3815@sirena.org.uk>
References: <1414750298-23287-1-git-send-email-vinod.koul@intel.com>
 <20141031171127.GG18557@sirena.org.uk>
 <20141103050158.GL28745@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3579042781851539903=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 847452604A0
 for <alsa-devel@alsa-project.org>; Mon,  3 Nov 2014 13:09:05 +0100 (CET)
In-Reply-To: <20141103050158.GL28745@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============3579042781851539903==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sgneBHv3152wZ8jf"
Content-Disposition: inline


--sgneBHv3152wZ8jf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 03, 2014 at 10:31:58AM +0530, Vinod Koul wrote:
> On Fri, Oct 31, 2014 at 05:11:27PM +0000, Mark Brown wrote:

> > > +	snd_jack_set_key(ctx->jack.jack, SND_JACK_BTN_1, KEY_MEDIA);
> > > +	snd_jack_set_key(ctx->jack.jack, SND_JACK_BTN_0, KEY_MEDIA);

> > Two buttons both reporting the same key?  Might be worth a comment.

> Okay loooking back I am not sure why we added two here, let me check and
> clean this up.

I was assuming it was because the tolerance desired on the button was
wider than a single detection range on the device so this was ensuring
that the button was reliably detected.

--sgneBHv3152wZ8jf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUV3AVAAoJECTWi3JdVIfQ6A4H/13fyXZxO63JEtmxMTItTLx1
eradtPkBHtpawOfd0SZsG1UlK2sgUPpt+UwqYPtPAIEZCrhYDSiICUER3CScFnC0
AGTloUJouLjHGqrRRCwpXzzn2Cc++OAUth/ElzhwDnmMRTHOOaTrXMs0cZAV24jg
4sb63CFCc8MbgGKjNOBJF66QoZk/LByRTXNDB3rOVI/ZzCGDklyZ+fml+Z2vW+y1
RvnNykaGprreOkiJJWHp/rvl0/HIVMcyco3klY3C31VelCmrBmFFwL1HyZjtZB6/
RAXRjfTNkuTtY6mRM3DtDTOu6Hus3IGtOLuFyEnZ6WiSfxftfNO+ZUpZ7HSBceI=
=IuZJ
-----END PGP SIGNATURE-----

--sgneBHv3152wZ8jf--

--===============3579042781851539903==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3579042781851539903==--
