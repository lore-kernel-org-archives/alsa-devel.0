From: kbuild test robot <fengguang.wu@intel.com>
Subject: [PATCH asoc] ASoC: zx: zx_i2s_dai can be static
Date: Thu, 4 Jun 2015 21:00:50 +0800
Message-ID: <20150604130050.GA216990@lkp-ib03>
References: <201506042120.M9liQXGN%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 221AB26061B
 for <alsa-devel@alsa-project.org>; Thu,  4 Jun 2015 15:01:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201506042120.M9liQXGN%fengguang.wu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jun Nie <jun.nie@linaro.org>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org


Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 zx296702-i2s.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/zte/zx296702-i2s.c b/sound/soc/zte/zx296702-i2s.c
index cf6005c..472fde3 100644
--- a/sound/soc/zte/zx296702-i2s.c
+++ b/sound/soc/zte/zx296702-i2s.c
@@ -355,7 +355,7 @@ static const struct snd_soc_component_driver zx_i2s_component = {
 	.name			= "zx-i2s",
 };
 
-struct snd_soc_dai_driver zx_i2s_dai = {
+static struct snd_soc_dai_driver zx_i2s_dai = {
 	.name	= "zx-i2s-dai",
 	.id	= 0,
 	.probe	= zx_i2s_dai_probe,
