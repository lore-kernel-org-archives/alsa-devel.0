From: Hugo Villeneuve <hugo@hugovil.com>
Subject: [PATCH 1/1] ALSA: ASoC: DaVinci: Fix SFFSDR init bug.
Date: Thu, 15 Jan 2009 15:39:52 -0500
Message-ID: <1232051992-31817-1-git-send-email-hugo@hugovil.com>
References: <20090108121613.1ef53112.hugo@hugovil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.hugovil.com (201-217-static-ppp.3menatwork.com
	[64.235.217.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 8441B10388B
	for <alsa-devel@alsa-project.org>; Thu, 15 Jan 2009 21:39:49 +0100 (CET)
In-Reply-To: <20090108121613.1ef53112.hugo@hugovil.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org

Removed call to machine_is_sffsdr() in module init
function because it always returns zero and causes
GCC to optimise and remove all functions of the module.

Signed-off-by: Hugo Villeneuve <hugo@hugovil.com>
---
 sound/soc/davinci/davinci-sffsdr.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/sound/soc/davinci/davinci-sffsdr.c b/sound/soc/davinci/davinci-sffsdr.c
index 1bbde3e..3e8e6cd 100644
--- a/sound/soc/davinci/davinci-sffsdr.c
+++ b/sound/soc/davinci/davinci-sffsdr.c
@@ -115,9 +115,6 @@ static int __init sffsdr_init(void)
 {
 	int ret;
 
-	if (!machine_is_sffsdr())
-		return -EINVAL;
-
 	sffsdr_snd_device = platform_device_alloc("soc-audio", 0);
 	if (!sffsdr_snd_device) {
 		printk(KERN_ERR "platform device allocation failed\n");
-- 
1.5.4.5
