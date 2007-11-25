From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: [PATCH] soc/wm8731: Fix stereo mixer controls
Date: Sun, 25 Nov 2007 21:25:03 +0200
Message-ID: <20071125192503.GA16487@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp5.pp.htv.fi (smtp5.pp.htv.fi [213.243.153.39])
	by alsa0.perex.cz (Postfix) with ESMTP id D1882245E4
	for <alsa-devel@alsa-project.org>; Sun, 25 Nov 2007 20:25:05 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: richard@openedhand.com, liam.girdwood@wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

soc/wm8731: Fix stereo mixer controls

Disable the simultaneous load feature for the line in and headphone
out volume registers. This allows left and right volume levels to
be controlled separately.

Signed-off-by: Ville Syrjala <syrjala@sci.fi>
---

diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index 7ca0b52..57fb95a 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -562,13 +562,13 @@ static int wm8731_init(struct snd_soc_device *socdev)
 =

 	/* set the update bits */
 	reg =3D wm8731_read_reg_cache(codec, WM8731_LOUT1V);
-	wm8731_write(codec, WM8731_LOUT1V, reg | 0x0100);
+	wm8731_write(codec, WM8731_LOUT1V, reg & ~0x0100);
 	reg =3D wm8731_read_reg_cache(codec, WM8731_ROUT1V);
-	wm8731_write(codec, WM8731_ROUT1V, reg | 0x0100);
+	wm8731_write(codec, WM8731_ROUT1V, reg & ~0x0100);
 	reg =3D wm8731_read_reg_cache(codec, WM8731_LINVOL);
-	wm8731_write(codec, WM8731_LINVOL, reg | 0x0100);
+	wm8731_write(codec, WM8731_LINVOL, reg & ~0x0100);
 	reg =3D wm8731_read_reg_cache(codec, WM8731_RINVOL);
-	wm8731_write(codec, WM8731_RINVOL, reg | 0x0100);
+	wm8731_write(codec, WM8731_RINVOL, reg & ~0x0100);
 =

 	wm8731_add_controls(codec);
 	wm8731_add_widgets(codec);
-- =

Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/
