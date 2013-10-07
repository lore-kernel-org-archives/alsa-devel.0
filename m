From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: tlv320aic3x: Connect 'Left Line1R
 Mux' and 'Right Line1L Mux'
Date: Mon, 7 Oct 2013 12:04:49 +0100
Message-ID: <20131007110449.GI21581@sirena.org.uk>
References: <1381136359-26931-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4920561027778941080=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 7EADC265071
 for <alsa-devel@alsa-project.org>; Mon,  7 Oct 2013 13:04:55 +0200 (CEST)
In-Reply-To: <1381136359-26931-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4920561027778941080==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7SrMUQONj8Rl9QNG"
Content-Disposition: inline


--7SrMUQONj8Rl9QNG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 07, 2013 at 11:59:19AM +0300, Peter Ujfalusi wrote:
> The two paths were not connected in the DAPM route causing the associated
> routes to be non working and the following warnings printed in the logs:
> tlv320aic3x-codec 0-001b: ASoC: mux Right Line1L Mux has no paths
> tlv320aic3x-codec 0-001b: ASoC: mux Left Line1R Mux has no paths

Applied, thanks.

--7SrMUQONj8Rl9QNG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSUpVOAAoJELSic+t+oim9bAQQAJeBdRkUFCEtOs//i0w+n1Mb
/vfEOkKR6RohtdxGpHVb8jlzFCsVK8V7XeJu+VO1zVGN1SGrUJ4mMBAjimyTicS7
lc0RejCGMofrDwBbI0/z9jbAwj4ShB95DEigE9evhpas3WPKE6O85KU5xZohAdeN
KjVRjNrt6bV0Zv0ezL1/99IwA8y70TPsyDiJepDP+dpAS78Jbxox/jKEUzoRnlvD
o6pC5V0saacah6Czou5OFFsof5JQPdUN1wzO7A08KrsUbjiyqpKirn+sXmIAsc9U
iplFHXFEcOpwG0qKSCUkGwMXt69tkrNZI2PaLKKAeTFraHrdkecW+DPKbiB2HSeL
kBgeDAF53NJTQ03JKCBUvAx/8GbSY2OaLBKl850pacEhewC1RjB9yUnJILpHB5tx
PEeZ9HXZ/WQK4+DIy9ce9dB1aHWzmffWLvPjesjYEpSBT/ZRYKOMDHnJcMC2ox5H
v/MObWS74Qb5wRzW3zSBdRtcMmOB9rMxKxjoo5xdqdefBvuw+PucvDjxg9oaaWs6
3aoTHa8jLLw3XxcLf+RL1RbGYvuovcYX8KxmMlR3R9dXRH49qI1HeqzDBXzQNeQr
oXqiQ1wH3N+sK0dc3tQZzebQP58y5la/TqPEfJMIoZMrGYODw8d3CCqMQEvfrkq4
WYp8aw3zRUw22/2W5rBQ
=jZ7o
-----END PGP SIGNATURE-----

--7SrMUQONj8Rl9QNG--

--===============4920561027778941080==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4920561027778941080==--
