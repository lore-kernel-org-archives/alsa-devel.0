From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/6] ALSA: bebob: fix wrong reference count for
	stream functionality at error path of rawmidi interface
Date: Sun,  7 Jul 2019 14:20:06 +0900
Message-ID: <20190707052011.24687-2-o-takashi@sakamocchi.jp>
References: <20190707052011.24687-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com
 [64.147.123.24])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 979F7F80213
 for <alsa-devel@alsa-project.org>; Sun,  7 Jul 2019 07:20:24 +0200 (CEST)
In-Reply-To: <20190707052011.24687-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

In IEC 61883-6, several types of sampling data can be multiplexed into
payload of common isochronous packet (CIP). For typical audio and music
units, PCM samples and MIDI messages are multiplexed into one packet
streaming.

ALSA bebob driver allows applications of rawmidi interface to start
packet streaming for transmission of MIDI messages. However at error
path, the reference count of stream functionality is not operated
correctly. This can brings a bug that packet streaming is not stopped
when all referrers release the count.

This commit fixes the bug.

Fixes: ac2888b958f2 ("ALSA: bebob: configure sampling transfer frequency in pcm.hw_params callback")
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/bebob_midi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/firewire/bebob/bebob_midi.c b/sound/firewire/bebob/bebob_midi.c
index f7db1f7bce86..f903271e93d0 100644
--- a/sound/firewire/bebob/bebob_midi.c
+++ b/sound/firewire/bebob/bebob_midi.c
@@ -22,6 +22,8 @@ static int midi_open(struct snd_rawmidi_substream *substream)
 	if (err >= 0) {
 		++bebob->substreams_counter;
 		err = snd_bebob_stream_start_duplex(bebob);
+		if (err < 0)
+			--bebob->substreams_counter;
 	}
 	mutex_unlock(&bebob->mutex);
 	if (err < 0)
-- 
2.20.1
