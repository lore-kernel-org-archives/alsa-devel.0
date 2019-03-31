From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH] Documentation: soundwire: Ensure that code is inside the code blocks
Date: Mon,  1 Apr 2019 00:34:22 +0200
Message-ID: <20190331223423.29855-1-j.neuschaefer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-doc@vger.kernel.org
Cc: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, Vinod Koul <vkoul@kernel.org>, Sanyog Kale <sanyog.r.kale@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The way the document is written now, Sphinx renders empty code blocks
followed by the lines that should be inside them.

Unindent the code-block directives to fix this.

Fixes: 502c00d9c315 ("Documentation: soundwire: fix stream.rst markup warn=
ings")
Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 Documentation/driver-api/soundwire/stream.rst | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/driver-api/soundwire/stream.rst b/Documentation=
/driver-api/soundwire/stream.rst
index 26a6064503fd..5351bd2f34a8 100644
=2D-- a/Documentation/driver-api/soundwire/stream.rst
+++ b/Documentation/driver-api/soundwire/stream.rst
@@ -201,7 +201,7 @@ Bus implements below API for allocate a stream which n=
eeds to be called once
 per stream. From ASoC DPCM framework, this stream state maybe linked to
 .startup() operation.

-  .. code-block:: c
+.. code-block:: c

   int sdw_alloc_stream(char * stream_name);

@@ -228,7 +228,7 @@ the respective Master(s) and Slave(s) associated with =
stream. These APIs can
 only be invoked once by respective Master(s) and Slave(s). From ASoC DPCM
 framework, this stream state is linked to .hw_params() operation.

-  .. code-block:: c
+.. code-block:: c

   int sdw_stream_add_master(struct sdw_bus * bus,
 		struct sdw_stream_config * stream_config,
@@ -274,7 +274,7 @@ Bus implements below API for PREPARE state which needs=
 to be called once per
 stream. From ASoC DPCM framework, this stream state is linked to
 .prepare() operation.

-  .. code-block:: c
+.. code-block:: c

   int sdw_prepare_stream(struct sdw_stream_runtime * stream);

@@ -304,7 +304,7 @@ Bus implements below API for ENABLE state which needs =
to be called once per
 stream. From ASoC DPCM framework, this stream state is linked to
 .trigger() start operation.

-  .. code-block:: c
+.. code-block:: c

   int sdw_enable_stream(struct sdw_stream_runtime * stream);

@@ -332,7 +332,7 @@ Bus implements below API for DISABLED state which need=
s to be called once
 per stream. From ASoC DPCM framework, this stream state is linked to
 .trigger() stop operation.

-  .. code-block:: c
+.. code-block:: c

   int sdw_disable_stream(struct sdw_stream_runtime * stream);

@@ -357,7 +357,7 @@ Bus implements below API for DEPREPARED state which ne=
eds to be called once
 per stream. From ASoC DPCM framework, this stream state is linked to
 .trigger() stop operation.

-  .. code-block:: c
+.. code-block:: c

   int sdw_deprepare_stream(struct sdw_stream_runtime * stream);

@@ -382,7 +382,7 @@ Bus implements below APIs for RELEASE state which need=
s to be called by
 all the Master(s) and Slave(s) associated with stream. From ASoC DPCM
 framework, this stream state is linked to .hw_free() operation.

-  .. code-block:: c
+.. code-block:: c

   int sdw_stream_remove_master(struct sdw_bus * bus,
 		struct sdw_stream_runtime * stream);
@@ -395,7 +395,7 @@ stream assigned as part of ALLOCATED state.

 In .shutdown() the data structure maintaining stream state are freed up.

-  .. code-block:: c
+.. code-block:: c

   void sdw_release_stream(struct sdw_stream_runtime * stream);

=2D-
2.20.1
