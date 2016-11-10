From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 02/30] ALSA: doc: ReSTize alsa-driver-api
	document
Date: Thu, 10 Nov 2016 22:06:13 +0100
Message-ID: <20161110210641.5907-3-tiwai@suse.de>
References: <20161110210641.5907-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 388C62666EF
 for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2016 22:06:53 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 80838ADC4
 for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2016 21:06:52 +0000 (UTC)
In-Reply-To: <20161110210641.5907-1-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

A simple conversion of alsa-driver-api document from DocBook to ReST.

It's moved to the new Documentation/sound/kernel-api subdirectory that
will contain other ALSA kernel API documents.

The GPL legal note was removed, as it's superfluous (and doesn't fit
with ReST kernel docs pretty well).

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 Documentation/DocBook/Makefile                     |   2 +-
 Documentation/DocBook/alsa-driver-api.tmpl         | 142 ---------------------
 Documentation/index.rst                            |   1 +
 Documentation/sound/index.rst                      |  15 +++
 Documentation/sound/kernel-api/alsa-driver-api.rst | 134 +++++++++++++++++++
 Documentation/sound/kernel-api/index.rst           |   7 +
 6 files changed, 158 insertions(+), 143 deletions(-)
 delete mode 100644 Documentation/DocBook/alsa-driver-api.tmpl
 create mode 100644 Documentation/sound/index.rst
 create mode 100644 Documentation/sound/kernel-api/alsa-driver-api.rst
 create mode 100644 Documentation/sound/kernel-api/index.rst

diff --git a/Documentation/DocBook/Makefile b/Documentation/DocBook/Makefile
index fdf8232d0eeb..e173497959fa 100644
--- a/Documentation/DocBook/Makefile
+++ b/Documentation/DocBook/Makefile
@@ -13,7 +13,7 @@ DOCBOOKS := z8530book.xml  \
 	    gadget.xml libata.xml mtdnand.xml librs.xml rapidio.xml \
 	    genericirq.xml s390-drivers.xml uio-howto.xml scsi.xml \
 	    debugobjects.xml sh.xml regulator.xml \
-	    alsa-driver-api.xml writing-an-alsa-driver.xml \
+	    writing-an-alsa-driver.xml \
 	    tracepoint.xml w1.xml \
 	    writing_musb_glue_layer.xml crypto-API.xml iio.xml
 
diff --git a/Documentation/DocBook/alsa-driver-api.tmpl b/Documentation/DocBook/alsa-driver-api.tmpl
deleted file mode 100644
index 53f439dcc94b..000000000000
--- a/Documentation/DocBook/alsa-driver-api.tmpl
+++ /dev/null
@@ -1,142 +0,0 @@
-<?xml version="1.0" encoding="UTF-8"?>
-<!DOCTYPE book PUBLIC "-//OASIS//DTD DocBook XML V4.1.2//EN"
-	"http://www.oasis-open.org/docbook/xml/4.1.2/docbookx.dtd" []>
-
-<!-- ****************************************************** -->
-<!-- Header  -->
-<!-- ****************************************************** -->
-<book id="ALSA-Driver-API">
-  <bookinfo>
-    <title>The ALSA Driver API</title>
-
-    <legalnotice>
-    <para>
-    This document is free; you can redistribute it and/or modify it
-    under the terms of the GNU General Public License as published by
-    the Free Software Foundation; either version 2 of the License, or
-    (at your option) any later version. 
-    </para>
-
-    <para>
-    This document is distributed in the hope that it will be useful,
-    but <emphasis>WITHOUT ANY WARRANTY</emphasis>; without even the
-    implied warranty of <emphasis>MERCHANTABILITY or FITNESS FOR A
-    PARTICULAR PURPOSE</emphasis>. See the GNU General Public License
-    for more details.
-    </para>
-
-    <para>
-    You should have received a copy of the GNU General Public
-    License along with this program; if not, write to the Free
-    Software Foundation, Inc., 59 Temple Place, Suite 330, Boston,
-    MA 02111-1307 USA
-    </para>
-    </legalnotice>
-
-  </bookinfo>
-
-<toc></toc>
-
-  <chapter><title>Management of Cards and Devices</title>
-     <sect1><title>Card Management</title>
-!Esound/core/init.c
-     </sect1>
-     <sect1><title>Device Components</title>
-!Esound/core/device.c
-     </sect1>
-     <sect1><title>Module requests and Device File Entries</title>
-!Esound/core/sound.c
-     </sect1>
-     <sect1><title>Memory Management Helpers</title>
-!Esound/core/memory.c
-!Esound/core/memalloc.c
-     </sect1>
-  </chapter>
-  <chapter><title>PCM API</title>
-     <sect1><title>PCM Core</title>
-!Esound/core/pcm.c
-!Esound/core/pcm_lib.c
-!Esound/core/pcm_native.c
-!Iinclude/sound/pcm.h
-     </sect1>
-     <sect1><title>PCM Format Helpers</title>
-!Esound/core/pcm_misc.c
-     </sect1>
-     <sect1><title>PCM Memory Management</title>
-!Esound/core/pcm_memory.c
-     </sect1>
-     <sect1><title>PCM DMA Engine API</title>
-!Esound/core/pcm_dmaengine.c
-!Iinclude/sound/dmaengine_pcm.h
-     </sect1>
-  </chapter>
-  <chapter><title>Control/Mixer API</title>
-     <sect1><title>General Control Interface</title>
-!Esound/core/control.c
-     </sect1>
-     <sect1><title>AC97 Codec API</title>
-!Esound/pci/ac97/ac97_codec.c
-!Esound/pci/ac97/ac97_pcm.c
-     </sect1>
-     <sect1><title>Virtual Master Control API</title>
-!Esound/core/vmaster.c
-!Iinclude/sound/control.h
-     </sect1>
-  </chapter>
-  <chapter><title>MIDI API</title>
-     <sect1><title>Raw MIDI API</title>
-!Esound/core/rawmidi.c
-     </sect1>
-     <sect1><title>MPU401-UART API</title>
-!Esound/drivers/mpu401/mpu401_uart.c
-     </sect1>
-  </chapter>
-  <chapter><title>Proc Info API</title>
-     <sect1><title>Proc Info Interface</title>
-!Esound/core/info.c
-     </sect1>
-  </chapter>
-  <chapter><title>Compress Offload</title>
-     <sect1><title>Compress Offload API</title>
-!Esound/core/compress_offload.c
-!Iinclude/uapi/sound/compress_offload.h
-!Iinclude/uapi/sound/compress_params.h
-!Iinclude/sound/compress_driver.h
-     </sect1>
-  </chapter>
-  <chapter><title>ASoC</title>
-     <sect1><title>ASoC Core API</title>
-!Iinclude/sound/soc.h
-!Esound/soc/soc-core.c
-<!-- !Esound/soc/soc-cache.c no docbook comments here -->
-!Esound/soc/soc-devres.c
-!Esound/soc/soc-io.c
-!Esound/soc/soc-pcm.c
-!Esound/soc/soc-ops.c
-!Esound/soc/soc-compress.c
-     </sect1>
-     <sect1><title>ASoC DAPM API</title>
-!Esound/soc/soc-dapm.c
-     </sect1>
-     <sect1><title>ASoC DMA Engine API</title>
-!Esound/soc/soc-generic-dmaengine-pcm.c
-     </sect1>
-  </chapter>
-  <chapter><title>Miscellaneous Functions</title>
-     <sect1><title>Hardware-Dependent Devices API</title>
-!Esound/core/hwdep.c
-     </sect1>
-     <sect1><title>Jack Abstraction Layer API</title>
-!Iinclude/sound/jack.h
-!Esound/core/jack.c
-!Esound/soc/soc-jack.c
-     </sect1>
-     <sect1><title>ISA DMA Helpers</title>
-!Esound/core/isadma.c
-     </sect1>
-     <sect1><title>Other Helper Macros</title>
-!Iinclude/sound/core.h
-     </sect1>
-  </chapter>
-
-</book>
diff --git a/Documentation/index.rst b/Documentation/index.rst
index c53d089455a4..115c551da5f5 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -18,6 +18,7 @@ Contents:
    media/index
    gpu/index
    80211/index
+   sound/index
 
 Indices and tables
 ==================
diff --git a/Documentation/sound/index.rst b/Documentation/sound/index.rst
new file mode 100644
index 000000000000..280a57115f00
--- /dev/null
+++ b/Documentation/sound/index.rst
@@ -0,0 +1,15 @@
+===================================
+Linux Sound Subsystem Documentation
+===================================
+
+.. toctree::
+   :maxdepth: 2
+
+   kernel-api/index
+
+.. only::  subproject
+
+   Indices
+   =======
+
+   * :ref:`genindex`
diff --git a/Documentation/sound/kernel-api/alsa-driver-api.rst b/Documentation/sound/kernel-api/alsa-driver-api.rst
new file mode 100644
index 000000000000..14cd138989e3
--- /dev/null
+++ b/Documentation/sound/kernel-api/alsa-driver-api.rst
@@ -0,0 +1,134 @@
+===================
+The ALSA Driver API
+===================
+
+Management of Cards and Devices
+===============================
+
+Card Management
+---------------
+.. kernel-doc:: sound/core/init.c
+
+Device Components
+-----------------
+.. kernel-doc:: sound/core/device.c
+
+Module requests and Device File Entries
+---------------------------------------
+.. kernel-doc:: sound/core/sound.c
+
+Memory Management Helpers
+-------------------------
+.. kernel-doc:: sound/core/memory.c
+.. kernel-doc:: sound/core/memalloc.c
+
+
+PCM API
+=======
+
+PCM Core
+--------
+.. kernel-doc:: sound/core/pcm.c
+.. kernel-doc:: sound/core/pcm_lib.c
+.. kernel-doc:: sound/core/pcm_native.c
+.. kernel-doc:: include/sound/pcm.h
+
+PCM Format Helpers
+------------------
+.. kernel-doc:: sound/core/pcm_misc.c
+
+PCM Memory Management
+---------------------
+.. kernel-doc:: sound/core/pcm_memory.c
+
+PCM DMA Engine API
+------------------
+.. kernel-doc:: sound/core/pcm_dmaengine.c
+.. kernel-doc:: include/sound/dmaengine_pcm.h
+
+Control/Mixer API
+=================
+
+General Control Interface
+-------------------------
+.. kernel-doc:: sound/core/control.c
+
+AC97 Codec API
+--------------
+.. kernel-doc:: sound/pci/ac97/ac97_codec.c
+.. kernel-doc:: sound/pci/ac97/ac97_pcm.c
+
+Virtual Master Control API
+--------------------------
+.. kernel-doc:: sound/core/vmaster.c
+.. kernel-doc:: include/sound/control.h
+
+MIDI API
+========
+
+Raw MIDI API
+------------
+.. kernel-doc:: sound/core/rawmidi.c
+
+MPU401-UART API
+---------------
+.. kernel-doc:: sound/drivers/mpu401/mpu401_uart.c
+
+Proc Info API
+=============
+
+Proc Info Interface
+-------------------
+.. kernel-doc:: sound/core/info.c
+
+Compress Offload
+================
+
+Compress Offload API
+--------------------
+.. kernel-doc:: sound/core/compress_offload.c
+.. kernel-doc:: include/uapi/sound/compress_offload.h
+.. kernel-doc:: include/uapi/sound/compress_params.h
+.. kernel-doc:: include/sound/compress_driver.h
+
+ASoC
+====
+
+ASoC Core API
+-------------
+.. kernel-doc:: include/sound/soc.h
+.. kernel-doc:: sound/soc/soc-core.c
+.. kernel-doc:: sound/soc/soc-devres.c
+.. kernel-doc:: sound/soc/soc-io.c
+.. kernel-doc:: sound/soc/soc-pcm.c
+.. kernel-doc:: sound/soc/soc-ops.c
+.. kernel-doc:: sound/soc/soc-compress.c
+
+ASoC DAPM API
+-------------
+.. kernel-doc:: sound/soc/soc-dapm.c
+
+ASoC DMA Engine API
+-------------------
+.. kernel-doc:: sound/soc/soc-generic-dmaengine-pcm.c
+
+Miscellaneous Functions
+=======================
+
+Hardware-Dependent Devices API
+------------------------------
+.. kernel-doc:: sound/core/hwdep.c
+
+Jack Abstraction Layer API
+--------------------------
+.. kernel-doc:: include/sound/jack.h
+.. kernel-doc:: sound/core/jack.c
+.. kernel-doc:: sound/soc/soc-jack.c
+
+ISA DMA Helpers
+---------------
+.. kernel-doc:: sound/core/isadma.c
+
+Other Helper Macros
+-------------------
+.. kernel-doc:: include/sound/core.h
diff --git a/Documentation/sound/kernel-api/index.rst b/Documentation/sound/kernel-api/index.rst
new file mode 100644
index 000000000000..73c13497dec7
--- /dev/null
+++ b/Documentation/sound/kernel-api/index.rst
@@ -0,0 +1,7 @@
+ALSA Kernel API Documentation
+=============================
+
+.. toctree::
+   :maxdepth: 2
+
+   alsa-driver-api
-- 
2.10.2
