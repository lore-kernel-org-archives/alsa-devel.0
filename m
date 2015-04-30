From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 6/7] ASoC: hda: Add support for SSP register
 settings
Date: Thu, 30 Apr 2015 15:36:42 +0100
Message-ID: <20150430143642.GX22845@sirena.org.uk>
References: <1429390653-8194-1-git-send-email-vinod.koul@intel.com>
 <1429390653-8194-7-git-send-email-vinod.koul@intel.com>
 <20150424175532.GD22845@sirena.org.uk>
 <20150426141831.GS2738@intel.com>
 <20150427141509.GS22845@sirena.org.uk>
 <55416D07.6060204@linux.intel.com>
 <55416E36.7090208@linux.intel.com>
 <20150430043941.GK3521@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7191663340301027126=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 93271261A0D
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2015 16:36:50 +0200 (CEST)
In-Reply-To: <20150430043941.GK3521@localhost>
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
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, Hardik T Shah <hardik.t.shah@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============7191663340301027126==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NTOVO8yPnPpjB3od"
Content-Disposition: inline


--NTOVO8yPnPpjB3od
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 30, 2015 at 10:09:41AM +0530, Vinod Koul wrote:
> On Wed, Apr 29, 2015 at 06:50:14PM -0500, Pierre-Louis Bossart wrote:

> > >That said I am not sure how this code would work on SKL. Vinod, isn't
> > >this for BXT only? how do you get 19.2 on SKL, shouldn't you guys use a
> > >24 MHz root frequency to find the divider?

> > And regardless you should make sure that the actual blck does not
> > exceed the maximum serial bit-rate supported by the SOC (AC timing).

> Yes botha re valid points. But I do rember one of the platforms has 10.2 and
> another has 25, so we need to be agnostic here and do compare, or use ACPI
> blobs :)

If this is under the control of the system integrators then I'd suggest
you're going to see the configuration being used.

--NTOVO8yPnPpjB3od
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVQj35AAoJECTWi3JdVIfQuZIH/A0WAzK10Kk47EERLUWGFayI
qSUPdJp63c2gJM43g5aiWhcVRSTP0AmxKpEkdmB1em1Uy3mH6SA6d0n62cIfy4tL
WkX8R55q2x3H2rWpRckHhIv7lB1jE06B+wAEiHVts0jyvs3aoSLjfgRqgz/z1s6b
V5gGJJRUV9YktX3CbtUGVMn9can+D0cvjVtl8t6TaGG8NLngrv7y/6wziJbr7Lbt
LXI7Pn4OYowAn9eaHJ7tMMI2wbXwp0M2tcotFrvaw7t/SsOtMm/qERXb/2nGTEF7
+tcKJZvAZ/SMrn4iwn28CmSZlZ4WPjTJRTdvpD1GoPDC0v5WL584L7BlToAf+jI=
=6qB8
-----END PGP SIGNATURE-----

--NTOVO8yPnPpjB3od--

--===============7191663340301027126==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7191663340301027126==--
