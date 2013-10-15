From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: Audio Miniconference 2013 schedule II - Edinburgh
	21st October
Date: Tue, 15 Oct 2013 22:14:08 +0530
Message-ID: <20131015164408.GQ2954@intel.com>
References: <20131014161003.GC2443@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2293748885041658960=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by alsa0.perex.cz (Postfix) with ESMTP id A3A8C2610B1
 for <alsa-devel@alsa-project.org>; Tue, 15 Oct 2013 19:37:33 +0200 (CEST)
In-Reply-To: <20131014161003.GC2443@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Colin Guthrie <colin@guthr.ie>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Arun Raghavan <arun.raghavan@collabora.co.uk>, Liam Girdwood <liam.r.girdwood@intel.com>, Tanu Kaskinen <tanuk@iki.fi>, David Henningsson <david.henningsson@canonical.com>, "Bossart,
 Pierre-louis" <pierre-louis.bossart@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============2293748885041658960==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Cgrdyab2wu3Akvjd"
Content-Disposition: inline


--Cgrdyab2wu3Akvjd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2013 at 05:10:03PM +0100, Mark Brown wrote:
> Another go at the schedule for the mini-summit based on the feedback
> last time.  Same three major topics:
>=20
>  - Compressed audio review: tinycompress, integration into userspace,
>    driver upstreaming.
Sorry I am not going to make it the conf!

I will send out the status of offload, challanges, drivers (not many) befor=
e you
guys start the meeting. Together with Eric's usermode and Android update it
should cover well. I would have loved to see something on PA side too.

Arun any plans to implement support for compressed offload?

>  - UCM and other use case management status & review (Tanu).
>=20
>  - Effects offload to DSPs with dynamically instantiatable algorithms,
>    and general dynamic DSP firmware handling including DSP resource
>    management (Pierre).
We are working on effect offloading part and creating framework in sound for
DSPs to do that. Hopefully we should be able to push an RFC before this wee=
k and
you guys with Pierre can discuss this over the meeting and provide feedback=
 for
future work on this topic

> Plus a few things that only one or two people brought up:
>=20
>  - Process stuff (the list, bug tracking and so on).
>=20
>  - Some relatively specific hardware support topics:
>   - HDMI hotplug handling throughout the stack
>   - Mic status LED handling throughout the stack.
>=20
>  - Code cleanups:
>   - Moving away from the custom ALSA device registration infrastructure.
>   - General code modernisation.
>=20
>  - Performance, especially DAPM (Patrick)
I want to bring the attention to DAPM framework bugs. Somehow recently I
stumbled on quite a few occasions of DAPM bugs and the best part was that t=
he
fix was already availble upstream, ported to stable later version than I ha=
d or
NOT ported. Mark, can you pls help by ensuring the right fixes are marked to
stable so that users dont get hit by it!

~Vinod

--Cgrdyab2wu3Akvjd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJSXXDYAAoJEHwUBw8lI4NHb0AP+weQsMkOZcDwlHecv53x3EgZ
Fpq5OVp/GrAdjR+TqoJO/qzffuULwXFFzSc1pY8RVwfBswdqAz+UtYpRhwNGjFt1
n0jC4aMRFUCE7XJoB3FFnX2efI4sxM3VqKNReJIo5eW2CUv32SpZLMh1XVtDPdds
mN/MR+rdbkQDAhOcZBX1PFp7GP4a0BwYaE/Dq2xYYa6+trMuYnUUlojAlGI0T8yI
++8i9lbgT6ufeL+l7fOJ5yh4bgqGvWhAoNTtV1wgSeOWLOuYpN4o6NzmnGa+e3K0
mGRM6y5NN5ap07C7/254UK4uUCCTv7VcDPKBr1SPn6yZ3jBP0vx50cIBX9wtQPE2
IeHl5Hf8J78KviFYhNk0Dl1cgYsW9bYAMyE9hWvT0XSavvMr5RDLAQ+mvHvVPz5p
PIQPBoAHfsJKDaazsTU7/3220z/CeG25JDym/sGtNztgYQZxEWx5Qq228sJa09qM
at6cxmAcOQgDAW1KeoIklrYIV5FhrYbXltCdYdIv6QvmjEme3ofGwknnYcVSlof3
sqw23lKpngRDwTQ4bHMf5gzPr1USI95BmlclifYt2Cvqv03gu5rChpmAJNgI1NCk
7WKjvdPJGd7Aw/i0U2+8AdQ9qLsPcfr6wEi3d2AwGdkuUA8MhOo5tbaxlaD7Rd1f
+B4jhcy4lCtjUZFUZU60
=EZZ+
-----END PGP SIGNATURE-----

--Cgrdyab2wu3Akvjd--

--===============2293748885041658960==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2293748885041658960==--
