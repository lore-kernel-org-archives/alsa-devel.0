From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: oxfw: fix a condition and return code in
	start_stream()
Date: Fri, 27 Feb 2015 09:39:32 +0900
Message-ID: <1424997572-2493-1-git-send-email-o-takashi@sakamocchi.jp>
References: <20150226203202.GC6820@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 41DCB2606D0
 for <alsa-devel@alsa-project.org>; Fri, 27 Feb 2015 01:39:37 +0100 (CET)
In-Reply-To: <20150226203202.GC6820@mwanda>
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
Cc: alsa-devel@alsa-project.org, dan.carpenter@oracle.com
List-Id: alsa-devel@alsa-project.org

The amdtp_stream_wait_callback() doesn't return minus value and
the return code is not for error code.

This commit fixes with a propper condition and an error code.

Fixes: f3699e2c7745 ('ALSA: oxfw: Change the way to start stream')
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/oxfw-stream.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/firewire/oxfw/oxfw-stream.c b/sound/firewire/oxfw/oxfw-stream.c
index 29ccb36..e6757cd 100644
--- a/sound/firewire/oxfw/oxfw-stream.c
+++ b/sound/firewire/oxfw/oxfw-stream.c
@@ -171,9 +171,10 @@ static int start_stream(struct snd_oxfw *oxfw, struct amdtp_stream *stream,
 	}
 
 	/* Wait first packet */
-	err = amdtp_stream_wait_callback(stream, CALLBACK_TIMEOUT);
-	if (err < 0)
+	if (!amdtp_stream_wait_callback(stream, CALLBACK_TIMEOUT)) {
 		stop_stream(oxfw, stream);
+		err = -ETIMEDOUT;
+	}
 end:
 	return err;
 }
-- 
2.1.0
