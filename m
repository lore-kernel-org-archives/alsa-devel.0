From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH v2 19/26] docs: index.rst: don't use genindex for pdf output
Date: Fri, 26 Jul 2019 09:51:29 -0300
Message-ID: <e4636397bcce1cce6280120081c249e9b407aabe.1564145354.git.mchehab+samsung@kernel.org>
References: <cover.1564145354.git.mchehab+samsung@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <cover.1564145354.git.mchehab+samsung@kernel.org>
Sender: netdev-owner@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Vinod Koul <vkoul@kernel.org>, Sanyog Kale <sanyog.r.kale@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, "David S. Miller" <davem@davemloft.net>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-doc@vger.kernel.org, dmaengine@vger.kernel.org, alsa-devel@alsa-project.org, netdev@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The genindex logic is meant to be used only for html output, as
pdf build has its own way to generate indexes.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Acked-by: Vinod Koul <vkoul@kernel.org> # dmaengine and soundwire
---
 Documentation/core-api/index.rst                  | 2 +-
 Documentation/driver-api/dmaengine/index.rst      | 2 +-
 Documentation/driver-api/soundwire/index.rst      | 2 +-
 Documentation/networking/device_drivers/index.rst | 2 +-
 Documentation/networking/index.rst                | 2 +-
 Documentation/sound/index.rst                     | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
index dfd8fad1e1ec..fa16a0538dcb 100644
--- a/Documentation/core-api/index.rst
+++ b/Documentation/core-api/index.rst
@@ -49,7 +49,7 @@ Interfaces for kernel debugging
    debug-objects
    tracepoint
 
-.. only::  subproject
+.. only:: subproject and html
 
    Indices
    =======
diff --git a/Documentation/driver-api/dmaengine/index.rst b/Documentation/driver-api/dmaengine/index.rst
index 3026fa975937..b9df904d0a79 100644
--- a/Documentation/driver-api/dmaengine/index.rst
+++ b/Documentation/driver-api/dmaengine/index.rst
@@ -47,7 +47,7 @@ This book adds some notes about PXA DMA
 
    pxa_dma
 
-.. only::  subproject
+.. only::  subproject and html
 
    Indices
    =======
diff --git a/Documentation/driver-api/soundwire/index.rst b/Documentation/driver-api/soundwire/index.rst
index 6db026028f27..234911a0db99 100644
--- a/Documentation/driver-api/soundwire/index.rst
+++ b/Documentation/driver-api/soundwire/index.rst
@@ -10,7 +10,7 @@ SoundWire Documentation
    error_handling
    locking
 
-.. only::  subproject
+.. only::  subproject and html
 
    Indices
    =======
diff --git a/Documentation/networking/device_drivers/index.rst b/Documentation/networking/device_drivers/index.rst
index 2b7fefe72351..f724b7c69b9e 100644
--- a/Documentation/networking/device_drivers/index.rst
+++ b/Documentation/networking/device_drivers/index.rst
@@ -24,7 +24,7 @@ Contents:
    google/gve
    mellanox/mlx5
 
-.. only::  subproject
+.. only::  subproject and html
 
    Indices
    =======
diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index a46fca264bee..6739066acadb 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -31,7 +31,7 @@ Contents:
    tls
    tls-offload
 
-.. only::  subproject
+.. only::  subproject and html
 
    Indices
    =======
diff --git a/Documentation/sound/index.rst b/Documentation/sound/index.rst
index 47b89f014e69..4d7d42acf6df 100644
--- a/Documentation/sound/index.rst
+++ b/Documentation/sound/index.rst
@@ -12,7 +12,7 @@ Linux Sound Subsystem Documentation
    hd-audio/index
    cards/index
 
-.. only::  subproject
+.. only::  subproject and html
 
    Indices
    =======
-- 
2.21.0
