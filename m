From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 11/30] ALSA: doc: ReSTize Channel-Mapping-API
	document
Date: Thu, 10 Nov 2016 22:06:22 +0100
Message-ID: <20161110210641.5907-12-tiwai@suse.de>
References: <20161110210641.5907-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 6AB4F2673B7
 for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2016 22:06:55 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id B1F11ADE7
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

A simple conversion from a text file.
Put to designs subdirectory.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 .../channel-mapping-api.rst}                       | 77 ++++++++++++----------
 Documentation/sound/designs/index.rst              |  1 +
 2 files changed, 45 insertions(+), 33 deletions(-)
 rename Documentation/sound/{alsa/Channel-Mapping-API.txt => designs/channel-mapping-api.rst} (75%)

diff --git a/Documentation/sound/alsa/Channel-Mapping-API.txt b/Documentation/sound/designs/channel-mapping-api.rst
similarity index 75%
rename from Documentation/sound/alsa/Channel-Mapping-API.txt
rename to Documentation/sound/designs/channel-mapping-api.rst
index 3c43d1a4ca0e..58e6312a43c0 100644
--- a/Documentation/sound/alsa/Channel-Mapping-API.txt
+++ b/Documentation/sound/designs/channel-mapping-api.rst
@@ -1,9 +1,11 @@
+============================
 ALSA PCM channel-mapping API
 ============================
-					Takashi Iwai <tiwai@suse.de>
 
-GENERAL
--------
+Takashi Iwai <tiwai@suse.de>
+
+General
+=======
 
 The channel mapping API allows user to query the possible channel maps
 and the current channel map, also optionally to modify the channel map
@@ -11,9 +13,9 @@ of the current stream.
 
 A channel map is an array of position for each PCM channel.
 Typically, a stereo PCM stream has a channel map of
-  { front_left, front_right }
+``{ front_left, front_right }``
 while a 4.0 surround PCM stream has a channel map of
-  { front left, front right, rear left, rear right }.
+``{ front left, front right, rear left, rear right }.``
 
 The problem, so far, was that we had no standard channel map
 explicitly, and applications had no way to know which channel
@@ -29,8 +31,8 @@ specification.  These are the main motivations for the new channel
 mapping API.
 
 
-DESIGN
-------
+Design
+======
 
 Actually, "the channel mapping API" doesn't introduce anything new in
 the kernel/user-space ABI perspective.  It uses only the existing
@@ -39,10 +41,11 @@ control element features.
 As a ground design, each PCM substream may contain a control element
 providing the channel mapping information and configuration.  This
 element is specified by:
-	iface = SNDRV_CTL_ELEM_IFACE_PCM
-	name = "Playback Channel Map" or "Capture Channel Map"
-	device = the same device number for the assigned PCM substream
-	index = the same index number for the assigned PCM substream
+
+* iface = SNDRV_CTL_ELEM_IFACE_PCM
+* name = "Playback Channel Map" or "Capture Channel Map"
+* device = the same device number for the assigned PCM substream
+* index = the same index number for the assigned PCM substream
 
 Note the name is different depending on the PCM substream direction.
 
@@ -50,32 +53,35 @@ Each control element provides at least the TLV read operation and the
 read operation.  Optionally, the write operation can be provided to
 allow user to change the channel map dynamically.
 
-* TLV
+TLV
+---
 
 The TLV operation gives the list of available channel
 maps.  A list item of a channel map is usually a TLV of
-	type data-bytes ch0 ch1 ch2...
+``type data-bytes ch0 ch1 ch2...``
 where type is the TLV type value, the second argument is the total
 bytes (not the numbers) of channel values, and the rest are the
 position value for each channel.
 
-As a TLV type, either SNDRV_CTL_TLVT_CHMAP_FIXED,
-SNDRV_CTL_TLV_CHMAP_VAR or SNDRV_CTL_TLVT_CHMAP_PAIRED can be used.
-The _FIXED type is for a channel map with the fixed channel position
-while the latter two are for flexible channel positions.  _VAR type is
-for a channel map where all channels are freely swappable and _PAIRED
+As a TLV type, either ``SNDRV_CTL_TLVT_CHMAP_FIXED``,
+``SNDRV_CTL_TLV_CHMAP_VAR`` or ``SNDRV_CTL_TLVT_CHMAP_PAIRED`` can be used.
+The ``_FIXED`` type is for a channel map with the fixed channel position
+while the latter two are for flexible channel positions. ``_VAR`` type is
+for a channel map where all channels are freely swappable and ``_PAIRED``
 type is where pair-wise channels are swappable.  For example, when you
-have {FL/FR/RL/RR} channel map, _PAIRED type would allow you to swap
-only {RL/RR/FL/FR} while _VAR type would allow even swapping FL and
+have {FL/FR/RL/RR} channel map, ``_PAIRED`` type would allow you to swap
+only {RL/RR/FL/FR} while ``_VAR`` type would allow even swapping FL and
 RR.
 
-These new TLV types are defined in sound/tlv.h.
+These new TLV types are defined in ``sound/tlv.h``.
 
-The available channel position values are defined in sound/asound.h,
+The available channel position values are defined in ``sound/asound.h``,
 here is a cut:
 
-/* channel positions */
-enum {
+::
+
+  /* channel positions */
+  enum {
 	SNDRV_CHMAP_UNKNOWN = 0,
 	SNDRV_CHMAP_NA,		/* N/A, silent */
 	SNDRV_CHMAP_MONO,	/* mono stream */
@@ -107,11 +113,13 @@ enum {
 	SNDRV_CHMAP_TRR,	/* top rear right */
 	SNDRV_CHMAP_TRC,	/* top rear center */
 	SNDRV_CHMAP_LAST = SNDRV_CHMAP_TRC,
-};
+  };
 
 When a PCM stream can provide more than one channel map, you can
 provide multiple channel maps in a TLV container type.  The TLV data
 to be returned will contain such as:
+::
+
 	SNDRV_CTL_TLVT_CONTAINER 96
 	    SNDRV_CTL_TLVT_CHMAP_FIXED 4 SNDRV_CHMAP_FC
 	    SNDRV_CTL_TLVT_CHMAP_FIXED 8 SNDRV_CHMAP_FL SNDRV_CHMAP_FR
@@ -120,19 +128,21 @@ to be returned will contain such as:
 
 The channel position is provided in LSB 16bits.  The upper bits are
 used for bit flags.
+::
 
-#define SNDRV_CHMAP_POSITION_MASK	0xffff
-#define SNDRV_CHMAP_PHASE_INVERSE	(0x01 << 16)
-#define SNDRV_CHMAP_DRIVER_SPEC		(0x02 << 16)
+	#define SNDRV_CHMAP_POSITION_MASK	0xffff
+	#define SNDRV_CHMAP_PHASE_INVERSE	(0x01 << 16)
+	#define SNDRV_CHMAP_DRIVER_SPEC		(0x02 << 16)
 
-SNDRV_CHMAP_PHASE_INVERSE indicates the channel is phase inverted,
+``SNDRV_CHMAP_PHASE_INVERSE`` indicates the channel is phase inverted,
 (thus summing left and right channels would result in almost silence).
 Some digital mic devices have this.
 
-When SNDRV_CHMAP_DRIVER_SPEC is set, all the channel position values
+When ``SNDRV_CHMAP_DRIVER_SPEC`` is set, all the channel position values
 don't follow the standard definition above but driver-specific.
 
-* READ OPERATION
+Read Operation
+--------------
 
 The control read operation is for providing the current channel map of
 the given stream.  The control element returns an integer array
@@ -140,9 +150,10 @@ containing the position of each channel.
 
 When this is performed before the number of the channel is specified
 (i.e. hw_params is set), it should return all channels set to
-UNKNOWN.
+``UNKNOWN``.
 
-* WRITE OPERATION
+Write Operation
+---------------
 
 The control write operation is optional, and only for devices that can
 change the channel configuration on the fly, such as HDMI.  User needs
diff --git a/Documentation/sound/designs/index.rst b/Documentation/sound/designs/index.rst
index 362e1c23d51f..dd4fcbcb2b92 100644
--- a/Documentation/sound/designs/index.rst
+++ b/Documentation/sound/designs/index.rst
@@ -4,5 +4,6 @@ Designs and Implementations
 .. toctree::
    :maxdepth: 2
 
+   channel-mapping-api
    procfile
    powersave
-- 
2.10.2
