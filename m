From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: pcm1792a: Add DAPM support
Date: Fri, 23 Aug 2013 16:36:06 +0100
Message-ID: <20130823153606.GA28838@sirena.org.uk>
References: <1376415048-6029-1-git-send-email-broonie@kernel.org>
 <1376415048-6029-2-git-send-email-broonie@kernel.org>
 <20130823151648.GA32473@panicking>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3363984412660794647=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 42AF72655BD
 for <alsa-devel@alsa-project.org>; Fri, 23 Aug 2013 17:36:25 +0200 (CEST)
In-Reply-To: <20130823151648.GA32473@panicking>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3363984412660794647==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 23, 2013 at 05:16:48PM +0200, Michael Trimarchi wrote:

> I'm working on support pcm1795 and pcm1796 too. They are registers compatible
> but different sample rate support. So the idea is three patches?

> - rename pcm1792a to pcm179x (is it possible?)
> - add three different dai for pcm1792a, pcm1795 and pcm1796
> - use of_device_id data pointer to select the correct dai

Yes, that seems like a good approach - no problem with the rename, just
make sure the existing users are updated.

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSF4FXAAoJELSic+t+oim9444P/iBDOfDYKmQW/jP8L5EW+Ekv
A244OTly6eQJZ1T74Wa5eZuhNVNkwH0NvRP1t53u+3u+QUyJs9kBlilsE8niXvQh
F1576x4PfaPCXgPwqtzojIsoh4ghpicVk7L+e0vKbOJrZWRRRWok3QrPk/S/t3mw
vCGdDemHlrysOKpTBdwM13ycaTypCHe7LPxORderqrkPaRBG1lumsulTpp+hVPMZ
bg/zouy6bkXE81FyTb4NXuf/T+E5ug/r7KS2tXSJFJGgKI8XDl2xS9iignYBuI2C
0+6nMp7rI1IRG1De4Igxk7jSb3T3YMEfZBbIsQLGXF4wdRi3ElBbvoSapJgSy4xI
7zWEru9y+K4uv3K+3BFpDcPd/sVZKTJynZpgJGr3pbTMXIeBpdvFbVizE+gDqpEq
1wjycDgZxqXQJJ8Pxu1LIpqDSSBViG1x3Dx1a55KEKafTGUjJs/JzKskGXSlcY5F
fEZ8g3cVypfJB7SRMdRxePId3OyUYhJ+UY+8T6paW2+jvLIIOKhRVYmtBUm2yINN
cSZkeGClZyrdnTwXxhNyU37x/ympB/HXHoF5r0oxgiXVgE1t+g5J12FOmEhD6E0G
3OVmYgvbOKWT1IkEPHzhTtscelNduGRnNjPWz9Kko225+sP3d9QnvFHZ8DrJCSDj
IHl6GGKBRnUZVR4g63M2
=HBYr
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--

--===============3363984412660794647==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3363984412660794647==--
