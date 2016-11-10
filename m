From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 05/10] ASoC: doc: ReSTize platform.txt
Date: Thu, 10 Nov 2016 22:47:17 +0100
Message-ID: <20161110214722.14698-6-tiwai@suse.de>
References: <20161110214722.14698-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 143DE2673D8
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
 .../{alsa/soc/platform.txt => soc/platform.rst}    | 31 ++++++++++++----------
 2 files changed, 18 insertions(+), 14 deletions(-)
 rename Documentation/sound/{alsa/soc/platform.txt => soc/platform.rst} (81%)

diff --git a/Documentation/sound/soc/index.rst b/Documentation/sound/soc/index.rst
index 0c0c38e582b4..c5a55195bf4d 100644
--- a/Documentation/sound/soc/index.rst
+++ b/Documentation/sound/soc/index.rst
@@ -11,3 +11,4 @@ The documentation is spilt into the following sections:-
    codec
    dai
    dapm
+   platform
diff --git a/Documentation/sound/alsa/soc/platform.txt b/Documentation/sound/soc/platform.rst
similarity index 81%
rename from Documentation/sound/alsa/soc/platform.txt
rename to Documentation/sound/soc/platform.rst
index 3a08a2c9150c..d5574904d981 100644
--- a/Documentation/sound/alsa/soc/platform.txt
+++ b/Documentation/sound/soc/platform.rst
@@ -1,3 +1,4 @@
+====================
 ASoC Platform Driver
 ====================
 
@@ -9,21 +10,23 @@ Audio DMA
 =========
 
 The platform DMA driver optionally supports the following ALSA operations:-
+::
 
-/* SoC audio ops */
-struct snd_soc_ops {
+  /* SoC audio ops */
+  struct snd_soc_ops {
 	int (*startup)(struct snd_pcm_substream *);
 	void (*shutdown)(struct snd_pcm_substream *);
 	int (*hw_params)(struct snd_pcm_substream *, struct snd_pcm_hw_params *);
 	int (*hw_free)(struct snd_pcm_substream *);
 	int (*prepare)(struct snd_pcm_substream *);
 	int (*trigger)(struct snd_pcm_substream *, int);
-};
+  };
 
 The platform driver exports its DMA functionality via struct
 snd_soc_platform_driver:-
+::
 
-struct snd_soc_platform_driver {
+  struct snd_soc_platform_driver {
 	char *name;
 
 	int (*probe)(struct platform_device *pdev);
@@ -44,7 +47,7 @@ struct snd_soc_platform_driver {
 
 	/* platform stream ops */
 	struct snd_pcm_ops *pcm_ops;
-};
+  };
 
 Please refer to the ALSA driver documentation for details of audio DMA.
 http://www.alsa-project.org/~iwai/writing-an-alsa-driver/
@@ -57,11 +60,11 @@ SoC DAI Drivers
 
 Each SoC DAI driver must provide the following features:-
 
- 1) Digital audio interface (DAI) description
- 2) Digital audio interface configuration
- 3) PCM's description
- 4) SYSCLK configuration
- 5) Suspend and resume (optional)
+1. Digital audio interface (DAI) description
+2. Digital audio interface configuration
+3. PCM's description
+4. SYSCLK configuration
+5. Suspend and resume (optional)
 
 Please see codec.txt for a description of items 1 - 4.
 
@@ -71,9 +74,9 @@ SoC DSP Drivers
 
 Each SoC DSP driver usually supplies the following features :-
 
- 1) DAPM graph
- 2) Mixer controls
- 3) DMA IO to/from DSP buffers (if applicable)
- 4) Definition of DSP front end (FE) PCM devices.
+1. DAPM graph
+2. Mixer controls
+3. DMA IO to/from DSP buffers (if applicable)
+4. Definition of DSP front end (FE) PCM devices.
 
 Please see DPCM.txt for a description of item 4.
-- 
2.10.2
