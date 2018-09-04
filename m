From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: tlv320aic31xx: Remove regulator notification
 handling
Date: Tue, 4 Sep 2018 15:57:40 +0100
Message-ID: <20180904145740.GE12993@sirena.org.uk>
References: <20180831181737.29516-1-afd@ti.com>
 <20180903113038.GG10302@sirena.org.uk>
 <b35860d4-70ec-a23f-41d4-7edc87869ccb@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0H629O+sVkh21xTi"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b35860d4-70ec-a23f-41d4-7edc87869ccb@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--0H629O+sVkh21xTi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 04, 2018 at 09:50:50AM -0500, Andrew F. Davis wrote:
> On 09/03/2018 06:30 AM, Mark Brown wrote:
> > On Fri, Aug 31, 2018 at 01:17:37PM -0500, Andrew F. Davis wrote:
> >> The notification handler sets the reset line but never re-enables it
> >> as no one is listening for an enable event, this is certainly broken
> >> and was most likely just copied from other CODECs, remove this code.

> > Why not fix it?  The usual pattern would be to take the CODEC out of
> > reset when bringing the bias back to standby.

> The only time this code gets called outside of the normal power on/off
> path is regulator_force_disable(). And the enable event is only called
> inside regulator_enable() which would already be part of the normal
> power up path.

It's there to save us having to rewrite the register cache if we asked
for the device to be powered down but that didn't actually happen due to
other constraints, we know all the registers are still as we left them.

--0H629O+sVkh21xTi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluOnWMACgkQJNaLcl1U
h9CJvAf/bjkIWA0GP2khzx/2gN/0oXMbKFzuMWCbIC8CtijpKjUAROWtKKFYYsGb
5b12ecQ2UNcViwxYImfHsZYsV2yewBPOHZoysbSCBv1KytI4BqJwz4+dBNiuKQuu
znw1/8n5bu9PP2oa2xx7BCjKpIJs9LFkQUBlnLDf8IkKMhAJvvIOUUemtXz1TeyL
EP3F1vSCw3gqNxiDJx9ZuZyeYHcToFTm49VBCaiei3W6DZrWbLH53yVHJQv8Jd7G
/PU0jubJ6/1+gnzJzhfrRQN0GMaV6K7iPuYu/iSctvgpGb/BK79uUiy/DdkZnTot
iKQstDW6IVcD6J1PwycZwn4QE55Jnw==
=Cu00
-----END PGP SIGNATURE-----

--0H629O+sVkh21xTi--
