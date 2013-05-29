From: Mark Brown <broonie@kernel.org>
Subject: Re: "Negative" volume settings in a kcontrol
Date: Wed, 29 May 2013 20:42:11 +0100
Message-ID: <20130529194211.GB5180@sirena.org.uk>
References: <51824609.30405@canonical.com> <1367498241.8766.3.camel@localhost>
 <5182746C.1070603@topic.nl> <5187AEA5.1020108@ladisch.de>
 <51A49907.70105@topic.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6880838022476641471=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 631BC265019
 for <alsa-devel@alsa-project.org>; Wed, 29 May 2013 21:42:30 +0200 (CEST)
In-Reply-To: <51A49907.70105@topic.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============6880838022476641471==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R3G7APHDIzY6R/pk"
Content-Disposition: inline


--R3G7APHDIzY6R/pk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 28, 2013 at 01:46:15PM +0200, Mike Looijmans wrote:
> On 05/06/2013 03:22 PM, Clemens Ladisch wrote:
> >Mike Looijmans wrote:

*ALWAYS* CC maintainers on mails and don't drop people from CCs either...

> >There are some ASoC helper macros that handle signed register fields, such
> >as SOC_DOUBLE_S8_TLV and SOC_SINGLE_XR_SX.  If those don't do what you want,
> >you have to write your own.

> SOC_DOUBLE_S8_TLV seems to be a misnamed hardware-specific macro. It
> provides no way to specify the location of the left/right bits so
> the macro name is misleading.

That's trivially fixable...

> SOC_SINGLE_XR_SX is too new for my kernel. And from what I gather, I
> cannot use it anyway for my purposes. So the solution turns out to

What makes you gather this?

--R3G7APHDIzY6R/pk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRploQAAoJELSic+t+oim9JdUP/A1Ssngd2aKB453Jpp9AHqHw
Z89Ne37PTjC/4kV3tfPNeEyugyz+/2sFJW3ptqfjwERNgV+iSK0WafPDKpHKxxM4
k9cvPl+Ms3d5reO9QcluLcyitebjXgUOd8CnceCxPKrTVOEDn0mpM8SDFDWnHR74
EvfjopN5TyReNwIxJAx8+U3GCKN4qKxLBERe4IIlbweptmyltneDys5EeHIPg1HH
AyA1c9OYLMCVdjV7sutG5Gc34UvBpI/zkPrXlLiOwEV8xOk29W4w+R8KhaIolX8E
nU51wf8zoJDUUXghIsRN+9GKfMNd28L11E+sew3Bino9SEYt2F4pn8yfpHnK7atq
WW7Rc5CFWa2FOCXz45y8c+NCut62UVkuqmLK3EKwBOz5/FMwYgmErn5etGcNNh6Q
nmoh4NuIEKH0utQdqqSD5Uzg/QMJTdU7Khyb7HpaOu72XEnkRaAnaqMR5SKj5C5D
eXgNKttInDy5kDZbmT/zSRWCwCET/sR5Pm4BidwMyitgLjFtioNkxBUxddKqNYDf
uSIccE0WdTW4t7IedZOMd34+46MUb5WvTNCntVBh5euBYZ3Wg2E2E989OaivWRus
/ATVPsitoAFh3hirLEogsJWjO89RxYsKqZfe6l7rpTYLze7sAL7N/TioqtDiDxXd
W2j+ctM2fXWn1Rlwmwny
=7BTh
-----END PGP SIGNATURE-----

--R3G7APHDIzY6R/pk--

--===============6880838022476641471==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6880838022476641471==--
