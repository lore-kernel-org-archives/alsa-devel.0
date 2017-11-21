From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH RFC] ARM: dts: bcm283x: Fix probing of
	bcm2835-i2s
Date: Tue, 21 Nov 2017 12:32:17 -0800
Message-ID: <87k1yjcqzy.fsf@anholt.net>
References: <1511110827-2726-1-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3128915139088678528=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from anholt.net (anholt.net [50.246.234.109])
 by alsa0.perex.cz (Postfix) with ESMTP id 1AAAA266F52
 for <alsa-devel@alsa-project.org>; Tue, 21 Nov 2017 21:32:22 +0100 (CET)
In-Reply-To: <1511110827-2726-1-git-send-email-stefan.wahren@i2se.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, kernel@martin.sperl.org, Matthias Reichl <hias@horus.com>, phil@raspberrypi.org
Cc: Stefan Wahren <stefan.wahren@i2se.com>, alsa-devel@alsa-project.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

--===============3128915139088678528==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

Stefan Wahren <stefan.wahren@i2se.com> writes:

> Since 517e7a1537a ("ASoC: bcm2835: move to use the clock framework")
> the bcm2835-i2s requires a clock as DT property. Unfortunately
> the necessary DT change has never been applied. While we are at it
> also fix the first PCM register range to cover the PCM_GRAY register.
>
> This patch also fixes the dt-bindings accordlingly.
>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Reviewed-by: Eric Anholt <eric@anholt.net>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAloUjVEACgkQtdYpNtH8
nuiazg//REHKfhYexJRA6GDHEjJkBRUsWGIQzUcRP1FIQlF7iAFr+ED6cr2i+13r
p3GRehQNNvgm8lG7VyRNxjhUpyFJcYZplF1kAFHbWBrlBKI1c+nNmU/RExSi67Wq
saCOnDFs0FmOgiZDs8g3VEyKt/IU4oe34CskO4jg0qCMxGEG1/qsaCdzxAMcA9nI
S92pE9vKjsQnM4Nq51dDOxMo1KbnDEvnF76p+XPmd/BVv77gryqnqD/a+Nky2PDm
vhPC6sqICiInRTLlLTW9YnK+Ko6aiun398IfTVsw42lHlOX3ss8P2kXWQynwrj9J
oACStLh6lsSS5KN5PHqL6/XSBaa1BXbQE7d7Xi080XjiSLs6O6RtyGD2CQW19tCa
IUJJvTaQJIFsE4zJrJBJUAtu+1nLp2KwGHhgVXmm5jokfJZXr7iUIGrSnYXHNlGQ
ArhLGsO+h6Qqej89wle3mj2+Ddam/4pzG1KZOiz2bMZrZK6zZCtfDfFsoERbHJTj
2ydrEt7hmY+0UZ9xbNlIpWrQ1j9H3B3K3xjZlxznfM2NGxlpkh9uPssAr5QmWSmF
Giu1BDZ02Dzmw6sTvFzmEKIxvnRaG4tlLjUz/GZBZqyp4lXwuWiP36cI0LXvRs1S
NdyYINho65rEKd8zWCKkTWNGNm8d9gHtk094eqYg/7lD4OyMrSQ=
=1/pD
-----END PGP SIGNATURE-----
--=-=-=--

--===============3128915139088678528==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3128915139088678528==--
