From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] sound/core/oss/pcm_plugin.c: kill dead code
Date: Thu, 24 Mar 2005 00:41:28 +0100
Message-ID: <20050323234128.GF1948@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from mailout.stusta.mhn.de (mailout.stusta.mhn.de [141.84.69.5])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id BD8602A7
	for <alsa-devel@alsa-project.org>; Thu, 24 Mar 2005 00:41:34 +0100 (MET)
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: perex@suse.cz
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The Coverity checker found this obviously dead code.

I'mnot sure which of the if (plugin == NULL) is correct - this patch 
removes the one that couldn't be true.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-rc1-mm1-full/sound/core/oss/pcm_plugin.c.old	2005-03-23 01:06:58.000000000 +0100
+++ linux-2.6.12-rc1-mm1-full/sound/core/oss/pcm_plugin.c	2005-03-23 01:07:41.000000000 +0100
@@ -657,22 +657,19 @@ static int snd_pcm_plug_playback_channel
 	if (plugin == NULL) {
 		return 0;
 	} else {
 		int schannels = plugin->dst_format.channels;
 		bitset_t bs[bitset_size(schannels)];
 		bitset_t *srcmask;
 		bitset_t *dstmask = bs;
 		int err;
 		bitset_one(dstmask, schannels);
-		if (plugin == NULL) {
-			bitset_and(client_vmask, dstmask, schannels);
-			return 0;
-		}
+
 		while (1) {
 			err = plugin->src_channels_mask(plugin, dstmask, &srcmask);
 			if (err < 0)
 				return err;
 			dstmask = srcmask;
 			if (plugin->prev == NULL)
 				break;
 			plugin = plugin->prev;
 		}



-------------------------------------------------------
This SF.net email is sponsored by Microsoft Mobile & Embedded DevCon 2005
Attend MEDC 2005 May 9-12 in Vegas. Learn more about the latest Windows
Embedded(r) & Windows Mobile(tm) platforms, applications & content.  Register
by 3/29 & save $300 http://ads.osdn.com/?ad_id=6883&alloc_id=15149&op=click
