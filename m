From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 47/49] bebob: Add a quirk of data blocks for MIDI messages for
	some M-Audio devices
Date: Fri, 25 Apr 2014 22:45:28 +0900
Message-ID: <1398433530-13136-48-git-send-email-o-takashi@sakamocchi.jp>
References: <1398433530-13136-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1398433530-13136-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

The firmwares for M-Audio Firewire 410/1814 and ProjectMix I/O has a quirk to
ignore MIDI messages in data blocks more than 8. This commit uses a flag which
Fireworks uses for a similar quirk.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/bebob_stream.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/firewire/bebob/bebob_stream.c b/sound/firewire/bebob/bebob_stream.c
index 3e74d9b..452e936 100644
--- a/sound/firewire/bebob/bebob_stream.c
+++ b/sound/firewire/bebob/bebob_stream.c
@@ -472,6 +472,13 @@ int snd_bebob_stream_init_duplex(struct snd_bebob *bebob)
 		amdtp_stream_destroy(&bebob->rx_stream);
 		destroy_both_connections(bebob);
 	}
+	/*
+	 * The firmware for these devices ignore MIDI messages in more than
+	 * first 8 data blocks of an received AMDTP packet.
+	 */
+	if (bebob->spec == &maudio_fw410_spec ||
+	    bebob->spec == &maudio_special_spec)
+		bebob->rx_stream.rx_blocks_for_midi = 8;
 end:
 	return err;
 }
-- 
1.8.3.2


------------------------------------------------------------------------------
Start Your Social Network Today - Download eXo Platform
Build your Enterprise Intranet with eXo Platform Software
Java Based Open Source Intranet - Social, Extensible, Cloud Ready
Get Started Now And Turn Your Intranet Into A Collaboration Platform
http://p.sf.net/sfu/ExoPlatform
