From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: [Ubuntu PATCH] sound/pci/: Add hp_only quirk for Dell
	D800 laptops
Date: Wed, 14 Jun 2006 16:23:21 -0700
Message-ID: <44909A69.2070407@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from agminet01.oracle.com (agminet01.oracle.com [141.146.126.228])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 99F9219F
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Jun 2006 00:22:45 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: lkml <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org
Cc: akpm <akpm@osdl.org>, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

From: crimsun@fungus.sh.nu <crimsun@fungus.sh.nu>

[UBUNTU:sound/pci/] Add hp_only quirk for Dell D800 laptops

UpstreamStatus: Not merged
http://www.kernel.org/git/?p=linux/kernel/git/bcollins/ubuntu-dapper.git;a=commitdiff;h=9ad787cd9670c3f3b8f3db235e84baf00a2ea526

Anders Ostling comments in Malone #41015 that his Dell D800 laptop's
volume control works correctly when the hp_only quirk is passed to
modprobe. This commit adds his hardware's sub{vendor,device} ids to
the quirk list for the intel8x0 driver.

Signed-off-by: Daniel T Chen <crimsun@ubuntu.com>
Signed-off-by: Ben Collins <bcollins@ubuntu.com>
---

--- a/sound/pci/intel8x0.c
+++ b/sound/pci/intel8x0.c
@@ -1758,6 +1758,12 @@ static struct ac97_quirk ac97_quirks[] _
 	},
 	{
 		.subvendor = 0x1028,
+		.subdevice = 0x014e,
+		.name = "Dell D800", /* STAC9750/51 */
+		.type = AC97_TUNE_HP_ONLY
+	},
+	{
+		.subvendor = 0x1028,
 		.subdevice = 0x0163,
 		.name = "Dell Unknown",	/* STAC9750/51 */
 		.type = AC97_TUNE_HP_ONLY
