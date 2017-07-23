From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 1/4] ASoC: rt5514: constify acpi_device_id.
Date: Sun, 23 Jul 2017 22:53:24 +0530
Message-ID: <1500830607-17268-2-git-send-email-arvind.yadav.cs@gmail.com>
References: <1500830607-17268-1-git-send-email-arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f196.google.com (mail-pf0-f196.google.com
 [209.85.192.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 9324D2664EB
 for <alsa-devel@alsa-project.org>; Sun, 23 Jul 2017 19:24:35 +0200 (CEST)
Received: by mail-pf0-f196.google.com with SMTP id c23so8719664pfe.5
 for <alsa-devel@alsa-project.org>; Sun, 23 Jul 2017 10:24:35 -0700 (PDT)
In-Reply-To: <1500830607-17268-1-git-send-email-arvind.yadav.cs@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: bardliao@realtek.com, oder_chiou@realtek.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

acpi_device_id are not supposed to change at runtime. All functions
working with acpi_device_id provided by <acpi/acpi_bus.h> work with
const acpi_device_id. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 sound/soc/codecs/rt5514.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5514.c b/sound/soc/codecs/rt5514.c
index 1b6796c..a7c071e 100644
--- a/sound/soc/codecs/rt5514.c
+++ b/sound/soc/codecs/rt5514.c
@@ -1097,7 +1097,7 @@ MODULE_DEVICE_TABLE(of, rt5514_of_match);
 #endif
 
 #ifdef CONFIG_ACPI
-static struct acpi_device_id rt5514_acpi_match[] = {
+static const struct acpi_device_id rt5514_acpi_match[] = {
 	{ "10EC5514", 0},
 	{},
 };
-- 
2.7.4
