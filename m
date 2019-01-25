From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] ALSA: fireface: Off by one in
	latter_handle_midi_msg()
Date: Fri, 25 Jan 2019 15:44:18 +0300
Message-ID: <20190125124418.GA21947@kadam>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A5132673DD
 for <alsa-devel@alsa-project.org>; Fri, 25 Jan 2019 13:44:32 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

The > should be >= or otherwise we potentially read one element beyond
the end of the ff->tx_midi_substreams[] array.

Fixes: 73f5537fb209 ("ALSA: fireface: support tx MIDI functionality of Fireface UCX")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 sound/firewire/fireface/ff-protocol-latter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/firewire/fireface/ff-protocol-latter.c b/sound/firewire/fireface/ff-protocol-latter.c
index 817af4447349..438aeed9a1ab 100644
--- a/sound/firewire/fireface/ff-protocol-latter.c
+++ b/sound/firewire/fireface/ff-protocol-latter.c
@@ -275,7 +275,7 @@ static void latter_handle_midi_msg(struct snd_ff *ff, unsigned int offset,
 	struct snd_rawmidi_substream *substream;
 	unsigned int len;
 
-	if (index > ff->spec->midi_in_ports)
+	if (index >= ff->spec->midi_in_ports)
 		return;
 
 	switch (data & 0x0000000f) {
-- 
2.17.1
