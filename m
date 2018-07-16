From: Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH v6 01/10] Documentation: soundwire: Add
	documentation for multi link
Date: Tue, 17 Jul 2018 00:17:04 +0530
Message-ID: <20180716184713.13356-2-sanyog.r.kale@intel.com>
References: <20180716184713.13356-1-sanyog.r.kale@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by alsa0.perex.cz (Postfix) with ESMTP id 75D202676FE
 for <alsa-devel@alsa-project.org>; Mon, 16 Jul 2018 20:46:48 +0200 (CEST)
In-Reply-To: <20180716184713.13356-1-sanyog.r.kale@intel.com>
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
Cc: patches.audio@intel.com, gregkh@linuxfoundation.org, pierre-louis.bossart@linux.intel.com, vkoul@kernel.org, shreyas.nc@intel.com, sanyog.r.kale@intel.com
List-Id: alsa-devel@alsa-project.org

Add example and documentation to describe multi link streams

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
---
 Documentation/driver-api/soundwire/stream.rst | 28 +++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/driver-api/soundwire/stream.rst b/Documentation/driver-api/soundwire/stream.rst
index 29121aa55fb9..19482eedc3bf 100644
--- a/Documentation/driver-api/soundwire/stream.rst
+++ b/Documentation/driver-api/soundwire/stream.rst
@@ -101,6 +101,34 @@ interface. ::
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
2.13.0
