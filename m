From: domen@coderock.org
Subject: [patch 2/2] pss.c - vfree() checking cleanups
Date: Mon, 10 Jan 2005 19:36:38 +0100
Message-ID: <20050110183638.D302D1F208@trashy.coderock.org>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from trashy.coderock.org (coderock.org [193.77.147.115])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id EF7802B3
	for <alsa-devel@alsa-project.org>; Mon, 10 Jan 2005 19:36:42 +0100 (MET)
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



pss.c vfree() checking cleanups.

Signed-off by: James Lamanna <jlamanna@gmail.com>


Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/sound/oss/pss.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN sound/oss/pss.c~vfree-sound_oss_pss sound/oss/pss.c
--- kj/sound/oss/pss.c~vfree-sound_oss_pss	2005-01-10 18:01:08.000000000 +0100
+++ kj-domen/sound/oss/pss.c	2005-01-10 18:01:08.000000000 +0100
@@ -1242,7 +1242,7 @@ static void __exit cleanup_pss(void)
 {
 	if(!pss_no_sound)
 	{
-		if(fw_load && pss_synth)
+		if(fw_load)
 			vfree(pss_synth);
 		if(pssmss)
 			unload_pss_mss(&cfg2);
_


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
