From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 01/10] ASoC: doc: ReSTize overview.txt
Date: Thu, 10 Nov 2016 22:47:13 +0100
Message-ID: <20161110214722.14698-2-tiwai@suse.de>
References: <20161110214722.14698-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id CD4782673BA
 for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2016 22:47:26 +0100 (CET)
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
Created a new subdirectory, Documentation/sound/soc, for this and
other ASoC documents.

Since the index page contains the TOC, so "Documentation" section got
removed from overview.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 Documentation/sound/index.rst                      |  1 +
 Documentation/sound/soc/index.rst                  | 10 +++++++
 .../{alsa/soc/overview.txt => soc/overview.rst}    | 32 ++--------------------
 3 files changed, 14 insertions(+), 29 deletions(-)
 create mode 100644 Documentation/sound/soc/index.rst
 rename Documentation/sound/{alsa/soc/overview.txt => soc/overview.rst} (83%)

diff --git a/Documentation/sound/index.rst b/Documentation/sound/index.rst
index 1f5d166f81c4..47b89f014e69 100644
--- a/Documentation/sound/index.rst
+++ b/Documentation/sound/index.rst
@@ -7,6 +7,7 @@ Linux Sound Subsystem Documentation
 
    kernel-api/index
    designs/index
+   soc/index
    alsa-configuration
    hd-audio/index
    cards/index
diff --git a/Documentation/sound/soc/index.rst b/Documentation/sound/soc/index.rst
new file mode 100644
index 000000000000..e974fd9f38a3
--- /dev/null
+++ b/Documentation/sound/soc/index.rst
@@ -0,0 +1,10 @@
+==============
+ALSA SoC Layer
+==============
+
+The documentation is spilt into the following sections:-
+
+.. toctree::
+   :maxdepth: 2
+
+   overview
diff --git a/Documentation/sound/alsa/soc/overview.txt b/Documentation/sound/soc/overview.rst
similarity index 83%
rename from Documentation/sound/alsa/soc/overview.txt
rename to Documentation/sound/soc/overview.rst
index f3f28b7ae242..dc8370bbfff6 100644
--- a/Documentation/sound/alsa/soc/overview.txt
+++ b/Documentation/sound/soc/overview.rst
@@ -1,5 +1,6 @@
-ALSA SoC Layer
-==============
+=======================
+ALSA SoC Layer Overview
+=======================
 
 The overall project goal of the ALSA System on Chip (ASoC) layer is to
 provide better ALSA support for embedded system-on-chip processors (e.g.
@@ -66,30 +67,3 @@ multiple re-usable component drivers :-
     describes and binds the other component drivers together to form an ALSA
     "sound card device". It handles any machine specific controls and
     machine level audio events (e.g. turning on an amp at start of playback).
-
-
-Documentation
-=============
-
-The documentation is spilt into the following sections:-
-
-overview.txt: This file.
-
-codec.txt: Codec driver internals.
-
-DAI.txt: Description of Digital Audio Interface standards and how to configure
-a DAI within your codec and CPU DAI drivers.
-
-dapm.txt: Dynamic Audio Power Management
-
-platform.txt: Platform audio DMA and DAI.
-
-machine.txt: Machine driver internals.
-
-pop_clicks.txt: How to minimise audio artifacts.
-
-clocking.txt: ASoC clocking for best power performance.
-
-jack.txt: ASoC jack detection.
-
-DPCM.txt: Dynamic PCM - Describes DPCM with DSP examples.
-- 
2.10.2
