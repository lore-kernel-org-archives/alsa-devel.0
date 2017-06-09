From: Harsha Priya <harshapriya.n@intel.com>
Subject: [PATCH v3 2/3] ASoC: Intel: Convert all sst_codecs
	data definition to c99 style
Date: Fri,  9 Jun 2017 15:18:53 -0700
Message-ID: <1497046734-31753-3-git-send-email-harshapriya.n@intel.com>
References: <1497046734-31753-1-git-send-email-harshapriya.n@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 108C62676F0
 for <alsa-devel@alsa-project.org>; Sat, 10 Jun 2017 00:19:03 +0200 (CEST)
In-Reply-To: <1497046734-31753-1-git-send-email-harshapriya.n@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, vinod.koul@intel.com, broonie@kernel.org, alsa-devel@alsa-project.org
Cc: Harsha Priya <harshapriya.n@intel.com>, Naveen M <naveen.m@intel.com>
List-Id: alsa-devel@alsa-project.org

C99 style struct initialization helps in readability as well as
initialization of variables not specified as NULL. This patch
changes the struct data definitions in skl.c that were not in c99 style.

Signed-off-by: Harsha Priya <harshapriya.n@intel.com>
Signed-off-by: Naveen M <naveen.m@intel.com>
---
 sound/soc/intel/skylake/skl.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 4ebae85..6a79fc7 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -876,10 +876,25 @@ static void skl_remove(struct pci_dev *pci)
 	dev_set_drvdata(&pci->dev, NULL);
 }
 
-static struct sst_codecs skl_codecs = { 1, {"NAU88L25"} };
-static struct sst_codecs kbl_codecs = { 1, {"NAU88L25"} };
-static struct sst_codecs bxt_codecs = { 1, {"MX98357A"} };
-static struct sst_codecs kbl_poppy_codecs = { 1, {"10EC5663"} };
+static struct sst_codecs skl_codecs = {
+	.num_codecs = 1,
+	.codecs = {"NAU88L25"}
+};
+
+static struct sst_codecs kbl_codecs = {
+	.num_codecs = 1,
+	.codecs = {"NAU88L25"}
+};
+
+static struct sst_codecs bxt_codecs = {
+	.num_codecs = 1,
+	.codecs = {"MX98357A"}
+};
+
+static struct sst_codecs kbl_poppy_codecs = {
+	.num_codecs = 1,
+	.codecs = {"10EC5663"}
+};
 
 static struct sst_acpi_mach sst_skl_devdata[] = {
 	{
-- 
1.9.1
