From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 01/11] ALSA: bebob: improve signal mode
	detection for clock source
Date: Sun, 14 Jun 2015 12:49:27 +0900
Message-ID: <1434253777-433-2-git-send-email-o-takashi@sakamocchi.jp>
References: <1434253777-433-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 67F312604DA
 for <alsa-devel@alsa-project.org>; Sun, 14 Jun 2015 05:49:44 +0200 (CEST)
In-Reply-To: <1434253777-433-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: kim@incendio.no, alsa-devel@alsa-project.org, jh1ood@gmail.com, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

With BeBoB version 3, current ALSA BeBoB driver detects the type of
current clock signal source wrongly. This is due to a lack of proper
implementation to parse the information.

This commit renews the parser. As a result, this driver detects
SYT-Match clock signal, thus it can start streams with two modes;
SYT-Match mode and the others. SYT-Match mode will be supported in future
commits.

There's a constrain about detected internal/external clock source.
When detecting external clock source, this driver allows userspace
applications to use current sampling rate only. This is due to consider
abour synchronization to external clock sources such as S/PDIF, ADAT or
word-clock.

According to several information from some devices, I guesss that the
internal clock of most devices synchronize to IEEE 1394 cycle start
packet. In this case, by a usual way, it's detect as 'Sync type
of output Music Sub-Unit' connected to 'Sync type of PCR output Unit
(oPCR)', and this driver judges it as internal clock. Therefore,
userspace applications is allowed to request arbitrary supported sampling
rates.

On the other hand, several devices based on BeBoB version 3 have
additional internal clock. In this case, by a usual way, it's detect as
'Sync/Additional type of External input Unit'. Unfortunately, there's no
way to distinguish this sync type from the other external clock sources
such as word-clock. In this case, this driver handles it as external and
userspace applications is forced to use current sampling rate.

I note that when the source of clock is detected as 'Isochronous stream
type of input PCR[0]', it's under 'SYT-Match' mode. In this mode, the
synchronization clock is generated according to SYT-series in received
packets. In this case, this driver generates the series by myself. I
experienced this mode often make the device silent suddenly during
playbacking. This means that the mode is easy to lost synchronization.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/bebob.h        |  3 +-
 sound/firewire/bebob/bebob_stream.c | 78 +++++++++++++++++++++++++++++++++----
 2 files changed, 72 insertions(+), 9 deletions(-)

diff --git a/sound/firewire/bebob/bebob.h b/sound/firewire/bebob/bebob.h
index dfbcd23..2a918ca 100644
--- a/sound/firewire/bebob/bebob.h
+++ b/sound/firewire/bebob/bebob.h
@@ -159,7 +159,8 @@ enum avc_bridgeco_plug_type {
 	AVC_BRIDGECO_PLUG_TYPE_MIDI	= 0x02,
 	AVC_BRIDGECO_PLUG_TYPE_SYNC	= 0x03,
 	AVC_BRIDGECO_PLUG_TYPE_ANA	= 0x04,
-	AVC_BRIDGECO_PLUG_TYPE_DIG	= 0x05
+	AVC_BRIDGECO_PLUG_TYPE_DIG	= 0x05,
+	AVC_BRIDGECO_PLUG_TYPE_ADDITION	= 0x06
 };
 static inline void
 avc_bridgeco_fill_unit_addr(u8 buf[AVC_BRIDGECO_ADDR_BYTES],
diff --git a/sound/firewire/bebob/bebob_stream.c b/sound/firewire/bebob/bebob_stream.c
index 98e4fc8..2ccef4ce 100644
--- a/sound/firewire/bebob/bebob_stream.c
+++ b/sound/firewire/bebob/bebob_stream.c
@@ -122,6 +122,7 @@ snd_bebob_stream_check_internal_clock(struct snd_bebob *bebob, bool *internal)
 	struct snd_bebob_clock_spec *clk_spec = bebob->spec->clock;
 	u8 addr[AVC_BRIDGECO_ADDR_BYTES], input[7];
 	unsigned int id;
+	enum avc_bridgeco_plug_type type;
 	int err = 0;
 
 	*internal = false;
@@ -182,14 +183,75 @@ snd_bebob_stream_check_internal_clock(struct snd_bebob *bebob, bool *internal)
 		goto end;
 	}
 
-	/*
-	 * If source of clock is internal CSR, Music Sub Unit Sync Input is
-	 * a destination of Music Sub Unit Sync Output.
-	 */
-	*internal = ((input[0] == AVC_BRIDGECO_PLUG_DIR_OUT) &&
-		     (input[1] == AVC_BRIDGECO_PLUG_MODE_SUBUNIT) &&
-		     (input[2] == 0x0c) &&
-		     (input[3] == 0x00));
+	/* The source from any output plugs is for one purpose only. */
+	if (input[0] == AVC_BRIDGECO_PLUG_DIR_OUT) {
+		/*
+		 * In BeBoB architecture, the source from music subunit may
+		 * bypass from oPCR[0]. This means that this source gives
+		 * synchronization to IEEE 1394 cycle start packet.
+		 */
+		if (input[1] == AVC_BRIDGECO_PLUG_MODE_SUBUNIT &&
+		    input[2] == 0x0c) {
+			*internal = true;
+			goto end;
+		}
+	/* The source from any input units is for several purposes. */
+	} else if (input[1] == AVC_BRIDGECO_PLUG_MODE_UNIT) {
+		if (input[2] == AVC_BRIDGECO_PLUG_UNIT_ISOC) {
+			if (input[3] == 0x00) {
+				/*
+				 * This source comes from iPCR[0]. This means
+				 * that presentation timestamp calculated by
+				 * SYT series of the received packets. In
+				 * short, this driver is the master of
+				 * synchronization.
+				 */
+				err = -EIO;
+				goto end;
+			} else {
+				/*
+				 * This source comes from iPCR[1-29]. This
+				 * means that the synchronization stream is not
+				 * the Audio/MIDI compound stream.
+				 */
+				*internal = false;
+				goto end;
+			}
+		} else if (input[2] == AVC_BRIDGECO_PLUG_UNIT_EXT) {
+			/* Check type of this plug.  */
+			avc_bridgeco_fill_unit_addr(addr,
+						    AVC_BRIDGECO_PLUG_DIR_IN,
+						    AVC_BRIDGECO_PLUG_UNIT_EXT,
+						    input[3]);
+			err = avc_bridgeco_get_plug_type(bebob->unit, addr,
+							 &type);
+			if (err < 0)
+				goto end;
+
+			if (type == AVC_BRIDGECO_PLUG_TYPE_DIG) {
+				/*
+				 * SPDIF/ADAT or sometimes (not always) word
+				 * clock.
+				 */
+				*internal = false;
+				goto end;
+			} else if (type == AVC_BRIDGECO_PLUG_TYPE_SYNC) {
+				/* Often word clock. */
+				*internal = false;
+				goto end;
+			} else if (type == AVC_BRIDGECO_PLUG_TYPE_ADDITION) {
+				/*
+				 * Not standard.
+				 * Mostly, additional internal clock.
+				 */
+				*internal = true;
+				goto end;
+			}
+		}
+	}
+
+	/* Not supported. */
+	err = -EIO;
 end:
 	return err;
 }
-- 
2.1.4
