From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 15/30] ALSA: doc: ReSTize compress-offload
	document
Date: Thu, 10 Nov 2016 22:06:26 +0100
Message-ID: <20161110210641.5907-16-tiwai@suse.de>
References: <20161110210641.5907-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D4612673C3
 for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2016 22:06:55 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id C049AADEC
 for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2016 21:06:53 +0000 (UTC)
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

A simple conversion from a plain text file.
Put to designs subdirectory.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 .../compress-offload.rst}                          | 127 +++++++++++----------
 Documentation/sound/designs/index.rst              |   1 +
 2 files changed, 70 insertions(+), 58 deletions(-)
 rename Documentation/sound/{alsa/compress_offload.txt => designs/compress-offload.rst} (73%)

diff --git a/Documentation/sound/alsa/compress_offload.txt b/Documentation/sound/designs/compress-offload.rst
similarity index 73%
rename from Documentation/sound/alsa/compress_offload.txt
rename to Documentation/sound/designs/compress-offload.rst
index 8ba556a131c3..ad4bfbdacc83 100644
--- a/Documentation/sound/alsa/compress_offload.txt
+++ b/Documentation/sound/designs/compress-offload.rst
@@ -1,10 +1,14 @@
-		compress_offload.txt
-		=====================
-	Pierre-Louis.Bossart <pierre-louis.bossart@linux.intel.com>
-		Vinod Koul <vinod.koul@linux.intel.com>
+=========================
+ALSA Compress-Offload API
+=========================
+
+Pierre-Louis.Bossart <pierre-louis.bossart@linux.intel.com>
+
+Vinod Koul <vinod.koul@linux.intel.com>
 
-Overview
 
+Overview
+========
 Since its early days, the ALSA API was defined with PCM support or
 constant bitrates payloads such as IEC61937 in mind. Arguments and
 returned values in frames are the norm, making it a challenge to
@@ -27,8 +31,9 @@ Intel Moorestown SOC, with many corrections required to upstream the
 API in the mainline kernel instead of the staging tree and make it
 usable by others.
 
-Requirements
 
+Requirements
+============
 The main requirements are:
 
 - separation between byte counts and time. Compressed formats may have
@@ -63,7 +68,7 @@ The main requirements are:
   streaming compressed data to a DSP, with the assumption that the
   decoded samples are routed to a physical output or logical back-end.
 
- - Complexity hiding. Existing user-space multimedia frameworks all
+- Complexity hiding. Existing user-space multimedia frameworks all
   have existing enums/structures for each compressed format. This new
   API assumes the existence of a platform-specific compatibility layer
   to expose, translate and make use of the capabilities of the audio
@@ -72,7 +77,7 @@ The main requirements are:
 
 
 Design
-
+======
 The new API shares a number of concepts with the PCM API for flow
 control. Start, pause, resume, drain and stop commands have the same
 semantics no matter what the content is.
@@ -95,43 +100,44 @@ mandatory routines and possibly make use of optional ones.
 
 The main additions are
 
-- get_caps
-This routine returns the list of audio formats supported. Querying the
-codecs on a capture stream will return encoders, decoders will be
-listed for playback streams.
-
-- get_codec_caps For each codec, this routine returns a list of
-capabilities. The intent is to make sure all the capabilities
-correspond to valid settings, and to minimize the risks of
-configuration failures. For example, for a complex codec such as AAC,
-the number of channels supported may depend on a specific profile. If
-the capabilities were exposed with a single descriptor, it may happen
-that a specific combination of profiles/channels/formats may not be
-supported. Likewise, embedded DSPs have limited memory and cpu cycles,
-it is likely that some implementations make the list of capabilities
-dynamic and dependent on existing workloads. In addition to codec
-settings, this routine returns the minimum buffer size handled by the
-implementation. This information can be a function of the DMA buffer
-sizes, the number of bytes required to synchronize, etc, and can be
-used by userspace to define how much needs to be written in the ring
-buffer before playback can start.
-
-- set_params
-This routine sets the configuration chosen for a specific codec. The
-most important field in the parameters is the codec type; in most
-cases decoders will ignore other fields, while encoders will strictly
-comply to the settings
-
-- get_params
-This routines returns the actual settings used by the DSP. Changes to
-the settings should remain the exception.
-
-- get_timestamp
-The timestamp becomes a multiple field structure. It lists the number
-of bytes transferred, the number of samples processed and the number
-of samples rendered/grabbed. All these values can be used to determine
-the average bitrate, figure out if the ring buffer needs to be
-refilled or the delay due to decoding/encoding/io on the DSP.
+get_caps
+  This routine returns the list of audio formats supported. Querying the
+  codecs on a capture stream will return encoders, decoders will be
+  listed for playback streams.
+
+get_codec_caps
+  For each codec, this routine returns a list of
+  capabilities. The intent is to make sure all the capabilities
+  correspond to valid settings, and to minimize the risks of
+  configuration failures. For example, for a complex codec such as AAC,
+  the number of channels supported may depend on a specific profile. If
+  the capabilities were exposed with a single descriptor, it may happen
+  that a specific combination of profiles/channels/formats may not be
+  supported. Likewise, embedded DSPs have limited memory and cpu cycles,
+  it is likely that some implementations make the list of capabilities
+  dynamic and dependent on existing workloads. In addition to codec
+  settings, this routine returns the minimum buffer size handled by the
+  implementation. This information can be a function of the DMA buffer
+  sizes, the number of bytes required to synchronize, etc, and can be
+  used by userspace to define how much needs to be written in the ring
+  buffer before playback can start.
+
+set_params
+  This routine sets the configuration chosen for a specific codec. The
+  most important field in the parameters is the codec type; in most
+  cases decoders will ignore other fields, while encoders will strictly
+  comply to the settings
+
+get_params
+  This routines returns the actual settings used by the DSP. Changes to
+  the settings should remain the exception.
+
+get_timestamp
+  The timestamp becomes a multiple field structure. It lists the number
+  of bytes transferred, the number of samples processed and the number
+  of samples rendered/grabbed. All these values can be used to determine
+  the average bitrate, figure out if the ring buffer needs to be
+  refilled or the delay due to decoding/encoding/io on the DSP.
 
 Note that the list of codecs/profiles/modes was derived from the
 OpenMAX AL specification instead of reinventing the wheel.
@@ -145,6 +151,7 @@ Modifications include:
 - Addition of encoding options when required (derived from OpenMAX IL)
 - Addition of rateControlSupported (missing in OpenMAX AL)
 
+
 Gapless Playback
 ================
 When playing thru an album, the decoders have the ability to skip the encoder
@@ -162,19 +169,19 @@ switch from one track to another and start using data for second track.
 
 The main additions are:
 
-- set_metadata
-This routine sets the encoder delay and encoder padding. This can be used by
-decoder to strip the silence. This needs to be set before the data in the track
-is written.
+set_metadata
+  This routine sets the encoder delay and encoder padding. This can be used by
+  decoder to strip the silence. This needs to be set before the data in the track
+  is written.
 
-- set_next_track
-This routine tells DSP that metadata and write operation sent after this would
-correspond to subsequent track
+set_next_track
+  This routine tells DSP that metadata and write operation sent after this would
+  correspond to subsequent track
 
-- partial drain
-This is called when end of file is reached. The userspace can inform DSP that
-EOF is reached and now DSP can start skipping padding delay. Also next write
-data would belong to next track
+partial drain
+  This is called when end of file is reached. The userspace can inform DSP that
+  EOF is reached and now DSP can start skipping padding delay. Also next write
+  data would belong to next track
 
 Sequence flow for gapless would be:
 - Open
@@ -189,10 +196,12 @@ Sequence flow for gapless would be:
 - then call partial_drain to flush most of buffer in DSP
 - Fill data of the next track
 - DSP switches to second track
+
 (note: order for partial_drain and write for next track can be reversed as well)
 
-Not supported:
 
+Not supported
+=============
 - Support for VoIP/circuit-switched calls is not the target of this
   API. Support for dynamic bit-rate changes would require a tight
   coupling between the DSP and the host stack, limiting power savings.
@@ -225,7 +234,9 @@ Not supported:
   rendered output in time, this does not deal with underrun/overrun and
   maybe dealt in user-library
 
-Credits:
+
+Credits
+=======
 - Mark Brown and Liam Girdwood for discussions on the need for this API
 - Harsha Priya for her work on intel_sst compressed API
 - Rakesh Ughreja for valuable feedback
diff --git a/Documentation/sound/designs/index.rst b/Documentation/sound/designs/index.rst
index e53a5fac0acf..f7ca11307033 100644
--- a/Documentation/sound/designs/index.rst
+++ b/Documentation/sound/designs/index.rst
@@ -6,6 +6,7 @@ Designs and Implementations
 
    control-names
    channel-mapping-api
+   compress-offload
    procfile
    powersave
    oss-emulation
-- 
2.10.2
