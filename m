From: Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 1/7 linux-next] ALSA: aoa: constify
	of_device_id array
Date: Wed, 18 Mar 2015 17:48:56 +0100
Message-ID: <1426697344-4884-2-git-send-email-fabf@skynet.be>
References: <1426697344-4884-1-git-send-email-fabf@skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailrelay106.isp.belgacom.be (mailrelay106.isp.belgacom.be
 [195.238.20.133])
 by alsa0.perex.cz (Postfix) with ESMTP id C03D92604AA
 for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2015 17:49:22 +0100 (CET)
In-Reply-To: <1426697344-4884-1-git-send-email-fabf@skynet.be>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Fabian Frederick <fabf@skynet.be>, Johannes Berg <johannes@sipsolutions.net>, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

of_device_id is always used as const.
(See driver.of_match_table and open firmware functions)

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 sound/aoa/soundbus/i2sbus/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/aoa/soundbus/i2sbus/core.c b/sound/aoa/soundbus/i2sbus/core.c
index b9737fa..1cbf210 100644
--- a/sound/aoa/soundbus/i2sbus/core.c
+++ b/sound/aoa/soundbus/i2sbus/core.c
@@ -31,7 +31,7 @@ module_param(force, int, 0444);
 MODULE_PARM_DESC(force, "Force loading i2sbus even when"
 			" no layout-id property is present");
 
-static struct of_device_id i2sbus_match[] = {
+static const struct of_device_id i2sbus_match[] = {
 	{ .name = "i2s" },
 	{ }
 };
-- 
1.9.1
