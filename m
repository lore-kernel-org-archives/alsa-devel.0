From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2 resend] ASoC: cs4271: preserve "Master
 Playback Switch" setting
Date: Fri, 22 Mar 2013 11:32:47 +0100
Message-ID: <20130322103247.GF22890@opensource.wolfsonmicro.com>
References: <1363895035-20356-1-git-send-email-zonque@gmail.com>
 <1363895035-20356-2-git-send-email-zonque@gmail.com>
 <20130322101820.GC22890@opensource.wolfsonmicro.com>
 <514C3124.8010806@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8985834548516700070=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9749126641B
 for <alsa-devel@alsa-project.org>; Fri, 22 Mar 2013 11:32:49 +0100 (CET)
In-Reply-To: <514C3124.8010806@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, subaparts@yandex.ru, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============8985834548516700070==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gdTfX7fkYsEEjebm"
Content-Disposition: inline


--gdTfX7fkYsEEjebm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 22, 2013 at 11:23:32AM +0100, Daniel Mack wrote:
> On 22.03.2013 11:18, Mark Brown wrote:

> > The usual fix for this is to just not have the mute operation if it's
> > important.  Otherwise this seems like something we ought to implement in
> > the core, it's not a silly feature by any stretch of the imagination but
> > it applies to any device with a DAI mute unless there's some device
> > specific thing I'm missing here.

> So I'd say having a simple OR logic in this case is reasonable and
> serves all the needs I can think of, no?

You're not really responding to what I'm saying here.  What I'm saying
is that if this is useful it should be implemented in the core unless
there's some reason I'm missing why this is specific to this driver.

--gdTfX7fkYsEEjebm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRTDNIAAoJELSic+t+oim9Y5gP+wREEdA3KobhTyfuUYgtLaJC
c6K1AAzd8pYtIVWQv5q0iUE3wZZ0WqZdVasya7HzKTXEPYu54+Ahnl/kLcHpPSw8
gxzoP47dJSSmUVnV/xts2SmRHUZUIJCiKI8SyDUwDS9+E2eQ5y8x/Upsz5gofBQV
2hAX97A0GZOp98cy3+GHpt3D2W2Z/SPt5754ICa/hMWAvWCbNqhXwJ9WnzpMvGQc
fwk59qOzt13+VyfZEtd/ncaDFcp+afuXqgN9iLsFT1uYcfxRUp/7wSB41O6Lepkv
mKDkdhK/Qr+wKVLQcXf94d21KfM4O6DwUua4Yw+mKv2TSZvrUorPhpOluBzDSlbu
1FDPIB9HQI5V1jp8HlK9LWT90xIsR5LslXE46hotFsTaXatKqeKNwxDUgui7YPDE
C8qfew/+dLBoUrPGa1FgysDiF0JyNv13oh/nAGqCA2GotOg7AsCApWNTWpUhSG1B
8MSDS2IbjaGkzu5KZdQEzU4WCBt2TQR7ryeyb+KI5QdBCiMNpInbJaBcA/v/oWVF
DrLJOyZYqEO5BwPVcQv2jHn4UCPTk+ehsOrVzxpHBOQZaTc/uKMjN+3Vd3aOZ8zR
quQMbY9Njs/d24yknlconWE88zbXhuU8db0DxXI6RtpZ51vO4KdSCKQ7TOSPvZbH
r4FKhMWzT9FsGy0tufki
=xY+W
-----END PGP SIGNATURE-----

--gdTfX7fkYsEEjebm--

--===============8985834548516700070==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8985834548516700070==--
