From: Mathias Krause <minipli@googlemail.com>
Subject: [PATCH 4/4] ASoC: intel: Constify ACPI device ids
Date: Sat, 13 Jun 2015 14:25:16 +0200
Message-ID: <1434198316-8400-5-git-send-email-minipli@googlemail.com>
References: <1434198316-8400-1-git-send-email-minipli@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f182.google.com (mail-wi0-f182.google.com
 [209.85.212.182])
 by alsa0.perex.cz (Postfix) with ESMTP id C015526058D
 for <alsa-devel@alsa-project.org>; Sat, 13 Jun 2015 14:25:31 +0200 (CEST)
Received: by wibdq8 with SMTP id dq8so37078714wib.1
 for <alsa-devel@alsa-project.org>; Sat, 13 Jun 2015 05:25:31 -0700 (PDT)
In-Reply-To: <1434198316-8400-1-git-send-email-minipli@googlemail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, alsa-devel@alsa-project.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mathias Krause <minipli@googlemail.com>, Len Brown <lenb@kernel.org>
List-Id: alsa-devel@alsa-project.org

Constify the ACPI device ID array, it doesn't need to be writable at
runtime.

Signed-off-by: Mathias Krause <minipli@googlemail.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 sound/soc/intel/common/sst-acpi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/common/sst-acpi.c b/sound/soc/intel/common/sst-acpi.c
index 42f293f9c6e2..67b6d3d52f57 100644
--- a/sound/soc/intel/common/sst-acpi.c
+++ b/sound/soc/intel/common/sst-acpi.c
@@ -263,7 +263,7 @@ static struct sst_acpi_desc sst_acpi_baytrail_desc = {
 	.resindex_dma_base = -1,
 };
 
-static struct acpi_device_id sst_acpi_match[] = {
+static const struct acpi_device_id sst_acpi_match[] = {
 	{ "INT33C8", (unsigned long)&sst_acpi_haswell_desc },
 	{ "INT3438", (unsigned long)&sst_acpi_broadwell_desc },
 	{ "80860F28", (unsigned long)&sst_acpi_baytrail_desc },
-- 
1.7.10.4
