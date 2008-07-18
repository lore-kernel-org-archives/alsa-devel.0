From: Marek Vasut <marek.vasut@gmail.com>
Subject: [PATCH] wm9712 mono mixer
Date: Sat, 19 Jul 2008 00:51:25 +0200
Message-ID: <200807190051.25749.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_t5RgI4Ej9ESfSrX"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.184])
	by alsa0.perex.cz (Postfix) with ESMTP id 12738245BB
	for <alsa-devel@alsa-project.org>;
	Sat, 19 Jul 2008 00:49:15 +0200 (CEST)
Received: by fk-out-0910.google.com with SMTP id b27so339359fka.0
	for <alsa-devel@alsa-project.org>; Fri, 18 Jul 2008 15:49:14 -0700 (PDT)
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
Cc: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_t5RgI4Ej9ESfSrX
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,
this fixes typo in wm9712 codec which prevents it from registering all audio 
routes (and thus working correctly). Please consider applying.

(Tested and works on palmtx, palmld and palmt5)

--Boundary-00=_t5RgI4Ej9ESfSrX
Content-Type: text/x-diff;
  charset="iso 8859-15";
  name="01-wm9712-mixer-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="01-wm9712-mixer-fix.patch"

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index 9fc8edd..1fb7f9a 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -427,20 +427,20 @@ static const struct snd_soc_dapm_route audio_map[] = {
 	{"HPOUTR", NULL, "Headphone PGA"},
 	{"Headphone PGA", NULL, "Right HP Mixer"},
 
-	/* mono hp mixer */
-	{"Mono HP Mixer", NULL, "Left HP Mixer"},
-	{"Mono HP Mixer", NULL, "Right HP Mixer"},
+	/* mono mixer */
+	{"Mono Mixer", NULL, "Left HP Mixer"},
+	{"Mono Mixer", NULL, "Right HP Mixer"},
 
 	/* Out3 Mux */
 	{"Out3 Mux", "Left", "Left HP Mixer"},
 	{"Out3 Mux", "Mono", "Phone Mixer"},
-	{"Out3 Mux", "Left + Right", "Mono HP Mixer"},
+	{"Out3 Mux", "Left + Right", "Mono Mixer"},
 	{"Out 3 PGA", NULL, "Out3 Mux"},
 	{"OUT3", NULL, "Out 3 PGA"},
 
 	/* speaker Mux */
 	{"Speaker Mux", "Speaker Mix", "Speaker Mixer"},
-	{"Speaker Mux", "Headphone Mix", "Mono HP Mixer"},
+	{"Speaker Mux", "Headphone Mix", "Mono Mixer"},
 	{"Speaker PGA", NULL, "Speaker Mux"},
 	{"LOUT2", NULL, "Speaker PGA"},
 	{"ROUT2", NULL, "Speaker PGA"},

--Boundary-00=_t5RgI4Ej9ESfSrX
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_t5RgI4Ej9ESfSrX--
