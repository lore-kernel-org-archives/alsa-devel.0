From: David Henningsson <david.henningsson@canonical.com>
Subject: [RFC] ALSA: usb: supply channel maps even when
	wChannelConfig is unspecified
Date: Fri,  1 Nov 2013 16:38:59 +0100
Message-ID: <1383320339-22666-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id C3ADC2657FA
 for <alsa-devel@alsa-project.org>; Fri,  1 Nov 2013 16:38:58 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

If wChannelconfig is given for some formats but not others, userspace
might not be able to set the channel map.

This is RFC because I'm not sure what the best behaviour is - to guess
the channel map from the given number of channels (it's quite likely
that one channel is MONO and two channels is FL FR), or just to supply
UNKNOWN for all channels.

But the complete lack of channel map for a format leads userspace to
believe that the format is not available at all. Or am I
misunderstanding how this should be used?

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/usb/stream.c |   18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/sound/usb/stream.c b/sound/usb/stream.c
index c4339f9..b43b6ee 100644
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -281,8 +281,6 @@ static struct snd_pcm_chmap_elem *convert_chmap(int channels, unsigned int bits,
 	const unsigned int *maps;
 	int c;
 
-	if (!bits)
-		return NULL;
 	if (channels > ARRAY_SIZE(chmap->map))
 		return NULL;
 
@@ -293,9 +291,19 @@ static struct snd_pcm_chmap_elem *convert_chmap(int channels, unsigned int bits,
 	maps = protocol == UAC_VERSION_2 ? uac2_maps : uac1_maps;
 	chmap->channels = channels;
 	c = 0;
-	for (; bits && *maps; maps++, bits >>= 1) {
-		if (bits & 1)
-			chmap->map[c++] = *maps;
+
+	if (bits) {
+		for (; bits && *maps; maps++, bits >>= 1)
+			if (bits & 1)
+				chmap->map[c++] = *maps;
+	} else {
+		/* If we're missing wChannelConfig, then guess something
+		    to make sure the channel map is not skipped entirely */
+		if (channels == 1)
+			chmap->map[c++] = SNDRV_CHMAP_MONO;
+		else
+			for (; c < channels && *maps; maps++)
+				chmap->map[c++] = *maps;
 	}
 
 	for (; c < channels; c++)
-- 
1.7.9.5
