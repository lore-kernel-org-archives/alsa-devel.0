From: "John W. Linville" <linville@tuxdriver.com>
Subject: [patch] snd-intel8x0: ac97 quirk entries for HP xw6200 & xw8000
Date: Wed, 5 Jan 2005 10:40:45 -0500
Message-ID: <20050105154043.GB28626@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from ra.tuxdriver.com (ra.tuxdriver.com [24.172.12.4])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id B887320A
	for <alsa-devel@alsa-project.org>; Wed,  5 Jan 2005 16:39:53 +0100 (MET)
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
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Add AC97 quick list entries to snd-intel8x0 for HP xw6200 and xw8000.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 sound/pci/intel8x0.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletion(-)

--- ac97_quirk/sound/pci/intel8x0.c.orig	2005-01-04 16:42:48.978078335 -0500
+++ ac97_quirk/sound/pci/intel8x0.c	2005-01-04 16:46:40.698137218 -0500
@@ -1756,7 +1756,13 @@
 	{	/* FIXME: which codec? */
 		.vendor = 0x103c,
 		.device = 0x00c3,
-		.name = "Hewlett-Packard onboard",
+		.name = "HP xw6000",
+		.type = AC97_TUNE_HP_ONLY
+	},
+	{
+		.vendor = 0x103c,
+		.device = 0x129d,
+		.name = "HP xw8000",
 		.type = AC97_TUNE_HP_ONLY
 	},
 	{
@@ -1767,6 +1773,12 @@
 	},
 	{
 		.vendor = 0x103c,
+		.device = 0x12f2,
+		.name = "HP xw6200",
+		.type = AC97_TUNE_HP_ONLY
+	},
+	{
+		.vendor = 0x103c,
 		.device = 0x3008,
 		.name = "HP xw4200",	/* AD1981B*/
 		.type = AC97_TUNE_HP_ONLY


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
