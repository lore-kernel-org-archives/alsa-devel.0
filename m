From: Randy Dunlap <rdunlap@xenotime.net>
Subject: [PATCH -next] ASoC: fix wm2200.c printk format warnings
Date: Fri, 19 Oct 2012 16:13:07 -0700
Message-ID: <5081DE83.2060402@xenotime.net>
References: <20121019135419.f996aed8ed85ee50a782a649@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20121019135419.f996aed8ed85ee50a782a649@canb.auug.org.au>
Sender: linux-next-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-next@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, moderated for non-subscribers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

From: Randy Dunlap <rdunlap@xenotime.net>

Fix wm2200.c printk format warnings (seen on x86_64):

sound/soc/codecs/wm2200.c:1027:4: warning: format '%d' expects type 'int', but argument 4 has type 'size_t'
sound/soc/codecs/wm2200.c:1139:5: warning: format '%d' expects type 'int', but argument 5 has type 'long unsigned int'
sound/soc/codecs/wm2200.c:1181:2: warning: format '%d' expects type 'int', but argument 7 has type 'size_t'
sound/soc/codecs/wm2200.c:1201:5: warning: format '%x' expects type 'unsigned int', but argument 3 has type 'long unsigned int'
sound/soc/codecs/wm2200.c:1264:4: warning: format '%d' expects type 'int', but argument 4 has type 'size_t'
sound/soc/codecs/wm2200.c:1328:5: warning: format '%d' expects type 'int', but argument 5 has type 'long unsigned int'

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
Cc:	Liam Girdwood <lrg@ti.com>
Cc:	Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc:	alsa-devel@alsa-project.org (moderated for non-subscribers)
---
 sound/soc/codecs/wm2200.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- linux-next-20121019.orig/sound/soc/codecs/wm2200.c
+++ linux-next-20121019/sound/soc/codecs/wm2200.c
@@ -1023,7 +1023,7 @@ static int wm2200_dsp_load(struct snd_so
 
 	pos = sizeof(*header) + sizeof(*adsp1_sizes) + sizeof(*footer);
 	if (pos >= firmware->size) {
-		dev_err(codec->dev, "%s: file too short, %d bytes\n",
+		dev_err(codec->dev, "%s: file too short, %zu bytes\n",
 			file, firmware->size);
 		return -EINVAL;
 	}
@@ -1135,7 +1135,7 @@ static int wm2200_dsp_load(struct snd_so
 	}
 
 	if (pos > firmware->size)
-		dev_warn(codec->dev, "%s.%d: %d bytes at end of file\n",
+		dev_warn(codec->dev, "%s.%d: %zu bytes at end of file\n",
 			 file, regions, pos - firmware->size);
 
 out:
@@ -1178,7 +1178,7 @@ static int wm2200_setup_algs(struct snd_
 	}
 
 	algs = be32_to_cpu(id.algs);
-	dev_info(codec->dev, "Firmware: %x v%d.%d.%d, %d algorithms\n",
+	dev_info(codec->dev, "Firmware: %x v%d.%d.%d, %zu algorithms\n",
 		 be32_to_cpu(id.fw.id),
 		 (be32_to_cpu(id.fw.ver) & 0xff000) >> 16,
 		 (be32_to_cpu(id.fw.ver) & 0xff00) >> 8,
@@ -1196,7 +1196,7 @@ static int wm2200_setup_algs(struct snd_
 	}
 
 	if (be32_to_cpu(val) != 0xbedead)
-		dev_warn(codec->dev, "Algorithm list end %x 0x%x != 0xbeadead\n",
+		dev_warn(codec->dev, "Algorithm list end %zx 0x%x != 0xbeadead\n",
 			 (sizeof(id) + (algs * sizeof(*alg))) / 2,
 			 be32_to_cpu(val));
 
@@ -1260,7 +1260,7 @@ static int wm2200_load_coeff(struct snd_
 	}
 
 	if (sizeof(*hdr) >= firmware->size) {
-		dev_err(codec->dev, "%s: file too short, %d bytes\n",
+		dev_err(codec->dev, "%s: file too short, %zu bytes\n",
 			file, firmware->size);
 		return -EINVAL;
 	}
@@ -1324,7 +1324,7 @@ static int wm2200_load_coeff(struct snd_
 	}
 
 	if (pos > firmware->size)
-		dev_warn(codec->dev, "%s.%d: %d bytes at end of file\n",
+		dev_warn(codec->dev, "%s.%d: %zu bytes at end of file\n",
 			 file, blocks, pos - firmware->size);
 
 	return 0;
