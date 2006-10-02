From: Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH] sound/usb/usbaudio: Handle return value of
	usb_register()
Date: Mon, 2 Oct 2006 12:52:59 +0200
Message-ID: <20061002105259.GA12070@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sym.noone.org (symlink.to.noone.org [85.10.207.172])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D73CC21C
	for <alsa-devel@alsa-project.org>;
	Mon,  2 Oct 2006 12:53:05 +0200 (MEST)
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: kernel-janitors@lists.osdl.org
Cc: akpm@osdl.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Handle the return value of usb_register() in the module_init function.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>

---
 sound/usb/usbaudio.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/sound/usb/usbaudio.c b/sound/usb/usbaudio.c
index a42acf6..191c811 100644
--- a/sound/usb/usbaudio.c
+++ b/sound/usb/usbaudio.c
@@ -3576,8 +3576,7 @@ static int __init snd_usb_audio_init(voi
 		printk(KERN_WARNING "invalid nrpacks value.\n");
 		return -EINVAL;
 	}
-	usb_register(&usb_audio_driver);
-	return 0;
+	return usb_register(&usb_audio_driver);
 }
 
 
-- 
1.4.2


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
