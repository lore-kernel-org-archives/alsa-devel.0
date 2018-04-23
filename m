From: kbuild test robot <lkp@intel.com>
Subject: [RFC PATCH] patch_ca0132.c: ca0132_alt_chmaps[] can be
	static
Date: Mon, 23 Apr 2018 14:57:04 +0800
Message-ID: <20180423065704.GA24064@lkp-ib03>
References: <1524445866-3586-1-git-send-email-conmanx360@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id B83122675CD
 for <alsa-devel@alsa-project.org>; Mon, 23 Apr 2018 08:57:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1524445866-3586-1-git-send-email-conmanx360@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, kbuild-all@01.org, Connor McAdams <conmanx360@gmail.com>
List-Id: alsa-devel@alsa-project.org


Fixes: 9e9ffabacc30 ("patch_ca0132.c: Handle SBZ and R3Di sound cards")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 patch_ca0132.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index ddbb658..707d8ee 100755
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -5684,7 +5684,7 @@ static const char * const ca0132_alt_slave_pfxs[] = {
  * I think this has to do with the pin for rear surround being 0x11,
  * and the center/lfe being 0x10. Usually the pin order is the opposite.
  */
-const struct snd_pcm_chmap_elem ca0132_alt_chmaps[] = {
+static const struct snd_pcm_chmap_elem ca0132_alt_chmaps[] = {
 	{ .channels = 2,
 	  .map = { SNDRV_CHMAP_FL, SNDRV_CHMAP_FR } },
 	{ .channels = 4,
