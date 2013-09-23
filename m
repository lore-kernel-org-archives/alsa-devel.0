From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH 4/5] ASoC: Docs: Machine update
Date: Mon, 23 Sep 2013 12:14:01 +0100
Message-ID: <1379934842-4489-4-git-send-email-liam.r.girdwood@linux.intel.com>
References: <1379934842-4489-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A617260896
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

Update the machine driver documentation and bring it up to date
with the current code base. This includes multi component.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 Documentation/sound/alsa/soc/machine.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/sound/alsa/soc/machine.txt b/Documentation/sound/alsa/soc/machine.txt
index d50c14d..74056db 100644
--- a/Documentation/sound/alsa/soc/machine.txt
+++ b/Documentation/sound/alsa/soc/machine.txt
@@ -1,8 +1,10 @@
 ASoC Machine Driver
 ===================
 
-The ASoC machine (or board) driver is the code that glues together the platform
-and codec drivers.
+The ASoC machine (or board) driver is the code that glues together all the
+component drivers (e.g. codecs, platforms and DAIs). It also describes the
+relationships between each componnent which include audio paths, GPIOs,
+interrupts, clocking, jacks and voltage regulators.
 
 The machine driver can contain codec and platform specific code. It registers
 the audio subsystem with the kernel as a platform device and is represented by
-- 
1.8.1.2
