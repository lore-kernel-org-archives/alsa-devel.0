From: =?UTF-8?B?VXJzIEbDpHNzbGVy?= <urs.fassler@bytesatwork.ch>
Subject: [PATCH 2/2] davinci-mcasp: add option to use AHCLKX
 pin as clock in
Date: Fri, 06 Feb 2015 10:22:09 +0100
Message-ID: <54D487C1.1010901@bytesatwork.ch>
References: <1423212723-15307-1-git-send-email-urs.fassler@bytesatwork.ch>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6127478127744691913=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bytesatwork.ch (bytesatwork.ch [91.135.72.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9E599260570
 for <alsa-devel@alsa-project.org>; Fri,  6 Feb 2015 10:22:21 +0100 (CET)
In-Reply-To: <1423212723-15307-1-git-send-email-urs.fassler@bytesatwork.ch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz, tiwai@suse.de
Cc: urs.fassler@bytesatwork.ch, alsa-devel@alsa-project.org, lgirdwood@gmail.com, jsarha@ti.com, linux-kernel@vger.kernel.org, peter.ujfalusi@ti.com, broonie@kernel.org, misael.lopez@ti.com
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============6127478127744691913==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="xbFwehKtW749MDSPQILBv4ukLI5LlPcAB"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xbFwehKtW749MDSPQILBv4ukLI5LlPcAB
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Urs F=C3=A4ssler <urs.fassler@bytesatwork.ch>
---
 .../bindings/sound/davinci-mcasp-audio.txt         |  1 +
 sound/soc/davinci/davinci-mcasp.c                  | 26
+++++++++++++++++++---
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git
a/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
index 46bc982..22a91d2 100644
--- a/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
+++ b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
@@ -39,6 +39,7 @@ Optional properties:
   		 please refer to pinctrl-bindings.txt
 - fck_parent : Should contain a valid clock name which will be used as
parent
 	       for the McASP fck
+- ahclkx-pin : if set use AHCLKX pin for clock in instead of ACLKX
  Example:
 diff --git a/sound/soc/davinci/davinci-mcasp.c
b/sound/soc/davinci/davinci-mcasp.c
index 396cdec..3730288 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -85,6 +85,7 @@ struct davinci_mcasp {
  	int	sysclk_freq;
 	bool	bclk_master;
+	bool	ahclkx_pin;
  	/* McASP FIFO related */
 	u8	txnumevt;
@@ -429,7 +430,12 @@ static int davinci_mcasp_set_dai_fmt(struct
snd_soc_dai *cpu_dai,
 		break;
 	case SND_SOC_DAIFMT_CBM_CFS:
 		/* codec is clock master and frame slave */
-		mcasp_clr_bits(mcasp, DAVINCI_MCASP_ACLKXCTL_REG, ACLKXE);
+		if (mcasp->ahclkx_pin)
+			mcasp_set_bits(mcasp, DAVINCI_MCASP_ACLKXCTL_REG,
+				ACLKXE);
+		else
+			mcasp_clr_bits(mcasp, DAVINCI_MCASP_ACLKXCTL_REG,
+				ACLKXE);
 		mcasp_set_bits(mcasp, DAVINCI_MCASP_TXFMCTL_REG, AFSXE);
  		mcasp_clr_bits(mcasp, DAVINCI_MCASP_ACLKRCTL_REG, ACLKRE);
@@ -441,7 +447,12 @@ static int davinci_mcasp_set_dai_fmt(struct
snd_soc_dai *cpu_dai,
 		break;
 	case SND_SOC_DAIFMT_CBM_CFM:
 		/* codec is clock and frame master */
-		mcasp_clr_bits(mcasp, DAVINCI_MCASP_ACLKXCTL_REG, ACLKXE);
+		if (mcasp->ahclkx_pin)
+			mcasp_set_bits(mcasp, DAVINCI_MCASP_ACLKXCTL_REG,
+				ACLKXE);
+		else
+			mcasp_clr_bits(mcasp, DAVINCI_MCASP_ACLKXCTL_REG,
+				ACLKXE);
 		mcasp_clr_bits(mcasp, DAVINCI_MCASP_TXFMCTL_REG, AFSXE);
  		mcasp_clr_bits(mcasp, DAVINCI_MCASP_ACLKRCTL_REG, ACLKRE);
@@ -542,7 +553,12 @@ static int davinci_mcasp_set_sysclk(struct
snd_soc_dai *dai, int clk_id,
 	struct davinci_mcasp *mcasp =3D snd_soc_dai_get_drvdata(dai);
  	if (mcasp->bclk_master) {
-		mcasp_set_bits(mcasp, DAVINCI_MCASP_AHCLKXCTL_REG, AHCLKXE);
+		if (mcasp->ahclkx_pin)
+			mcasp_clr_bits(mcasp, DAVINCI_MCASP_AHCLKXCTL_REG,
+				AHCLKXE);
+		else
+			mcasp_set_bits(mcasp, DAVINCI_MCASP_AHCLKXCTL_REG,
+				AHCLKXE);
 		mcasp_set_bits(mcasp, DAVINCI_MCASP_AHCLKRCTL_REG, AHCLKRE);
 		mcasp_set_bits(mcasp, DAVINCI_MCASP_PDIR_REG, AHCLKX);
 	} else {
@@ -1340,6 +1356,8 @@ static struct davinci_mcasp_pdata
*davinci_mcasp_set_pdata_from_of(
 	if (ret >=3D 0)
 		pdata->sram_size_capture =3D val;
 +	pdata->clk_input_pin =3D of_property_read_bool(np, "ahclkx-pin");
+
 	return  pdata;
  nodata:
@@ -1412,6 +1430,8 @@ static int davinci_mcasp_probe(struct
platform_device *pdev)
 		goto err;
 	}
 +	mcasp->ahclkx_pin =3D pdata->clk_input_pin;
+
 	mcasp->op_mode =3D pdata->op_mode;
 	/* sanity check for tdm slots parameter */
 	if (mcasp->op_mode =3D=3D DAVINCI_MCASP_IIS_MODE) {
--=20
2.1.4



--xbFwehKtW749MDSPQILBv4ukLI5LlPcAB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU1IfBAAoJEKKADLnESIBjAmgP/3C7JKyILx0pCD4r2or+e9i7
/xo9yIBw7OXgk/mbpZWY3TGahAXSDgFkM0if+nxQW5B2q2V031/Tk1+0prtd6x8u
2bgBBDuJ7JwqWNLSHK5qJ+Z3xXqz4/ODEj0WMHhX4iRtKAblgN176j7CWjkqvkUi
7a+UP4MTKDFRCjdCe5M3LzzUli3qoHLUQqgz+LQtI2SsnURwZbdZgql8ecA4OuaV
PcxPJyAGoYTxY7LtbbPmO6CzGqei85eo7cXZC+O7Y2SFm2RpBgm70ndxrgj4BRpx
C3MywV2X2S4htSekFhJj/L3uhyNQDM2j/5qs2fBqQg6rOEGxl+sUfzOIVQH3pY0A
7yeVg+5U562mcrctTRLP35KI8kSOddihRqFEl/i6Gux0KrcctTDs3tFRl5SZImDO
JIZ2oh3C2HeT1ThKWh1KLy1lGJG0Rn98wqj1EnC0I1ECZSXYWBw2kv64elLiGTpI
DHYoxvQ/bK3MgQ/AIW/m6c8aEsCIPUs9RtUJm6jrt64p/tbf2uyygozXAoyQNX/J
wO0gP0DHmQwF8zL6XhYuP7QUDgynPU26N9tTeJt6rD9t+QDD3GemUMUHzSngYl/N
+mpbXh/lwZxT58ps6vCek+kgQ+OZh+Apl2asv7gm/d1o8fo8tc5UygRm8WrpKbRb
Ndbn05EdH91WvueGBgG3
=7ywu
-----END PGP SIGNATURE-----

--xbFwehKtW749MDSPQILBv4ukLI5LlPcAB--

--===============6127478127744691913==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6127478127744691913==--
