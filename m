From: domen@coderock.org
Subject: [patch 1/2] gus_wave.c - vfree() checking cleanups
Date: Mon, 10 Jan 2005 19:36:35 +0100
Message-ID: <20050110183635.D3FC21F1ED@trashy.coderock.org>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from trashy.coderock.org (coderock.org [193.77.147.115])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 2EB5C2B3
	for <alsa-devel@alsa-project.org>; Mon, 10 Jan 2005 19:36:41 +0100 (MET)
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
Cc: alsa-devel@alsa-project.org, domen@coderock.org, jlamanna@gmail.com
List-Id: alsa-devel@alsa-project.org



gus_wave.c vfree() checking cleanups.

Signed-off by: James Lamanna <jlamanna@gmail.com>


Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/sound/oss/gus_wave.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

diff -puN sound/oss/gus_wave.c~vfree-sound_oss_gus_wave sound/oss/gus_wave.c
--- kj/sound/oss/gus_wave.c~vfree-sound_oss_gus_wave	2005-01-10 18:01:07.000000000 +0100
+++ kj-domen/sound/oss/gus_wave.c	2005-01-10 18:01:07.000000000 +0100
@@ -3126,8 +3126,7 @@ void __exit gus_wave_unload(struct addre
 	if (hw_config->slots[5] != -1)
 		sound_unload_mixerdev(hw_config->slots[5]);
 	
-	if(samples)
-		vfree(samples);
+	vfree(samples);
 	samples=NULL;
 }
 /* called in interrupt context */
_


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
