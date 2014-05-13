From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 11/15] oxfw: Add a quirk for Griffin FireWave
Date: Tue, 13 May 2014 23:27:48 +0900
Message-ID: <1399991272-5807-12-git-send-email-o-takashi@sakamocchi.jp>
References: <1399991272-5807-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1399991272-5807-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: clemens@ladisch.de
Cc: alsa-devel@alsa-project.org, fenlason@redhat.com, ffado-devel@lists.sf.net, linux1394-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Griffin FireWave has 7 entries for stream formation. But via 'LIST'
subfunction of AV/C Stream Format Information command, 6 of
them can be retrieved. The rest can be retrieved via 'SINGLE'
subfunction of the command.

This commit adds a workaround for this quirk.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/oxfw_stream.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/sound/firewire/oxfw/oxfw_stream.c b/sound/firewire/oxfw/oxfw_stream.c
index 0d81bba..4d66648 100644
--- a/sound/firewire/oxfw/oxfw_stream.c
+++ b/sound/firewire/oxfw/oxfw_stream.c
@@ -365,8 +365,8 @@ static int fill_stream_formations(struct snd_oxfw *oxfw,
 				  unsigned short pid)
 {
 	u8 *buf;
-	struct snd_oxfw_stream_formation *formations;
-	unsigned int len, eid = 0;
+	struct snd_oxfw_stream_formation *formations, tmp;
+	unsigned int i, len, eid = 0;
 	int err;
 
 	buf = kmalloc(AVC_GENERIC_FRAME_MAXIMUM_BYTES, GFP_KERNEL);
@@ -416,6 +416,25 @@ static int fill_stream_formations(struct snd_oxfw *oxfw,
 			break;
 		}
 	}
+
+	if (eid >= SND_OXFW_STREAM_FORMAT_ENTRIES)
+		goto end;
+
+	/* Griffin FireWave have another entry in current formation. */
+	len = AVC_GENERIC_FRAME_MAXIMUM_BYTES;
+	err = avc_stream_get_format_single(oxfw->unit, dir, 0, buf, &len);
+	if (err < 0)
+		goto end;
+	err = parse_stream_formation(buf, len, &tmp);
+	if (err < 0)
+		goto end;
+	/* Store this if no duplicates. */
+	for (i = 0; i < SND_OXFW_STREAM_FORMAT_ENTRIES; i++) {
+		if (memcmp(&formations[i], &tmp, sizeof(tmp)) == 0)
+			break;
+	}
+	if (i == SND_OXFW_STREAM_FORMAT_ENTRIES)
+		formations[eid] = tmp;
 end:
 	kfree(buf);
 	return err;
-- 
1.8.3.2


------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.
Get unparalleled scalability from the best Selenium testing platform available
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
