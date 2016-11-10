From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 06/10] ASoC: doc: ReSTize machine.txt
Date: Thu, 10 Nov 2016 22:47:18 +0100
Message-ID: <20161110214722.14698-7-tiwai@suse.de>
References: <20161110214722.14698-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 12AAA2673D4
 for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2016 22:47:28 +0100 (CET)
In-Reply-To: <20161110214722.14698-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

A simple conversion from a plain text file.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 Documentation/sound/soc/index.rst                  |  1 +
 .../{alsa/soc/machine.txt => soc/machine.rst}      | 22 +++++++++++++---------
 2 files changed, 14 insertions(+), 9 deletions(-)
 rename Documentation/sound/{alsa/soc/machine.txt => soc/machine.rst} (90%)

diff --git a/Documentation/sound/soc/index.rst b/Documentation/sound/soc/index.rst
index c5a55195bf4d..4ac3585e7dd1 100644
--- a/Documentation/sound/soc/index.rst
+++ b/Documentation/sound/soc/index.rst
@@ -12,3 +12,4 @@ The documentation is spilt into the following sections:-
    dai
    dapm
    platform
+   machine
diff --git a/Documentation/sound/alsa/soc/machine.txt b/Documentation/sound/soc/machine.rst
similarity index 90%
rename from Documentation/sound/alsa/soc/machine.txt
rename to Documentation/sound/soc/machine.rst
index 6bf2d2063b52..515c9444deaf 100644
--- a/Documentation/sound/alsa/soc/machine.txt
+++ b/Documentation/sound/soc/machine.rst
@@ -1,3 +1,4 @@
+===================
 ASoC Machine Driver
 ===================
 
@@ -9,9 +10,10 @@ interrupts, clocking, jacks and voltage regulators.
 The machine driver can contain codec and platform specific code. It registers
 the audio subsystem with the kernel as a platform device and is represented by
 the following struct:-
+::
 
-/* SoC machine */
-struct snd_soc_card {
+  /* SoC machine */
+  struct snd_soc_card {
 	char *name;
 
 	...
@@ -33,7 +35,7 @@ struct snd_soc_card {
 	int num_links;
 
 	...
-};
+  };
 
 probe()/remove()
 ----------------
@@ -55,9 +57,10 @@ initialisation e.g. the machine audio map can be connected to the codec audio
 map, unconnected codec pins can be set as such.
 
 struct snd_soc_dai_link is used to set up each DAI in your machine. e.g.
+::
 
-/* corgi digital audio interface glue - connects codec <--> CPU */
-static struct snd_soc_dai_link corgi_dai = {
+  /* corgi digital audio interface glue - connects codec <--> CPU */
+  static struct snd_soc_dai_link corgi_dai = {
 	.name = "WM8731",
 	.stream_name = "WM8731",
 	.cpu_dai_name = "pxa-is2-dai",
@@ -66,16 +69,17 @@ static struct snd_soc_dai_link corgi_dai = {
 	.codec_name = "wm8713-codec.0-001a",
 	.init = corgi_wm8731_init,
 	.ops = &corgi_ops,
-};
+  };
 
 struct snd_soc_card then sets up the machine with its DAIs. e.g.
+::
 
-/* corgi audio machine driver */
-static struct snd_soc_card snd_soc_corgi = {
+  /* corgi audio machine driver */
+  static struct snd_soc_card snd_soc_corgi = {
 	.name = "Corgi",
 	.dai_link = &corgi_dai,
 	.num_links = 1,
-};
+  };
 
 
 Machine Power Map
-- 
2.10.2
