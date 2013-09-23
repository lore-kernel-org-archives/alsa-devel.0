From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH 2/5] ASoC: Docs: Platform update
Date: Mon, 23 Sep 2013 12:13:59 +0100
Message-ID: <1379934842-4489-2-git-send-email-liam.r.girdwood@linux.intel.com>
References: <1379934842-4489-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 3EFEF260865
 for <alsa-devel@alsa-project.org>; Mon, 23 Sep 2013 13:14:22 +0200 (CEST)
In-Reply-To: <1379934842-4489-1-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Update the platform class driver documentation and bring it up to date
with the current code base. This includes multi component and DSP.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 Documentation/sound/alsa/soc/platform.txt | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/Documentation/sound/alsa/soc/platform.txt b/Documentation/sound/alsa/soc/platform.txt
index d57efad..3a08a2c 100644
--- a/Documentation/sound/alsa/soc/platform.txt
+++ b/Documentation/sound/alsa/soc/platform.txt
@@ -1,9 +1,9 @@
 ASoC Platform Driver
 ====================
 
-An ASoC platform driver can be divided into audio DMA and SoC DAI configuration
-and control. The platform drivers only target the SoC CPU and must have no board
-specific code.
+An ASoC platform driver class can be divided into audio DMA drivers, SoC DAI
+drivers and DSP drivers. The platform drivers only target the SoC CPU and must
+have no board specific code.
 
 Audio DMA
 =========
@@ -64,3 +64,16 @@ Each SoC DAI driver must provide the following features:-
  5) Suspend and resume (optional)
 
 Please see codec.txt for a description of items 1 - 4.
+
+
+SoC DSP Drivers
+===============
+
+Each SoC DSP driver usually supplies the following features :-
+
+ 1) DAPM graph
+ 2) Mixer controls
+ 3) DMA IO to/from DSP buffers (if applicable)
+ 4) Definition of DSP front end (FE) PCM devices.
+
+Please see DPCM.txt for a description of item 4.
-- 
1.8.1.2
