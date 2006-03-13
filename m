From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] ALSA-Configuration.txt: snd-hda-intel: document model=basic
Date: Mon, 13 Mar 2006 20:56:44 +0100
Message-ID: <20060313195644.GF13973@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailout.stusta.mhn.de (emailhub.stusta.mhn.de [141.84.69.5])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 06B29178
	for <alsa-devel@alsa-project.org>; Mon, 13 Mar 2006 20:56:44 +0100 (MET)
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
To: Andrew Morton <akpm@osdl.org>
Cc: Takashi Iwai <tiwai@suse.de>, perex@suse.cz, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Document the model=basic option in the snd-hda-intel driver.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

Can I get an ACK for getting this patch into 2.6.16?

This patch was already sent on:
- 4 Mar 2006

--- linux-2.6.16-rc5-mm2-full/Documentation/sound/alsa/ALSA-Configuration.txt.old	2006-03-04 15:52:50.000000000 +0100
+++ linux-2.6.16-rc5-mm2-full/Documentation/sound/alsa/ALSA-Configuration.txt	2006-03-04 15:57:10.000000000 +0100
@@ -705,6 +705,7 @@
 			$CONFIG_SND_DEBUG=y
 
 	ALC260
+	  basic		base mode
 	  hp		HP machines
 	  fujitsu	Fujitsu S7020
 




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
