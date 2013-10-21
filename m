From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] [10/29] ALSA: dice: reorganize interface definitions
Date: Mon, 21 Oct 2013 21:26:21 +0200
Message-ID: <52657FDD.7050509@ladisch.de>
References: <52657E3B.7040205@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <52657E3B.7040205@ladisch.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Move the DICE interface symbols into a separate header file, and add
more documentation.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 sound/firewire/dice-interface.h |  371 +++++++++++++++++++++++++++++++++++++++
 sound/firewire/dice.c           |  209 ----------------------
 2 files changed, 373 insertions(+), 207 deletions(-)
 create mode 100644 sound/firewire/dice-interface.h

diff --git a/sound/firewire/dice-interface.h b/sound/firewire/dice-interface.h
new file mode 100644
index 0000000..af916b9
--- /dev/null
+++ b/sound/firewire/dice-interface.h
@@ -0,0 +1,371 @@
+#ifndef SOUND_FIREWIRE_DICE_INTERFACE_H_INCLUDED
+#define SOUND_FIREWIRE_DICE_INTERFACE_H_INCLUDED
+
+/*
+ * DICE device interface definitions
+ */
+
+/*
+ * Generally, all registers can be read like memory, i.e., with quadlet read or
+ * block read transactions with any alignment or length.  Writes are not
+ * allowed except where noted; quadlet-sized registers must be written with
+ * a quadlet write transaction.
+ *
+ * All values are in big endian.  The DICE firmware runs on a little-endian CPU
+ * and just byte-swaps _all_ quadlets on the bus, so values without endianness
+ * (e.g. strings) get scrambled and must be byte-swapped again by the driver.
+ */
+
+/*
+ * Streaming is handled by the "DICE driver" interface.  Its registers are
+ * located in this private address space.
+ */
+#define DICE_PRIVATE_SPACE		0xffffe0000000uLL
+
+/*
+ * The registers are organized in several sections, which are organized
+ * separately to allow them to be extended individually.  Whether a register is
+ * supported can be detected by checking its offset against its section's size.
+ *
+ * The section offset values are relative to DICE_PRIVATE_SPACE; the offset/
+ * size values are measured in quadlets.  Read-only.
+ */
+#define DICE_GLOBAL_OFFSET		0x00
+#define DICE_GLOBAL_SIZE		0x04
+#define DICE_TX_OFFSET			0x08
+#define DICE_TX_SIZE			0x0c
+#define DICE_RX_OFFSET			0x10
+#define DICE_RX_SIZE			0x14
+#define DICE_EXT_SYNC_OFFSET		0x18
+#define DICE_EXT_SYNC_SIZE		0x1c
+#define DICE_UNUSED2_OFFSET		0x20
+#define DICE_UNUSED2_SIZE		0x24
+
+/*
+ * Global settings.
+ */
+
+/*
+ * Stores the full 64-bit address (node ID and offset in the node's address
+ * space) where the device will send notifications.  Must be changed with
+ * a compare/swap transaction by the owner.  This register is automatically
+ * cleared on a bus reset.
+ */
+#define GLOBAL_OWNER			0x000
+#define  OWNER_NO_OWNER			0xffff000000000000uLL
+#define  OWNER_NODE_SHIFT		48
+
+/*
+ * A bitmask with asynchronous events; read-only.  When any event(s) happen,
+ * the bits of previous events are cleared, and the value of this register is
+ * also written to the address stored in the owner register.
+ */
+#define GLOBAL_NOTIFICATION		0x008
+/* Some registers in the Rx/Tx sections may have changed. */
+#define  NOTIFY_RX_CFG_CHG		0x00000001
+#define  NOTIFY_TX_CFG_CHG		0x00000002
+/* Lock status of the current clock source may have changed. */
+#define  NOTIFY_LOCK_CHG		0x00000010
+/* Write to the clock select register has been finished. */
+#define  NOTIFY_CLOCK_ACCEPTED		0x00000020
+/* Lock status of some clock source has changed. */
+#define  NOTIFY_EXT_STATUS		0x00000040
+/* Other bits may be used for device-specific events. */
+
+/*
+ * A name that can be customized for each device; read/write.  Padded with zero
+ * bytes.  Quadlets are byte-swapped.  The encoding is whatever the host driver
+ * happens to be using.
+ */
+#define GLOBAL_NICK_NAME		0x00c
+#define  NICK_NAME_SIZE			64
+
+/*
+ * The current sample rate and clock source; read/write.  Whether a clock
+ * source or sample rate is supported is device-specific; the internal clock
+ * source is always available.  Low/mid/high = up to 48/96/192 kHz.  This
+ * register can be changed even while streams are running.
+ */
+#define GLOBAL_CLOCK_SELECT		0x04c
+#define  CLOCK_SOURCE_MASK		0x000000ff
+#define  CLOCK_SOURCE_AES1		0x00000000
+#define  CLOCK_SOURCE_AES2		0x00000001
+#define  CLOCK_SOURCE_AES3		0x00000002
+#define  CLOCK_SOURCE_AES4		0x00000003
+#define  CLOCK_SOURCE_AES_ANY		0x00000004
+#define  CLOCK_SOURCE_ADAT		0x00000005
+#define  CLOCK_SOURCE_TDIF		0x00000006
+#define  CLOCK_SOURCE_WC		0x00000007
+#define  CLOCK_SOURCE_ARX1		0x00000008
+#define  CLOCK_SOURCE_ARX2		0x00000009
+#define  CLOCK_SOURCE_ARX3		0x0000000a
+#define  CLOCK_SOURCE_ARX4		0x0000000b
+#define  CLOCK_SOURCE_INTERNAL		0x0000000c
+#define  CLOCK_RATE_MASK		0x0000ff00
+#define  CLOCK_RATE_32000		0x00000000
+#define  CLOCK_RATE_44100		0x00000100
+#define  CLOCK_RATE_48000		0x00000200
+#define  CLOCK_RATE_88200		0x00000300
+#define  CLOCK_RATE_96000		0x00000400
+#define  CLOCK_RATE_176400		0x00000500
+#define  CLOCK_RATE_192000		0x00000600
+#define  CLOCK_RATE_ANY_LOW		0x00000700
+#define  CLOCK_RATE_ANY_MID		0x00000800
+#define  CLOCK_RATE_ANY_HIGH		0x00000900
+#define  CLOCK_RATE_NONE		0x00000a00
+#define  CLOCK_RATE_SHIFT		8
+
+/*
+ * Enable streaming; read/write.  Writing a non-zero value (re)starts all
+ * streams that have a valid iso channel set; zero stops all streams.  The
+ * streams' parameters must be configured before starting.  This register is
+ * automatically cleared on a bus reset.
+ */
+#define GLOBAL_ENABLE			0x050
+
+/*
+ * Status of the sample clock; read-only.
+ */
+#define GLOBAL_STATUS			0x054
+/* The current clock source is locked. */
+#define  STATUS_SOURCE_LOCKED		0x00000001
+/* The actual sample rate; CLOCK_RATE_32000-_192000 or _NONE. */
+#define  STATUS_NOMINAL_RATE_MASK	0x0000ff00
+
+/*
+ * Status of all clock sources; read-only.
+ */
+#define GLOBAL_EXTENDED_STATUS		0x058
+/*
+ * The _LOCKED bits always show the current status; any change generates
+ * a notification.
+ */
+#define  EXT_STATUS_AES1_LOCKED		0x00000001
+#define  EXT_STATUS_AES2_LOCKED		0x00000002
+#define  EXT_STATUS_AES3_LOCKED		0x00000004
+#define  EXT_STATUS_AES4_LOCKED		0x00000008
+#define  EXT_STATUS_ADAT_LOCKED		0x00000010
+#define  EXT_STATUS_TDIF_LOCKED		0x00000020
+#define  EXT_STATUS_ARX1_LOCKED		0x00000040
+#define  EXT_STATUS_ARX2_LOCKED		0x00000080
+#define  EXT_STATUS_ARX3_LOCKED		0x00000100
+#define  EXT_STATUS_ARX4_LOCKED		0x00000200
+#define  EXT_STATUS_WC_LOCKED		0x00000400
+/*
+ * The _SLIP bits do not generate notifications; a set bit indicates that an
+ * error occurred since the last time when this register was read with
+ * a quadlet read transaction.
+ */
+#define  EXT_STATUS_AES1_SLIP		0x00010000
+#define  EXT_STATUS_AES2_SLIP		0x00020000
+#define  EXT_STATUS_AES3_SLIP		0x00040000
+#define  EXT_STATUS_AES4_SLIP		0x00080000
+#define  EXT_STATUS_ADAT_SLIP		0x00100000
+#define  EXT_STATUS_TDIF_SLIP		0x00200000
+#define  EXT_STATUS_ARX1_SLIP		0x00400000
+#define  EXT_STATUS_ARX2_SLIP		0x00800000
+#define  EXT_STATUS_ARX3_SLIP		0x01000000
+#define  EXT_STATUS_ARX4_SLIP		0x02000000
+#define  EXT_STATUS_WC_SLIP		0x04000000
+
+/*
+ * The measured rate of the current clock source, in Hz; read-only.
+ */
+#define GLOBAL_SAMPLE_RATE		0x05c
+
+/*
+ * The version of the DICE driver specification that this device conforms to;
+ * read-only.
+ */
+#define GLOBAL_VERSION			0x060
+
+/* Some old firmware versions do not have the following global registers: */
+
+/*
+ * Supported sample rates and clock sources; read-only.
+ */
+#define GLOBAL_CLOCK_CAPABILITIES	0x064
+#define  CLOCK_CAP_RATE_32000		0x00000001
+#define  CLOCK_CAP_RATE_44100		0x00000002
+#define  CLOCK_CAP_RATE_48000		0x00000004
+#define  CLOCK_CAP_RATE_88200		0x00000008
+#define  CLOCK_CAP_RATE_96000		0x00000010
+#define  CLOCK_CAP_RATE_176400		0x00000020
+#define  CLOCK_CAP_RATE_192000		0x00000040
+#define  CLOCK_CAP_SOURCE_AES1		0x00010000
+#define  CLOCK_CAP_SOURCE_AES2		0x00020000
+#define  CLOCK_CAP_SOURCE_AES3		0x00040000
+#define  CLOCK_CAP_SOURCE_AES4		0x00080000
+#define  CLOCK_CAP_SOURCE_AES_ANY	0x00100000
+#define  CLOCK_CAP_SOURCE_ADAT		0x00200000
+#define  CLOCK_CAP_SOURCE_TDIF		0x00400000
+#define  CLOCK_CAP_SOURCE_WC		0x00800000
+#define  CLOCK_CAP_SOURCE_ARX1		0x01000000
+#define  CLOCK_CAP_SOURCE_ARX2		0x02000000
+#define  CLOCK_CAP_SOURCE_ARX3		0x04000000
+#define  CLOCK_CAP_SOURCE_ARX4		0x08000000
+#define  CLOCK_CAP_SOURCE_INTERNAL	0x10000000
+
+/*
+ * Names of all clock sources; read-only.  Quadlets are byte-swapped.  Names
+ * are separated with one backslash, the list is terminated with two
+ * backslashes.  Unused clock sources are included.
+ */
+#define GLOBAL_CLOCK_SOURCE_NAMES	0x068
+#define  CLOCK_SOURCE_NAMES_SIZE	256
+
+/*
+ * Capture stream settings.  This section includes the number/size registers
+ * and the registers of all streams.
+ */
+
+/*
+ * The number of supported capture streams; read-only.
+ */
+#define TX_NUMBER			0x000
+
+/*
+ * The size of one stream's register block, in quadlets; read-only.  The
+ * registers of the first stream follow immediately afterwards; the registers
+ * of the following streams are offset by this register's value.
+ */
+#define TX_SIZE				0x004
+
+/*
+ * The isochronous channel number on which packets are sent, or -1 if the
+ * stream is not to be used; read/write.
+ */
+#define TX_ISOCHRONOUS			0x008
+
+/*
+ * The number of audio channels; read-only.  There will be one quadlet per
+ * channel; the first channel is the first quadlet in a data block.
+ */
+#define TX_NUMBER_AUDIO			0x00c
+
+/*
+ * The number of MIDI ports, 0-8; read-only.  If > 0, there will be one
+ * additional quadlet in each data block, following the audio quadlets.
+ */
+#define TX_NUMBER_MIDI			0x010
+
+/*
+ * The speed at which the packets are sent, SCODE_100-_400; read/write.
+ */
+#define TX_SPEED			0x014
+
+/*
+ * Names of all audio channels; read-only.  Quadlets are byte-swapped.  Names
+ * are separated with one backslash, the list is terminated with two
+ * backslashes.
+ */
+#define TX_NAMES			0x018
+#define  TX_NAMES_SIZE			256
+
+/*
+ * Audio IEC60958 capabilities; read-only.  Bitmask with one bit per audio
+ * channel.
+ */
+#define TX_AC3_CAPABILITIES		0x118
+
+/*
+ * Send audio data with IEC60958 label; read/write.  Bitmask with one bit per
+ * audio channel.  This register can be changed even while the stream is
+ * running.
+ */
+#define TX_AC3_ENABLE			0x11c
+
+/*
+ * Playback stream settings.  This section includes the number/size registers
+ * and the registers of all streams.
+ */
+
+/*
+ * The number of supported playback streams; read-only.
+ */
+#define RX_NUMBER			0x000
+
+/*
+ * The size of one stream's register block, in quadlets; read-only.  The
+ * registers of the first stream follow immediately afterwards; the registers
+ * of the following streams are offset by this register's value.
+ */
+#define RX_SIZE				0x004
+
+/*
+ * The isochronous channel number on which packets are received, or -1 if the
+ * stream is not to be used; read/write.
+ */
+#define RX_ISOCHRONOUS			0x008
+
+/*
+ * Index of first quadlet to be interpreted; read/write.  If > 0, that many
+ * quadlets at the beginning of each data block will be ignored, and all the
+ * audio and MIDI quadlets will follow.
+ */
+#define RX_SEQ_START			0x00c
+
+/*
+ * The number of audio channels; read-only.  There will be one quadlet per
+ * channel.
+ */
+#define RX_NUMBER_AUDIO			0x010
+
+/*
+ * The number of MIDI ports, 0-8; read-only.  If > 0, there will be one
+ * additional quadlet in each data block, following the audio quadlets.
+ */
+#define RX_NUMBER_MIDI			0x014
+
+/*
+ * Names of all audio channels; read-only.  Quadlets are byte-swapped.  Names
+ * are separated with one backslash, the list is terminated with two
+ * backslashes.
+ */
+#define RX_NAMES			0x018
+#define  RX_NAMES_SIZE			256
+
+/*
+ * Audio IEC60958 capabilities; read-only.  Bitmask with one bit per audio
+ * channel.
+ */
+#define RX_AC3_CAPABILITIES		0x118
+
+/*
+ * Receive audio data with IEC60958 label; read/write.  Bitmask with one bit
+ * per audio channel.  This register can be changed even while the stream is
+ * running.
+ */
+#define RX_AC3_ENABLE			0x11c
+
+/*
+ * Extended synchronization information.
+ * This section can be read completely with a block read request.
+ */
+
+/*
+ * Current clock source; read-only.
+ */
+#define EXT_SYNC_CLOCK_SOURCE		0x000
+
+/*
+ * Clock source is locked (boolean); read-only.
+ */
+#define EXT_SYNC_LOCKED			0x004
+
+/*
+ * Current sample rate (CLOCK_RATE_* >> CLOCK_RATE_SHIFT), _32000-_192000 or
+ * _NONE; read-only.
+ */
+#define EXT_SYNC_RATE			0x008
+
+/*
+ * ADAT user data bits; read-only.
+ */
+#define EXT_SYNC_ADAT_USER_DATA		0x00c
+/* The data bits, if available. */
+#define  ADAT_USER_DATA_MASK		0x0f
+/* The data bits are not available. */
+#define  ADAT_USER_DATA_NO_DATA		0x10
+
+#endif
diff --git a/sound/firewire/dice.c b/sound/firewire/dice.c
index 3591aeb..1da1dde 100644
--- a/sound/firewire/dice.c
+++ b/sound/firewire/dice.c
@@ -26,212 +26,7 @@
 #include "amdtp.h"
 #include "iso-resources.h"
 #include "lib.h"
-
-#define DICE_PRIVATE_SPACE		0xffffe0000000uLL
-
-/* offset from DICE_PRIVATE_SPACE; offsets and sizes in quadlets */
-#define DICE_GLOBAL_OFFSET		0x00
-#define DICE_GLOBAL_SIZE		0x04
-#define DICE_TX_OFFSET			0x08
-#define DICE_TX_SIZE			0x0c
-#define DICE_RX_OFFSET			0x10
-#define DICE_RX_SIZE			0x14
-
-/* pointed to by DICE_GLOBAL_OFFSET */
-#define GLOBAL_OWNER			0x000
-#define  OWNER_NO_OWNER			0xffff000000000000uLL
-#define  OWNER_NODE_SHIFT		48
-#define GLOBAL_NOTIFICATION		0x008
-#define  NOTIFY_RX_CFG_CHG		0x00000001
-#define  NOTIFY_TX_CFG_CHG		0x00000002
-#define  NOTIFY_DUP_ISOC		0x00000004
-#define  NOTIFY_BW_ERR			0x00000008
-#define  NOTIFY_LOCK_CHG		0x00000010
-#define  NOTIFY_CLOCK_ACCEPTED		0x00000020
-#define  NOTIFY_INTERFACE_CHG		0x00000040
-#define  NOTIFY_MESSAGE			0x00100000
-#define GLOBAL_NICK_NAME		0x00c
-#define  NICK_NAME_SIZE			64
-#define GLOBAL_CLOCK_SELECT		0x04c
-#define  CLOCK_SOURCE_MASK		0x000000ff
-#define  CLOCK_SOURCE_AES1		0x00000000
-#define  CLOCK_SOURCE_AES2		0x00000001
-#define  CLOCK_SOURCE_AES3		0x00000002
-#define  CLOCK_SOURCE_AES4		0x00000003
-#define  CLOCK_SOURCE_AES_ANY		0x00000004
-#define  CLOCK_SOURCE_ADAT		0x00000005
-#define  CLOCK_SOURCE_TDIF		0x00000006
-#define  CLOCK_SOURCE_WC		0x00000007
-#define  CLOCK_SOURCE_ARX1		0x00000008
-#define  CLOCK_SOURCE_ARX2		0x00000009
-#define  CLOCK_SOURCE_ARX3		0x0000000a
-#define  CLOCK_SOURCE_ARX4		0x0000000b
-#define  CLOCK_SOURCE_INTERNAL		0x0000000c
-#define  CLOCK_RATE_MASK		0x0000ff00
-#define  CLOCK_RATE_32000		0x00000000
-#define  CLOCK_RATE_44100		0x00000100
-#define  CLOCK_RATE_48000		0x00000200
-#define  CLOCK_RATE_88200		0x00000300
-#define  CLOCK_RATE_96000		0x00000400
-#define  CLOCK_RATE_176400		0x00000500
-#define  CLOCK_RATE_192000		0x00000600
-#define  CLOCK_RATE_ANY_LOW		0x00000700
-#define  CLOCK_RATE_ANY_MID		0x00000800
-#define  CLOCK_RATE_ANY_HIGH		0x00000900
-#define  CLOCK_RATE_NONE		0x00000a00
-#define  CLOCK_RATE_SHIFT		8
-#define GLOBAL_ENABLE			0x050
-#define  ENABLE				0x00000001
-#define GLOBAL_STATUS			0x054
-#define  STATUS_SOURCE_LOCKED		0x00000001
-#define  STATUS_RATE_CONFLICT		0x00000002
-#define  STATUS_NOMINAL_RATE_MASK	0x0000ff00
-#define GLOBAL_EXTENDED_STATUS		0x058
-#define  EXT_STATUS_AES1_LOCKED		0x00000001
-#define  EXT_STATUS_AES2_LOCKED		0x00000002
-#define  EXT_STATUS_AES3_LOCKED		0x00000004
-#define  EXT_STATUS_AES4_LOCKED		0x00000008
-#define  EXT_STATUS_ADAT_LOCKED		0x00000010
-#define  EXT_STATUS_TDIF_LOCKED		0x00000020
-#define  EXT_STATUS_ARX1_LOCKED		0x00000040
-#define  EXT_STATUS_ARX2_LOCKED		0x00000080
-#define  EXT_STATUS_ARX3_LOCKED		0x00000100
-#define  EXT_STATUS_ARX4_LOCKED		0x00000200
-#define  EXT_STATUS_WC_LOCKED		0x00000400
-#define  EXT_STATUS_AES1_SLIP		0x00010000
-#define  EXT_STATUS_AES2_SLIP		0x00020000
-#define  EXT_STATUS_AES3_SLIP		0x00040000
-#define  EXT_STATUS_AES4_SLIP		0x00080000
-#define  EXT_STATUS_ADAT_SLIP		0x00100000
-#define  EXT_STATUS_TDIF_SLIP		0x00200000
-#define  EXT_STATUS_ARX1_SLIP		0x00400000
-#define  EXT_STATUS_ARX2_SLIP		0x00800000
-#define  EXT_STATUS_ARX3_SLIP		0x01000000
-#define  EXT_STATUS_ARX4_SLIP		0x02000000
-#define  EXT_STATUS_WC_SLIP		0x04000000
-#define GLOBAL_SAMPLE_RATE		0x05c
-#define GLOBAL_VERSION			0x060
-#define GLOBAL_CLOCK_CAPABILITIES	0x064
-#define  CLOCK_CAP_RATE_32000		0x00000001
-#define  CLOCK_CAP_RATE_44100		0x00000002
-#define  CLOCK_CAP_RATE_48000		0x00000004
-#define  CLOCK_CAP_RATE_88200		0x00000008
-#define  CLOCK_CAP_RATE_96000		0x00000010
-#define  CLOCK_CAP_RATE_176400		0x00000020
-#define  CLOCK_CAP_RATE_192000		0x00000040
-#define  CLOCK_CAP_SOURCE_AES1		0x00010000
-#define  CLOCK_CAP_SOURCE_AES2		0x00020000
-#define  CLOCK_CAP_SOURCE_AES3		0x00040000
-#define  CLOCK_CAP_SOURCE_AES4		0x00080000
-#define  CLOCK_CAP_SOURCE_AES_ANY	0x00100000
-#define  CLOCK_CAP_SOURCE_ADAT		0x00200000
-#define  CLOCK_CAP_SOURCE_TDIF		0x00400000
-#define  CLOCK_CAP_SOURCE_WC		0x00800000
-#define  CLOCK_CAP_SOURCE_ARX1		0x01000000
-#define  CLOCK_CAP_SOURCE_ARX2		0x02000000
-#define  CLOCK_CAP_SOURCE_ARX3		0x04000000
-#define  CLOCK_CAP_SOURCE_ARX4		0x08000000
-#define  CLOCK_CAP_SOURCE_INTERNAL	0x10000000
-#define GLOBAL_CLOCK_SOURCE_NAMES	0x068
-#define  CLOCK_SOURCE_NAMES_SIZE	256
-
-/* pointed to by DICE_TX_OFFSET */
-#define TX_NUMBER			0x000
-#define TX_SIZE				0x004
-/* repeated TX_NUMBER times, offset by TX_SIZE quadlets */
-#define TX_ISOCHRONOUS			0x008
-#define TX_NUMBER_AUDIO			0x00c
-#define TX_NUMBER_MIDI			0x010
-#define TX_SPEED			0x014
-#define TX_NAMES			0x018
-#define  TX_NAMES_SIZE			256
-#define TX_AC3_CAPABILITIES		0x118
-#define TX_AC3_ENABLE			0x11c
-
-/* pointed to by DICE_RX_OFFSET */
-#define RX_NUMBER			0x000
-#define RX_SIZE				0x004
-/* repeated RX_NUMBER times, offset by RX_SIZE quadlets */
-#define RX_ISOCHRONOUS			0x008
-#define RX_SEQ_START			0x00c
-#define RX_NUMBER_AUDIO			0x010
-#define RX_NUMBER_MIDI			0x014
-#define RX_NAMES			0x018
-#define  RX_NAMES_SIZE			256
-#define RX_AC3_CAPABILITIES		0x118
-#define RX_AC3_ENABLE			0x11c
-
-
-#define FIRMWARE_LOAD_SPACE		0xffffe0100000uLL
-
-/* offset from FIRMWARE_LOAD_SPACE */
-#define FIRMWARE_VERSION		0x000
-#define FIRMWARE_OPCODE			0x004
-#define  OPCODE_MASK			0x00000fff
-#define  OPCODE_GET_IMAGE_DESC		0x00000000
-#define  OPCODE_DELETE_IMAGE		0x00000001
-#define  OPCODE_CREATE_IMAGE		0x00000002
-#define  OPCODE_UPLOAD			0x00000003
-#define  OPCODE_UPLOAD_STAT		0x00000004
-#define  OPCODE_RESET_IMAGE		0x00000005
-#define  OPCODE_TEST_ACTION		0x00000006
-#define  OPCODE_GET_RUNNING_IMAGE_VINFO	0x0000000a
-#define  OPCODE_EXECUTE			0x80000000
-#define FIRMWARE_RETURN_STATUS		0x008
-#define FIRMWARE_PROGRESS		0x00c
-#define  PROGRESS_CURR_MASK		0x00000fff
-#define  PROGRESS_MAX_MASK		0x00fff000
-#define  PROGRESS_TOUT_MASK		0x0f000000
-#define  PROGRESS_FLAG			0x80000000
-#define FIRMWARE_CAPABILITIES		0x010
-#define  FL_CAP_AUTOERASE		0x00000001
-#define  FL_CAP_PROGRESS		0x00000002
-#define FIRMWARE_DATA			0x02c
-#define  TEST_CMD_POKE			0x00000001
-#define  TEST_CMD_PEEK			0x00000002
-#define  CMD_GET_AVS_CNT		0x00000003
-#define  CMD_CLR_AVS_CNT		0x00000004
-#define  CMD_SET_MODE			0x00000005
-#define  CMD_SET_MIDIBP			0x00000006
-#define  CMD_GET_AVSPHASE		0x00000007
-#define  CMD_ENABLE_BNC_SYNC		0x00000008
-#define  CMD_PULSE_BNC_SYNC		0x00000009
-#define  CMD_EMUL_SLOW_CMD		0x0000000a
-#define FIRMWARE_TEST_DELAY		0xfd8
-#define FIRMWARE_TEST_BUF		0xfdc
-
-
-/* EAP */
-#define EAP_PRIVATE_SPACE		0xffffe0200000uLL
-
-#define EAP_CAPABILITY_OFFSET		0x000
-#define EAP_CAPABILITY_SIZE		0x004
-/* ... */
-
-#define EAP_ROUTER_CAPS			0x000
-#define  ROUTER_EXPOSED			0x00000001
-#define  ROUTER_READ_ONLY		0x00000002
-#define  ROUTER_FLASH			0x00000004
-#define  MAX_ROUTES_MASK		0xffff0000
-#define EAP_MIXER_CAPS			0x004
-#define  MIXER_EXPOSED			0x00000001
-#define  MIXER_READ_ONLY		0x00000002
-#define  MIXER_FLASH			0x00000004
-#define  MIXER_IN_DEV_MASK		0x000000f0
-#define  MIXER_OUT_DEV_MASK		0x00000f00
-#define  MIXER_INPUTS_MASK		0x00ff0000
-#define  MIXER_OUTPUTS_MASK		0xff000000
-#define EAP_GENERAL_CAPS		0x008
-#define  GENERAL_STREAM_CONFIG		0x00000001
-#define  GENERAL_FLASH			0x00000002
-#define  GENERAL_PEAK			0x00000004
-#define  GENERAL_MAX_TX_STREAMS_MASK	0x000000f0
-#define  GENERAL_MAX_RX_STREAMS_MASK	0x00000f00
-#define  GENERAL_STREAM_CONFIG_FLASH	0x00001000
-#define  GENERAL_CHIP_MASK		0x00ff0000
-#define  GENERAL_CHIP_DICE_II		0x00000000
-#define  GENERAL_CHIP_DICE_MINI		0x00010000
-#define  GENERAL_CHIP_DICE_JR		0x00020000
+#include "dice-interface.h"


 struct dice {
@@ -479,7 +274,7 @@ static int dice_enable_set(struct dice *dice)
 	__be32 value;
 	int rcode, err, errors = 0;

-	value = cpu_to_be32(ENABLE);
+	value = cpu_to_be32(1);
 	for (;;) {
 		rcode = fw_run_transaction(device->card,
 					   TCODE_WRITE_QUADLET_REQUEST,

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135991&iu=/4140/ostg.clktrk
