From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Subject: [PATCH] sound: aoa of_node_put and kfree cleanup
Date: Tue, 2 Jan 2007 13:50:57 +0100
Message-ID: <200701021350.57816.m.kozlowski__42334.9246535965$1167742478$gmane$org@tuxland.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from tuxland.pl (xdsl-664.zgora.dialog.net.pl [81.168.226.152])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CA49E121
	for <alsa-devel@alsa-project.org>; Tue,  2 Jan 2007 13:49:34 +0100 (MET)
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
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hello,

	This patch removes redundant argument checks for of_node_put() and kfree().

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 sound/aoa/fabrics/snd-aoa-fabric-layout.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -upr linux-2.6.20-rc2-mm1-a/sound/aoa/fabrics/snd-aoa-fabric-layout.c linux-2.6.20-rc2-mm1-b/sound/aoa/fabrics/snd-aoa-fabric-layout.c
--- linux-2.6.20-rc2-mm1-a/sound/aoa/fabrics/snd-aoa-fabric-layout.c	2006-12-28 12:57:54.000000000 +0100
+++ linux-2.6.20-rc2-mm1-b/sound/aoa/fabrics/snd-aoa-fabric-layout.c	2007-01-02 01:50:26.000000000 +0100
@@ -1034,9 +1034,9 @@ static int aoa_fabric_layout_probe(struc
 	list_del(&ldev->list);
 	layouts_list_items--;
  outnodev:
- 	if (sound) of_node_put(sound);
+ 	of_node_put(sound);
  	layout_device = NULL;
- 	if (ldev) kfree(ldev);
+ 	kfree(ldev);
 	return -ENODEV;
 }
 


-- 
Regards,

	Mariusz Kozlowski

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
