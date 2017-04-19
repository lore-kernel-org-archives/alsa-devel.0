From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ASoC: Intel: Skylake: fix dereference before
	NULL check on ebus
Date: Wed, 19 Apr 2017 13:16:13 +0100
Message-ID: <20170419121613.12353-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id D599A266AFF
 for <alsa-devel@alsa-project.org>; Wed, 19 Apr 2017 14:16:34 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Vinod Koul <vinod.koul@intel.com>, Jeeja KP <jeeja.kp@intel.com>, Jayachandran B <jayachandran.b@intel.com>, "Subhransu S . Prusty" <subhransu.s.prusty@intel.com>, Dharageswari R <dharageswari.r@intel.com>, Pardha Saradhi K <pardha.saradhi.kesapragada@intel.com>, Yong Zhi <yong.zhi@intel.com>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

ebus is being NULL checked however it is being dereferenced
earlier on the assignment bus = ebus_to_hbus(ebus).  Fix this
by moving the assignment to after the NULL check on ebus to
avoid a NULL pointer dereference error.

Fixes: c5a76a246989c8 ("ASoC: Intel: Skylake: Add shutdown callback")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/intel/skylake/skl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 0c57d4eaae3a..21369f60fbaa 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -818,7 +818,7 @@ static int skl_probe(struct pci_dev *pci,
 static void skl_shutdown(struct pci_dev *pci)
 {
 	struct hdac_ext_bus *ebus = pci_get_drvdata(pci);
-	struct hdac_bus *bus = ebus_to_hbus(ebus);
+	struct hdac_bus *bus;
 	struct hdac_stream *s;
 	struct hdac_ext_stream *stream;
 	struct skl *skl;
@@ -826,6 +826,7 @@ static void skl_shutdown(struct pci_dev *pci)
 	if (ebus == NULL)
 		return;
 
+	bus = ebus_to_hbus(ebus);
 	skl = ebus_to_skl(ebus);
 
 	if (skl->init_failed)
-- 
2.11.0
