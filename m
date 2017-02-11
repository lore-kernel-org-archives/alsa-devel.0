From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 04/13] ALSA: fireface: add an abstraction layer
	for model-specific protocols
Date: Sat, 11 Feb 2017 23:25:00 +0900
Message-ID: <20170211142509.4795-5-o-takashi@sakamocchi.jp>
References: <20170211142509.4795-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 286A2266A65
 for <alsa-devel@alsa-project.org>; Sat, 11 Feb 2017 15:25:14 +0100 (CET)
In-Reply-To: <20170211142509.4795-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

As of 2016, RME discontinued its Fireface series, thus it's OK for us
to drive known units with three types of firmware.

As long as investigating Fireface 400 with Windows driver and comparing
the result to FFADO implementation, these firmwares have different register
assignments. On the other hand, according to manuals of each models,
features relevant to packet streaming seem to be common. It's reasonable
to assume an abstraction layer of protocols to communicate to each models.

This commit adds an abstraction layer for the protocols. This layer
includes some functions to operate common features of models in this
series.

In IEC 61883-1/6, the sequence of packet can transfer timing information
to synchronize transmitters/receivers. Units of each node on IEEE 1394
bus can generate transmitter's timing clock by handling value of SYT field
in CIP header with high-precision clock. For audio and music units on
IEEE 1394 bus, this recovered clock is designed to used for sampling clock
to capture/generate PCM frames on DSP/ADC/DAC. (Actually, there's no units
to implement this specification correctly in this world, as long as I
know).

Fireface series doesn't use this mechanism and isochronous packet with
CIP header. It uses internal crystal unit as its initial sampling clock.
When detecting input signals which can be available for sampling clock
(e.g. ADAT input), drivers can configure units to use the signals as
source of sampling clock. When something goes wrong, e.g. frequency
mismatching between the signal and configured value, units switch to
the other detected signals alternatively. When detecting no alternatives,
internal crystal unit is used as source of sampling clock. On manual of
Fireface 400, this mechanism is described as 'Autosync'.

For packet streaming layer, it's enough to get current selection of
source signals for the sampling clock and its frequency. When internal
crystal is selected, drivers can sets arbitrary sampling frequency,
else they should follow configured frequency. For this purpose,
.get_clock is added.

On the units, packet streaming is controlled by write transactions to
certain registers. Format of the packet, e.g. the number of data channels
in a data block, is also configured by the same manner. For this purpose,
.begin_session and .finish_session is added.

The remarkable point of this protocol is to allow drivers to configure
arbitrary sampling transmission frequency; e.g. 123.456 Hz. As long as I
know, there's no DAC/ADC chips which support this kind of capability.
I think a pair of packet streaming/data block processing layer is isolated
from sampling data processing layer in a point of governed clock. In
short, between these parts, resampling layer exists between these parts.
Actually, for Fireface 400, write transactions to 0x'0000'8010'051c has
an effect to change sampling clock frequency with base frequency of
32.0/44.1/48.0 kHz and its multipliers (x2/x4).

For this reason, the abstraction layer has no function to set sampling
clock. Instead, each implementation of .begin_session is expected to
configure sampling transmission frequency.

Drivers are allows to bank up data fetching from a pair of packet
streaming/data block processing layer and sampling data processing layer.
This feature seems to suppress noises at starting/stopping packet
streaming. For this purpose, .switch_fetching_mode is added.

As I described in the above, units have remarkable mechanism to manage
sampling clock and process sampling data. For debugging purpose,
.dump_sync_status and .dump_clock_config are added. I don't have a need
to common interface to represent the status and configuration,
developers can add actual implementation of the abstraction layer as he
or she likes.

Unlike PCM frames, MIDI messages are transferred by asynchronous
communication over IEEE 1394 bus, thus target addresses are important for
this feature. The .midi_high_addr_reg, .midi_rx_port_0_reg and
.midi_rx_port_1_reg are for this purpose. I'll describe them in following
commit.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireface/ff.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/sound/firewire/fireface/ff.h b/sound/firewire/fireface/ff.h
index 269fa25..7be0ea4 100644
--- a/sound/firewire/fireface/ff.h
+++ b/sound/firewire/fireface/ff.h
@@ -19,11 +19,13 @@
 #include <linux/compat.h>
 
 #include <sound/core.h>
+#include <sound/info.h>
 
 #include "../lib.h"
 
 #define SND_FF_STREAM_MODES		3
 
+struct snd_ff_protocol;
 struct snd_ff_spec {
 	const char *const name;
 
@@ -32,6 +34,8 @@ struct snd_ff_spec {
 
 	unsigned int midi_in_ports;
 	unsigned int midi_out_ports;
+
+	struct snd_ff_protocol *protocol;
 };
 
 struct snd_ff {
@@ -44,4 +48,31 @@ struct snd_ff {
 
 	const struct snd_ff_spec *spec;
 };
+
+enum snd_ff_clock_src {
+	SND_FF_CLOCK_SRC_INTERNAL,
+	SND_FF_CLOCK_SRC_SPDIF,
+	SND_FF_CLOCK_SRC_ADAT,
+	SND_FF_CLOCK_SRC_WORD,
+	SND_FF_CLOCK_SRC_LTC,
+	/* TODO: perhaps ADAT2 and TCO exists. */
+};
+
+struct snd_ff_protocol {
+	int (*get_clock)(struct snd_ff *ff, unsigned int *rate,
+			 enum snd_ff_clock_src *src);
+	int (*begin_session)(struct snd_ff *ff, unsigned int rate);
+	void (*finish_session)(struct snd_ff *ff);
+	int (*switch_fetching_mode)(struct snd_ff *ff, bool enable);
+
+	void (*dump_sync_status)(struct snd_ff *ff,
+				 struct snd_info_buffer *buffer);
+	void (*dump_clock_config)(struct snd_ff *ff,
+				  struct snd_info_buffer *buffer);
+
+	u64 midi_high_addr_reg;
+	u64 midi_rx_port_0_reg;
+	u64 midi_rx_port_1_reg;
+};
+
 #endif
-- 
2.9.3
