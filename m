From: Christian Engelmayer <cengelma@gmx.at>
Subject: [PATCH] ASoC: Intel: Fix incorrect sizeof() in
 sst_hsw_stream_get_volume()
Date: Sun, 13 Apr 2014 19:56:36 +0200
Message-ID: <20140413195636.32f31cb2@spike>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2974238764588265933=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by alsa0.perex.cz (Postfix) with ESMTP id A0CAF261734
 for <alsa-devel@alsa-project.org>; Sun, 13 Apr 2014 19:56:59 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: alsa-devel@alsa-project.org

--===============2974238764588265933==
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/Vbp.Ey767=g0k8PnMBs3Z26"; protocol="application/pgp-signature"

--Sig_/Vbp.Ey767=g0k8PnMBs3Z26
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Fix an incorrect sizeof() usage in sst_hsw_stream_get_volume(). sst_dsp_rea=
d()
is called to read into a variable of type u32, but is passed sizeof(u32 *) =
for
argument 'size_t bytes'. Detected by Coverity: CID 1195260.

Signed-off-by: Christian Engelmayer <cengelma@gmx.at>
---
 sound/soc/intel/sst-haswell-ipc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/sst-haswell-ipc.c b/sound/soc/intel/sst-haswel=
l-ipc.c
index f46bb4d..455a185 100644
--- a/sound/soc/intel/sst-haswell-ipc.c
+++ b/sound/soc/intel/sst-haswell-ipc.c
@@ -991,7 +991,8 @@ int sst_hsw_stream_get_volume(struct sst_hsw *hsw, stru=
ct sst_hsw_stream *stream
 		return -EINVAL;
=20
 	sst_dsp_read(hsw->dsp, volume,
-		stream->reply.volume_register_address[channel], sizeof(volume));
+		stream->reply.volume_register_address[channel],
+		sizeof(*volume));
=20
 	return 0;
 }
--=20
1.8.3.2

--Sig_/Vbp.Ey767=g0k8PnMBs3Z26
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTSs/UAAoJEKssnEpaPQKEE6cP/RqjOPIHvxixyaLZtfsayWbJ
MfAMAcGLLxS1ctb7ffRzF+tIQLeG4/lfEuv4IfTLb4+R7J3CwrzoDbKjNbHzPWQi
BLXeoHiRgSAddolJW83fwi8wQZYOmDeLhhzM22RQCPetv8MHljC8F4cFb2j26o5H
pUPf1BkAzre4nLY7njaoB94WI1yG60AswG5FyuWfepreSpUIpnTby9BgYbpk/CjJ
gIvED5yRReq1MOOr1WcuSIsW7CJrIwIPTZ7gtkuftK3us7uD2A9J2emrhZq18xqm
kUVIEl/P7TOhUB5I2kI5PbijAfZBJchi2xmb1CGntKwxBlmOY/O9HekYQat8Ol8m
KislB9HjDA4DK2ctvnE7uPcsOCz366tHHNbU6Z/pEb+UT752EBW0XhBV4RyAPZgX
TKXsXU29XJsdwR9JXBO35PNgvmoUfWISDljsvp/5cxAV4t6zhOkuZIrS5fWZAban
LydT0BOQQcsIKwTrGE9iEmUhHlNpRej5M8X2Td2EL3Rqn86Yzgpw/UdpDjcptp1k
LdVMVD+qNbFyASqDXnJZIhZaFPH/vIYFRiHic5EZvNUFQ+YWcpjEacjYge637HVV
VD0AkS4eEsD3ZWcznmC8tOn8ba/62MLSwUqFUk/ggAX7taVp1UIILj4z0TJZL7Kg
t7346X+P8s3pKztDIlIT
=U4jA
-----END PGP SIGNATURE-----

--Sig_/Vbp.Ey767=g0k8PnMBs3Z26--

--===============2974238764588265933==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2974238764588265933==--
