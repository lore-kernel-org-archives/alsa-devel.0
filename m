From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 4/7] mfd: ab8500-core: Apply the AB8500 CODEC's
	compatible string to its MFD cell
Date: Fri, 27 Jul 2012 13:38:51 +0100
Message-ID: <1343392734-11805-5-git-send-email-lee.jones@linaro.org>
References: <1343392734-11805-1-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f173.google.com (mail-wi0-f173.google.com
 [209.85.212.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 4D4D0264F8F
 for <alsa-devel@alsa-project.org>; Fri, 27 Jul 2012 14:39:06 +0200 (CEST)
Received: by wibhm6 with SMTP id hm6so5658000wib.2
 for <alsa-devel@alsa-project.org>; Fri, 27 Jul 2012 05:39:08 -0700 (PDT)
In-Reply-To: <1343392734-11805-1-git-send-email-lee.jones@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: ola.o.lilja@stericsson.com, alsa-devel@alsa-project.org, sameo@linux.intel.com, arnd@arndb.de, broonie@opensource.wolfsonmicro.com, olalilja@yahoo.se, STEricsson_nomadik_linux@list.st.com, Lee Jones <lee.jones@linaro.org>, lrg@ti.com, linus.walleij@stericsson.com
List-Id: alsa-devel@alsa-project.org

Provide a compatible string for the AB8500 CODEC to aid in
configuration property look-up from its associated Device Tree
node.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/ab8500-core.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
index 626b4ec..0c5b70f 100644
--- a/drivers/mfd/ab8500-core.c
+++ b/drivers/mfd/ab8500-core.c
@@ -1076,6 +1076,7 @@ static struct mfd_cell __devinitdata ab8500_devs[] = {
 	},
 	{
 		.name = "ab8500-codec",
+		.of_compatible = "stericsson,ab8500-codec",
 	},
 };
 
-- 
1.7.9.5
