From: "Rongrong Cao" <rrcao@ambarella.com>
Subject: [PATCH] sound dapm: fix check for external widgets bug (based on linux-2.6.30.1)
Date: Mon, 6 Jul 2009 05:55:27 -0700
Message-ID: <90B0CE4312136749B97EBEAF5764F87403C8F2D3@ambarella-ex.ambarella.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754870AbZGFNKs@vger.kernel.org>
Content-class: urn:content-classes:message
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@opensource.wolfsonmicro.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, trivial@kernel.org
List-Id: alsa-devel@alsa-project.org

=46rom: Rongrong Cao rrcao@ambarella.com

This patch is based on linux-2.6.30.1
In SOC DAPM layer of SOUND subsystem, when add signal route (in the fun=
ction snd_soc_dapm_add_route() ),=20
the original code has wrong logic when dapm layer check each widget whe=
ther an external one.

-----------------------------------------------------------------------=
----------------------------------

--- linux-2.6.30.1/sound/soc/soc-dapm.c.orig    2009-07-06 19:48:43.000=
000000 +0800
+++ linux-2.6.30.1/sound/soc/soc-dapm.c 2009-07-06 19:03:15.000000000 +=
0800
@@ -983,8 +983,8 @@ static int snd_soc_dapm_add_route(struct
        if (wsink->id =3D=3D snd_soc_dapm_input) {
                if (wsource->id =3D=3D snd_soc_dapm_micbias ||
                        wsource->id =3D=3D snd_soc_dapm_mic ||
-                       wsink->id =3D=3D snd_soc_dapm_line ||
-                       wsink->id =3D=3D snd_soc_dapm_output)
+                       wsource->id =3D=3D snd_soc_dapm_line ||
+                       wsource->id =3D=3D snd_soc_dapm_output)
                        wsink->ext =3D 1;
        }
        if (wsource->id =3D=3D snd_soc_dapm_output) {

-----------------------------------------------------------------------=
----------------------------------

Signed-off-by: Rongrong Cao rrcao@ambarella.com

********************
Best regards!
Allen (Rongrong) Cao
Ambarella Shanghai Ltd.
Tel:=A0=A0 (86-21) 50942311
=46ax:=A0 (86-21) 50942321
