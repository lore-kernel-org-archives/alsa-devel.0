From: Shreyas NC <shreyas.nc@intel.com>
Subject: [PATCH v3 1/6] Documentation: soundwire: Add
	documentation for multi link
Date: Thu, 14 Jun 2018 17:01:58 +0530
Message-ID: <1528975923-15141-2-git-send-email-shreyas.nc@intel.com>
References: <1528975923-15141-1-git-send-email-shreyas.nc@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 7217E2675FC
 for <alsa-devel@alsa-project.org>; Thu, 14 Jun 2018 13:34:10 +0200 (CEST)
In-Reply-To: <1528975923-15141-1-git-send-email-shreyas.nc@intel.com>
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
Cc: patches.audio@intel.com, gregkh@linuxfoundation.org, pierre-louis.bossart@linux.intel.com, vkoul@kernel.org, Shreyas NC <shreyas.nc@intel.com>, sanyog.r.kale@intel.com
List-Id: alsa-devel@alsa-project.org

From: Sanyog Kale <sanyog.r.kale@intel.com>

Add example and documentation to describe multi link streams

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
---
 Documentation/driver-api/soundwire/stream.rst | 29 ++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/Documentation/driver-api/soundwire/stream.rst b/Documentation/driver-api/soundwire/stream.rst
index 29121aa..11623aab 100644
--- a/Documentation/driver-api/soundwire/stream.rst
+++ b/Documentation/driver-api/soundwire/stream.rst
@@ -75,7 +75,6 @@ Slaves are using single port. ::
 	                                                   |     (Data)    |
 	                                                   +---------------+
 
-
 Example 4: Stereo Stream with L and R channel is rendered by two different
 Ports of the Master and is received by only single Port of the Slave
 interface. ::
@@ -101,6 +100,34 @@ interface. ::
 	+--------------------+                             |                |
 							   +----------------+
 
+Example 5: Stereo Stream with L and R channel is rendered by 2 Masters, each
+rendering one channel, and is received by two different Slaves, each
+receiving one channel. Both Masters and both Slaves are using single port. ::
+
+	+---------------+                    Clock Signal  +---------------+
+	|    Master     +----------------------------------+     Slave     |
+	|   Interface   |                                  |   Interface   |
+	|       1       |                                  |       1       |
+	|               |                     Data Signal  |               |
+	|       L       +----------------------------------+       L       |
+	|     (Data)    |     Data Direction               |     (Data)    |
+	+---------------+  +----------------------->       +---------------+
+
+	+---------------+                    Clock Signal  +---------------+
+	|    Master     +----------------------------------+     Slave     |
+	|   Interface   |                                  |   Interface   |
+	|       2       |                                  |       2       |
+	|               |                     Data Signal  |               |
+	|       R       +----------------------------------+       R       |
+	|     (Data)    |     Data Direction               |     (Data)    |
+	+---------------+  +----------------------->       +---------------+
+
+Note: In multi-link cases like above, to lock, one would acquire a global
+lock and then go on locking bus instances. But, in this case the caller
+framework(ASoC DPCM) guarantees that stream operations on a card are
+always serialized. So, there is no race condition and hence no need for
+global lock.
+
 SoundWire Stream Management flow
 ================================
 
-- 
2.7.4
