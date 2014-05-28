From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ALSA: bebob: sizeof() vs ARRAY_SIZE() typo
Date: Wed, 28 May 2014 19:43:30 +0300
Message-ID: <20140528164330.GD1824@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

ARRAY_SIZE() was intended here instead of sizeof().  The
"bridgeco_freq_table" array holds integers so the original condition is
never true.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/firewire/bebob/bebob_stream.c b/sound/firewire/bebob/bebob_stream.c
index 514c7c9..bc4f827 100644
--- a/sound/firewire/bebob/bebob_stream.c
+++ b/sound/firewire/bebob/bebob_stream.c
@@ -749,7 +749,7 @@ parse_stream_formation(u8 *buf, unsigned int len,
 		if (buf[2] == bridgeco_freq_table[i])
 			break;
 	}
-	if (i == sizeof(bridgeco_freq_table))
+	if (i == ARRAY_SIZE(bridgeco_freq_table))
 		return -ENOSYS;
 
 	/* Avoid double count by different entries for the same rate. */
