From: Olaf Hering <olaf@aepfle.de>
Subject: [PATCH] create driver symlink in snd-aoa
Date: Sat, 2 Dec 2006 11:14:46 +0100 (MET)
Message-ID: <20061202101445.GA15619@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mo-p07-ob.rzone.de (mo-p07-ob.rzone.de [81.169.146.189])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id EF85825C
	for <alsa-devel@alsa-project.org>; Sat,  2 Dec 2006 11:14:46 +0100 (MET)
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
To: Andrew Morton <akpm@osdl.org>, alsa-devel@alsa-project.org, johannes@sipsolutions.net
List-Id: alsa-devel@alsa-project.org


create sysfs driver symlink for snd-aoa in /sys/bus/aoa-soundbus/devices/*/

Signed-off-by: Olaf Hering <olaf@aepfle.de>

---
 sound/aoa/fabrics/snd-aoa-fabric-layout.c |    3 +++
 1 file changed, 3 insertions(+)

Index: linux-2.6/sound/aoa/fabrics/snd-aoa-fabric-layout.c
===================================================================
--- linux-2.6.orig/sound/aoa/fabrics/snd-aoa-fabric-layout.c
+++ linux-2.6/sound/aoa/fabrics/snd-aoa-fabric-layout.c
@@ -1107,6 +1107,9 @@ static struct soundbus_driver aoa_soundb
 	.suspend = aoa_fabric_layout_suspend,
 	.resume = aoa_fabric_layout_resume,
 #endif
+	.driver = {
+		.owner = THIS_MODULE,
+	}
 };
 
 static int __init aoa_fabric_layout_init(void)

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
