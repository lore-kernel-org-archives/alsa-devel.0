From: domen@coderock.org
Subject: [patch 1/3] delete unused file
Date: Sun, 26 Dec 2004 16:24:58 +0100
Message-ID: <20041226152442.ED8A11ECC0@trashy.coderock.org>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from trashy.coderock.org (coderock.org [193.77.147.115])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 8BA9F191
	for <alsa-devel@alsa-project.org>; Sun, 26 Dec 2004 16:24:49 +0100 (MET)
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
Cc: alsa-devel@alsa-project.org, domen@coderock.org
List-Id: alsa-devel@alsa-project.org


Remove nowhere referenced file. (egrep "filename\." didn't find anything)

Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj/include/sound/soundmem.h |    8 --------
 1 files changed, 8 deletions(-)

diff -L include/sound/soundmem.h -puN include/sound/soundmem.h~remove_file-include_sound_soundmem.h /dev/null
--- kj/include/sound/soundmem.h
+++ /dev/null	2004-12-24 01:21:08.000000000 +0100
@@ -1,8 +0,0 @@
-/*
- *  Onboard memory management
- */
-
-struct SNDRV_STRU_BANK_INFO {
-	unsigned int address;
-	unsigned int size;
-};
_


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
