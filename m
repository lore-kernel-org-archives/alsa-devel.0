From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: dapm: Add regulator member to struct
	dapm_widget.
Date: Sun, 11 Mar 2012 13:11:38 +0000
Message-ID: <20120311131138.GI3233@opensource.wolfsonmicro.com>
References: <1331313616-9416-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4740273806942581015=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1937224332
	for <alsa-devel@alsa-project.org>; Sun, 11 Mar 2012 14:11:41 +0100 (CET)
In-Reply-To: <1331313616-9416-1-git-send-email-lrg@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============4740273806942581015==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OfrWf2Fun5Ae4m0Y"
Content-Disposition: inline


--OfrWf2Fun5Ae4m0Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 09, 2012 at 05:20:16PM +0000, Liam Girdwood wrote:
> Currently DAPM widgets use the private data for their regulator.
> Add a regulator * for widgets to use instead of private data.

Applied, thanks.

--OfrWf2Fun5Ae4m0Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPXKSCAAoJEBus8iNuMP3d1yAQAI1OYjM6SxAc3caZBC21gO+g
y2kVPmi97y3l5DZzOePw2R1w5dpy9pRIVNFDocaQDPdhh2L4RB79Jx7nNWT1RlcH
ryG2YjbRuu3BLaMVU876dGzaW8LlqdOCMPx5cptHYXHBo1JJJEcP2EvVShZsVaop
uZ/C2AS2RTuIfizpD1PVLtGcfKnxF32wwFuKenjpGzbmsp2l1MMHuP1ZB/6gdoC3
t5T72C3Y7CLJfLE7AON4C2/7hE7f7rj7LP6xnhfBT+qnq64ChyrFnOUqc0rrblHo
ifc7iAMtu26luwQZlorf9aVDSy9a35fhGoQC4Qx9pdCx7UHXhGD3tFNv+dcdBlzI
oGPd/CHoZ91LoaXngYguXYHUPObrX+LjaJmZu+J49lErtlsS9lPSYjzYbUoU/ixs
dENqpoe8EdNSjS88xeBY0OE69Hkr8/NDBe92sz8WXC41vumC02To9ihKD9u7ZWc4
BG7t7ephiwrFG1ut1TIgVTtAvvl60ngtJfdu5FGWY9i/oVlzT+eNmVg0XE3Q1Ozy
wOHfB/4HDDXfLL1+sDGbqoYNTJDl0ySspCF2J3uLI4XYKG8hjXWABPGPHMV933k5
lcTuvsdjSSmyEmpmeg8suG2WoUwAfWDQDyfqibg2RHreHyyBsQyPQaP9Hp+eSdhp
f7+biaxEImk1twmkfzXB
=+t8+
-----END PGP SIGNATURE-----

--OfrWf2Fun5Ae4m0Y--

--===============4740273806942581015==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4740273806942581015==--
