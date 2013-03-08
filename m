From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: Remove unused "n_widgets" field
 from snd_soc_dapm struct
Date: Fri, 8 Mar 2013 20:45:20 +0800
Message-ID: <20130308124518.GJ28481@opensource.wolfsonmicro.com>
References: <1362746667-8919-1-git-send-email-lars@metafoo.de>
 <1362746667-8919-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7583449801949647373=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 22512261724
 for <alsa-devel@alsa-project.org>; Fri,  8 Mar 2013 13:46:16 +0100 (CET)
In-Reply-To: <1362746667-8919-2-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============7583449801949647373==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qD3brAgIG4LbUq6d"
Content-Disposition: inline


--qD3brAgIG4LbUq6d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 08, 2013 at 01:44:27PM +0100, Lars-Peter Clausen wrote:
> Commit 497098be ("ASoC: dapm: Remove bodges for no-widget CODECs") removed the
> last user of the n_widgets field. Currently it is incremented for each widget
> added, but the value is never used, so we can remove it.

Applied both, thanks.

--qD3brAgIG4LbUq6d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJROd1KAAoJELSic+t+oim9D88P/0vmn9+hKkNE17ez8jINNggJ
N5Y39XjTHd5GsL8ix79Lnl8QXcDLIVaSem16bsRgSdt723LdGb1VN6NlpvJKK9dT
bUnZp/64n5VUJjNEQcFReYUuTHKPDcmSmCqLAHWGSmmwdfXsCztw0tSC6/Mvk7+t
A3ZjIrJJ58STzcZpvaBfVlKGvnMDvGndN0b+YIFs1DqJmpcNv9M3dxx7T1dRbR4M
lIyId5ucID4MGQmBvN+7aOz3XRfp79mVEYe3l1dDVzfGgQ0AG5v+sH8KQ+V/CR83
eg19S3KWlaCKFhJrvXmk1gL94D7dVsv6pypYLgDfGH4hmNRoqxT6vPIeIw4wjsdq
qAjT3+0DgXTkpmhiDxN/FTQFwc8aS1JtW3YB1ll1eZdGsMjBJAwP5LAu0q6e7duH
oAhpJqGGPu9oFScPErRQTXSHWaqP/UEz0AhtAij2Oetl7lj4gdqgNoal8IIj7d7o
+fwa4DPzWNdW+uS5yH7kSz8qtIW+68Em4X9WgDXbMWHn8u5ybJ3tUS5Fi3tqMSnA
Om9OP/NmROOgybnsA4s80HAHW/jV+fp9j1KT9IbpPxTtqkULh3qms90vRVTDuQ2F
t1aDi4+RQG6hCGCAiS+DWd3E5V6PkM3Aa+moATL1ZdI7kL1wpFi0pFhRa9RCHbK1
6KddlPFpr8V/Obhwh7um
=PRRn
-----END PGP SIGNATURE-----

--qD3brAgIG4LbUq6d--

--===============7583449801949647373==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7583449801949647373==--
