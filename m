From: kbuild test robot <lkp@intel.com>
Subject: [RFC PATCH] sound, media: array_find() can be static
Date: Mon, 23 Apr 2018 02:05:03 +0800
Message-ID: <20180422180503.GA27818@lkp-sb04.lkp.intel.com>
References: <3f4d8ae83a91c765581d9cbbd1e436b6871368fa.1524227382.git.mchehab@s-opensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 03A16267281
 for <alsa-devel@alsa-project.org>; Sun, 22 Apr 2018 20:05:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <3f4d8ae83a91c765581d9cbbd1e436b6871368fa.1524227382.git.mchehab@s-opensource.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Mauro Carvalho Chehab <mchehab@s-opensource.com>, kbuild-all@01.org, Mauro Carvalho Chehab <mchehab@infradead.org>, Linux Media Mailing List <linux-media@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


Fixes: dbd775375e7d ("sound, media: allow building ISA drivers it with COMPILE_TEST")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 cmi8328.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/isa/cmi8328.c b/sound/isa/cmi8328.c
index d09e456..de6ef1b 100644
--- a/sound/isa/cmi8328.c
+++ b/sound/isa/cmi8328.c
@@ -192,7 +192,7 @@ static int snd_cmi8328_mixer(struct snd_wss *chip)
 }
 
 /* find index of an item in "-1"-ended array */
-int array_find(int array[], int item)
+static int array_find(int array[], int item)
 {
 	int i;
 
@@ -203,7 +203,7 @@ int array_find(int array[], int item)
 	return -1;
 }
 /* the same for long */
-int array_find_l(long array[], long item)
+static int array_find_l(long array[], long item)
 {
 	int i;
 
