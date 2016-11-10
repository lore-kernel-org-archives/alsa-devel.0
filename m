From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 08/10] ASoC: doc: ReSTize clocking.txt
Date: Thu, 10 Nov 2016 22:47:20 +0100
Message-ID: <20161110214722.14698-9-tiwai@suse.de>
References: <20161110214722.14698-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 133DD2673D5
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
 .../sound/{alsa/soc/clocking.txt => soc/clocking.rst}       | 13 ++++---------
 Documentation/sound/soc/index.rst                           |  1 +
 2 files changed, 5 insertions(+), 9 deletions(-)
 rename Documentation/sound/{alsa/soc/clocking.txt => soc/clocking.rst} (94%)

diff --git a/Documentation/sound/alsa/soc/clocking.txt b/Documentation/sound/soc/clocking.rst
similarity index 94%
rename from Documentation/sound/alsa/soc/clocking.txt
rename to Documentation/sound/soc/clocking.rst
index b1300162e01c..32122d6877a3 100644
--- a/Documentation/sound/alsa/soc/clocking.txt
+++ b/Documentation/sound/soc/clocking.rst
@@ -1,3 +1,4 @@
+==============
 Audio Clocking
 ==============
 
@@ -30,15 +31,9 @@ runs at exactly the sample rate (LRC = Rate).
 
 Bit Clock can be generated as follows:-
 
-BCLK = MCLK / x
-
- or
-
-BCLK = LRC * x
-
- or
-
-BCLK = LRC * Channels * Word Size
+- BCLK = MCLK / x, or
+- BCLK = LRC * x, or
+- BCLK = LRC * Channels * Word Size
 
 This relationship depends on the codec or SoC CPU in particular. In general
 it is best to configure BCLK to the lowest possible speed (depending on your
diff --git a/Documentation/sound/soc/index.rst b/Documentation/sound/soc/index.rst
index 4dd679927a91..0055abe16e7e 100644
--- a/Documentation/sound/soc/index.rst
+++ b/Documentation/sound/soc/index.rst
@@ -14,3 +14,4 @@ The documentation is spilt into the following sections:-
    platform
    machine
    pops-clicks
+   clocking
-- 
2.10.2
