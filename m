From: kbuild test robot <fengguang.wu@intel.com>
Subject: [PATCH asoc] ASoC: Intel: read_shim_data() can be static
Date: Tue, 7 Apr 2015 03:06:06 +0800
Message-ID: <20150406190606.GA41498@snb>
References: <201504070339.UuD6nVub%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201504070339.UuD6nVub%fengguang.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jie Yang <yang.jie@intel.com>
Cc: kbuild-all@01.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 sst_pvt.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/atom/sst/sst_pvt.c b/sound/soc/intel/atom/sst/sst_pvt.c
index 3c17844..2d74249 100644
--- a/sound/soc/intel/atom/sst/sst_pvt.c
+++ b/sound/soc/intel/atom/sst/sst_pvt.c
@@ -111,7 +111,7 @@ int sst_wait_interruptible(struct intel_sst_drv *sst_drv_ctx,
 
 }
 
-unsigned long long read_shim_data(struct intel_sst_drv *sst, int addr)
+static unsigned long long read_shim_data(struct intel_sst_drv *sst, int addr)
 {
 	unsigned long long val = 0;
 
@@ -124,7 +124,7 @@ unsigned long long read_shim_data(struct intel_sst_drv *sst, int addr)
 	return val;
 }
 
-void write_shim_data(struct intel_sst_drv *sst, int addr,
+static void write_shim_data(struct intel_sst_drv *sst, int addr,
 				unsigned long long data)
 {
 	switch (sst->dev_id) {
