From: kbuild test robot <lkp@intel.com>
Subject: [RFC PATCH] ASOC: sunxi: sun4i_snd_txctrl_on() can be static
Date: Thu, 1 Oct 2015 02:52:46 +0800
Message-ID: <20150930185246.GA82847@lkp-hsx03>
References: <201510010231.FvvWaROC%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1443635458-8873-5-git-send-email-codekipper@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: kbuild-all@01.org, maxime.ripard@free-electrons.com, lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org, broonie@kernel.org, linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, be17068@iperbole.bo.it, Marcus Cooper <codekipper@gmail.com>
List-Id: alsa-devel@alsa-project.org


Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 sun4i-spdif.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-spdif.c b/sound/soc/sunxi/sun4i-spdif.c
index 5fff6f6..cf0ed80 100644
--- a/sound/soc/sunxi/sun4i-spdif.c
+++ b/sound/soc/sunxi/sun4i-spdif.c
@@ -204,7 +204,7 @@ static void sun4i_spdif_configure(struct sun4i_spdif_dev *host)
 
 }
 
-void sun4i_snd_txctrl_on(struct snd_pcm_substream *substream,
+static void sun4i_snd_txctrl_on(struct snd_pcm_substream *substream,
 				struct sun4i_spdif_dev *host)
 {
 	if (substream->runtime->channels == 1)
@@ -228,7 +228,7 @@ void sun4i_snd_txctrl_on(struct snd_pcm_substream *substream,
 					SUN4I_SPDIF_CTL_GEN);
 }
 
-void sun4i_snd_txctrl_off(struct snd_pcm_substream *substream,
+static void sun4i_snd_txctrl_off(struct snd_pcm_substream *substream,
 				struct sun4i_spdif_dev *host)
 {
 	/* SPDIF TX DISABLE */
