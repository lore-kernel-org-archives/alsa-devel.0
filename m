From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 08/37] drivers/watchdog: use .dev.of_node
	instead of .node in	struct of_device
Date: Thu, 11 Mar 2010 11:04:32 -0700
Message-ID: <20100311180431.4824.39881.stgit__2262.03384013406$1268330817$gmane$org@angua>
References: <20100311174830.4824.19820.stgit@angua>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 202D31039F5
	for <alsa-devel@alsa-project.org>; Thu, 11 Mar 2010 19:04:34 +0100 (CET)
Received: by mail-pw0-f51.google.com with SMTP id 10so154935pwj.38
	for <alsa-devel@alsa-project.org>; Thu, 11 Mar 2010 10:04:34 -0800 (PST)
In-Reply-To: <20100311174830.4824.19820.stgit@angua>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: monstr@monstr.eu, gregkh@suse.de, benh@kernel.crashing.org, akpm@linux-foundation.org, davem@davemloft.net, sfr@canb.auug.org.au, jgarzik@pobox.com, ben-linux@fluff.org, dwmw2@infrade
List-Id: alsa-devel@alsa-project.org

.node is being removed

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 drivers/watchdog/cpwd.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/watchdog/cpwd.c b/drivers/watchdog/cpwd.c
index 37ea052..89da14f 100644
--- a/drivers/watchdog/cpwd.c
+++ b/drivers/watchdog/cpwd.c
@@ -576,7 +576,7 @@ static int __devinit cpwd_probe(struct of_device *op,
 	 * interrupt_mask register cannot be written, so no timer
 	 * interrupts can be masked within the PLD.
 	 */
-	str_prop = of_get_property(op->node, "model", NULL);
+	str_prop = of_get_property(op->dev.of_node, "model", NULL);
 	p->broken = (str_prop && !strcmp(str_prop, WD_BADMODEL));
 
 	if (!p->enabled)
