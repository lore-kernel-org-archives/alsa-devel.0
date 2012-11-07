From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [Resend PATCH v3 2/4] ARM: at91: atmel-ssc: add device tree
 support
Date: Wed, 7 Nov 2012 10:21:24 +0100
Message-ID: <20121107092124.GE12323@opensource.wolfsonmicro.com>
References: <1352259701-19847-1-git-send-email-voice.shen@atmel.com>
 <20121107084932.GE20063@game.jcrosoft.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lteA1dqeVaWQ9QQl"
Return-path: <linux-sound-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20121107084932.GE20063@game.jcrosoft.org>
Sender: linux-sound-owner@vger.kernel.org
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Bo Shen <voice.shen@atmel.com>, nicolas.ferre@atmel.com, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, fengguang.wu@intel.com
List-Id: alsa-devel@alsa-project.org


--lteA1dqeVaWQ9QQl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 07, 2012 at 09:49:32AM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:

> yes the pinctrl is mainline in -next via pinctrl tree

> s code does not work on the DT kernel untill it's done

> NACK stand I refuse this touch the at91 dtsi untiol it's done correctly

...and here's another mail (plus a further private mail on the same
subject) by the time I managed to reply to the first one, the timestamps
say in about ten minutes :/  What I'm seeing here is two of the Atmel
maintainers disagreeing about a patch so I've got to pick one view and
right now applying the patch looks like it moves us further forwards.

Like I say it's not an issue right now and it seems like it should be
trivial to fix.  Is anything needed here other than adding the
pinctrl_get_set_default() call, in which case would it not be less
effort all round to just send the patch?  If there is more involved then
what is needed?

Thinking about it a little more I'm actually wondering why whatever
pinctrl change made this mandatory didn't go through and update all the
drivers.

--lteA1dqeVaWQ9QQl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQmigNAAoJELSic+t+oim9S2AP/3VEl9akQMaE+NOglmg9wKDf
5IkGR9/vra0AYgzeTUHvH8uRstlwy7w8GjwyVfs8rhEwLCNw1qfgLXrhOB8fbD1/
aXa+UawRZ26yFSrKR6MxAOXl5IOAivyOYKz38ebffb+OO5C0jCSnk9ahC8zlBdjE
KmEf5gBp1xtQEs3ospTkZ7kiLEePlDQ/HTujtqZ2xcEBJIVFWCHTnXOK099aVqcs
SRakAxUsQ8tqd7iuDkTe9I50upF2tibeRzntSuIS3RET5j9BZrQyeGbSmoGNg7Xn
OzeLGDtC7P8ip2mcEiKi/rSO5HrO6s9urv/v5FKHXqDe7hakqogPth4nzQgV6O8m
kg3bC2ACYQ/LdHRt+EeMuKmntkrU18pbuQUqjT2D8Pv7TEp3cdKOrh5xVWc1GrF0
yh0VGM3SvGvMjqXsYUJriMu5I10n/MCv55E001rPIXLGmDWP8+HtzkyA1C5lhTk6
ChuZpF+ZiT05EFrWeRLs0TBN4i1eEWHzI5v9eWDYiCkQCTV43uZ7lrXcnnyHR10L
RxCcLrAK3Gt2w5+vbalxp03Ry9XGxij8gCNQFxYCX1bVGWPIxvIocizropCTVFyz
wV4Iv5KNlqXltIMoQ9QjYI6jUB4TFtAiipFxMjYA+PmVXM9k6qCnhsnSpk/kK8Su
t4q1AxcpRc8UQvbeKFog
=5Z76
-----END PGP SIGNATURE-----

--lteA1dqeVaWQ9QQl--
