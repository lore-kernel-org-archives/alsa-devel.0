From: Matt <matt@embeddedalley.com>
Subject: [PATCH] SigmaTel HDA resume support
Date: Sun, 26 Jun 2005 18:22:34 -0700
Message-ID: <20050626182234.A2032@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: tiwai@suse.de, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Adds resume support to the SigmaTel HDA patch. Please apply.

Signed-off-by: Matt <matt@embeddedalley.com>

diff -u alsa-kernel/pci/hda/patch_sigmatel.c alsa-kernel/pci/hda/patch_sigmatel.c
--- alsa-kernel/pci/hda/patch_sigmatel.c	26 Jun 2005 01:09:35 -0000
+++ alsa-kernel/pci/hda/patch_sigmatel.c	27 Jun 2005 00:24:35 -0000
@@ -828,11 +828,32 @@
 	kfree(spec);
 }
 
+#ifdef CONFIG_PM
+static int stac92xx_resume(struct hda_codec *codec)
+{
+	struct sigmatel_spec *spec = codec->spec;
+	int i;
+
+	stac92xx_init(codec);
+	for (i = 0; i < spec->num_mixers; i++)
+		snd_hda_resume_ctls(codec, spec->mixers[i]);
+	if (spec->multiout.dig_out_nid)
+		snd_hda_resume_spdif_out(codec);
+	if (spec->dig_in_nid)
+		snd_hda_resume_spdif_in(codec);
+
+	return 0;
+}
+#endif
+
 static struct hda_codec_ops stac92xx_patch_ops = {
 	.build_controls = stac92xx_build_controls,
 	.build_pcms = stac92xx_build_pcms,
 	.init = stac92xx_init,
 	.free = stac92xx_free,
+#ifdef CONFIG_PM
+	.resume = stac92xx_resume,
+#endif
 };
 
 static int patch_stac9200(struct hda_codec *codec)


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
