From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] Documentation: soundwire: fix stream.rst markup warnings
Date: Sun, 16 Sep 2018 17:34:49 -0700
Message-ID: <8e1ec734-06b8-ba8a-fdca-3221ac134ea0@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: moderated for non-subscribers <alsa-devel@alsa-project.org>, LKML <linux-kernel@vger.kernel.org>
Cc: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, Shreyas NC <shreyas.nc@intel.com>, Vinod Koul <vkoul@kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix kernel-doc markup warnings in soundwire/stream.rst:

rc4/Documentation/driver-api/soundwire/stream.rst:177: WARNING: Explicit markup ends without a blank line; unexpected unindent.
rc4/Documentation/driver-api/soundwire/stream.rst:203: WARNING: Explicit markup ends without a blank line; unexpected unindent.
rc4/Documentation/driver-api/soundwire/stream.rst:248: WARNING: Explicit markup ends without a blank line; unexpected unindent.
rc4/Documentation/driver-api/soundwire/stream.rst:277: WARNING: Explicit markup ends without a blank line; unexpected unindent.
rc4/Documentation/driver-api/soundwire/stream.rst:304: WARNING: Explicit markup ends without a blank line; unexpected unindent.
rc4/Documentation/driver-api/soundwire/stream.rst:328: WARNING: Explicit markup ends without a blank line; unexpected unindent.
rc4/Documentation/driver-api/soundwire/stream.rst:352: WARNING: Explicit markup ends without a blank line; unexpected unindent.
rc4/Documentation/driver-api/soundwire/stream.rst:364: WARNING: Explicit markup ends without a blank line; unexpected unindent.

Fixes: 89634f99a83e ("Documentation: soundwire: Add more documentation")

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Sanyog Kale <sanyog.r.kale@intel.com>
Cc: Shreyas NC <shreyas.nc@intel.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: alsa-devel@alsa-project.org
Cc: linux-doc@vger.kernel.org
---
 Documentation/driver-api/soundwire/stream.rst |    8 ++++++++
 1 file changed, 8 insertions(+)

--- lnx-419-rc4.orig/Documentation/driver-api/soundwire/stream.rst
+++ lnx-419-rc4/Documentation/driver-api/soundwire/stream.rst
@@ -174,6 +174,7 @@ per stream. From ASoC DPCM framework, th
 .startup() operation.
 
   .. code-block:: c
+
   int sdw_alloc_stream(char * stream_name);
 
 
@@ -200,6 +201,7 @@ only be invoked once by respective Maste
 framework, this stream state is linked to .hw_params() operation.
 
   .. code-block:: c
+
   int sdw_stream_add_master(struct sdw_bus * bus,
 		struct sdw_stream_config * stream_config,
 		struct sdw_ports_config * ports_config,
@@ -245,6 +247,7 @@ stream. From ASoC DPCM framework, this s
 .prepare() operation.
 
   .. code-block:: c
+
   int sdw_prepare_stream(struct sdw_stream_runtime * stream);
 
 
@@ -274,6 +277,7 @@ stream. From ASoC DPCM framework, this s
 .trigger() start operation.
 
   .. code-block:: c
+
   int sdw_enable_stream(struct sdw_stream_runtime * stream);
 
 SDW_STREAM_DISABLED
@@ -301,6 +305,7 @@ per stream. From ASoC DPCM framework, th
 .trigger() stop operation.
 
   .. code-block:: c
+
   int sdw_disable_stream(struct sdw_stream_runtime * stream);
 
 
@@ -325,6 +330,7 @@ per stream. From ASoC DPCM framework, th
 .trigger() stop operation.
 
   .. code-block:: c
+
   int sdw_deprepare_stream(struct sdw_stream_runtime * stream);
 
 
@@ -349,6 +355,7 @@ all the Master(s) and Slave(s) associate
 framework, this stream state is linked to .hw_free() operation.
 
   .. code-block:: c
+
   int sdw_stream_remove_master(struct sdw_bus * bus,
 		struct sdw_stream_runtime * stream);
   int sdw_stream_remove_slave(struct sdw_slave * slave,
@@ -361,6 +368,7 @@ stream assigned as part of ALLOCATED sta
 In .shutdown() the data structure maintaining stream state are freed up.
 
   .. code-block:: c
+
   void sdw_release_stream(struct sdw_stream_runtime * stream);
 
 Not Supported
