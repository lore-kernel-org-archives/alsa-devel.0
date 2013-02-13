From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] compress: add support for gapless playback
Date: Wed, 13 Feb 2013 11:34:32 +0000
Message-ID: <20130213113431.GA5062@opensource.wolfsonmicro.com>
References: <1360693915-22595-1-git-send-email-vinod.koul@intel.com>
 <s5hobfovijf.wl%tiwai@suse.de> <20130213063547.GD17659@intel.com>
 <s5hhalgvf4k.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7006971802725174766=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 54AB72651B9
 for <alsa-devel@alsa-project.org>; Wed, 13 Feb 2013 12:34:34 +0100 (CET)
In-Reply-To: <s5hhalgvf4k.wl%tiwai@suse.de>
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
Cc: Vinod Koul <vinod.koul@intel.com>, Jeeja KP <jeeja.kp@intel.com>, alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============7006971802725174766==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 13, 2013 at 08:37:15AM +0100, Takashi Iwai wrote:
> Vinod Koul wrote:
> > On Wed, Feb 13, 2013 at 07:23:32AM +0100, Takashi Iwai wrote:

> > > But this makes difficult to know which parameter is unavailable in
> > > this kernel, as already mentioned in the thread.  You need to add
> > > another ioctl or add a mask in the struct.  Or, take back to single
> > > key/value pairs, so user can see the -ENOENT or such error for
> > > non-existing parameters.

> > Right, but we have the API version.

> But what if a driver doesn't support a particular metadata?
> Or would you mandate for every driver to support all metadata?

I tend to agree with Takashi here, it seems better if we can have
drivers able to implement only a subset of features especially if the
API does get extended.

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRG3o/AAoJELSic+t+oim9mzMP/1dSvK4qO/1Oc5zoskCjtozd
jARAbe+HEmrp2g4qJ3uOkJIrWblsakeQi7ch0McqRZxGPdxjhLPAJIj0uwQkhyue
HojUbF83BKoEmKwiB2yYGPmBMPhXMIcDs2+syEiWkb0wFM7U0KDiwAtBQgkgttsm
XtYwCc190ZxzQY59vxm1GQzMvxavrlGhM0eVXn7x8E5eRr+jtFr60nlbVYi/RGky
1njETSMfW+pyP+P/HVwPY6u1/iqPkX/BQdcVPTI/Qyz6DZ2EXTajVuVfp0S2lNGL
jGFVliyOc73HNeiQNxO8T1F6JybTz4ThNzYQEOdFyDT+PH1SRydDlrRy+1bNjkwn
xLi6vqxq7eXjVuqqRBchoegc2/CCCCML4jAY09mfuTfMwMSjyKjdUCKOAbJFRb74
090gWjprQKQG6BnLa7UpEyWV/12BaGqQ1Am2ARWJArpFEqJx+DNJdh8zDvF3bKpr
pGI0kiOzzHiee6L4yRqYo+lhCNN7idNoPwtWyyoyTdmTaBZMxWLMc2wOmVoIEvO0
T51fFmcznQztuhglDA8r7hcME9e6RLISkjSzqx9fHULPYwOKx2MjJRelyZ7LHPoi
I0Roti7iUgNZjSBw2KQowron+VP4HupZs/qVwmD4ii6ogHrzlz+wJJUecqZ1j8zK
L8tCcC1s7E2MGd22+77J
=ZWKp
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--

--===============7006971802725174766==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7006971802725174766==--
