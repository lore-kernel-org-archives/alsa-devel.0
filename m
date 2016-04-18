From: PC Liao <pc.liao@mediatek.com>
Subject: Re: [PATCH v3] ASoC: mediatek: Add second I2S on mt8173-rt5650
 machine driver
Date: Mon, 18 Apr 2016 19:36:20 +0800
Message-ID: <1460979380.17045.2.camel@mtksdaap41>
References: <1460014517-20359-1-git-send-email-pc.liao@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460014517-20359-1-git-send-email-pc.liao@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "broonie@kernel.org" <broonie@kernel.org>
Cc: "tiwai@suse.de" <tiwai@suse.de>, srv_heupstream <srv_heupstream@mediatek.com>, "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Koro Chen =?UTF-8?Q?=28=E9=99=B3=E6=80=9D=E7=BF=B0=29?= <koro.chen@mediatek.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Thu, 2016-04-07 at 15:35 +0800, PC Liao wrote:
> This patch adds second I2S connection to rt5650 codec for capture path on
> mt8173-rt5650 machine driver.
> 
> Signed-off-by: PC Liao <pc.liao@mediatek.com>
> ---
> Changes since v2:
> Use sound-dai to determine the capture path.
> ---
>  .../devicetree/bindings/sound/mt8173-rt5650.txt    |    6 +++
>  sound/soc/mediatek/mt8173-rt5650.c                 |   42 ++++++++++++++++++--
>  2 files changed, 44 insertions(+), 4 deletions(-)
> 

Could you please give some comments or suggestions?
Thanks!
