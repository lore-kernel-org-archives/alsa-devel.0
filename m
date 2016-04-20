From: PC Liao <pc.liao@mediatek.com>
Subject: Re: [PATCH 2/2 v6] ASoC: mediatek: Add second I2S on
 mt8173-rt5650 machine driver
Date: Thu, 21 Apr 2016 00:27:44 +0800
Message-ID: <1461169664.8479.1.camel@mtksdaap41>
References: <1461134447-42001-1-git-send-email-pc.liao@mediatek.com>
 <1461134447-42001-3-git-send-email-pc.liao@mediatek.com>
 <57178482.9090705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by alsa0.perex.cz (Postfix) with ESMTP id E2C0A2665CD
 for <alsa-devel@alsa-project.org>; Wed, 20 Apr 2016 18:27:48 +0200 (CEST)
In-Reply-To: <57178482.9090705@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, srv_heupstream <srv_heupstream@mediatek.com>, "tiwai@suse.de" <tiwai@suse.de>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Koro Chen =?UTF-8?Q?=28=E9=99=B3=E6=80=9D=E7=BF=B0=29?= <koro.chen@mediatek.com>, "broonie@kernel.org" <broonie@kernel.org>, "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

Hi Matthias,

On Wed, 2016-04-20 at 21:30 +0800, Matthias Brugger wrote:
> 
> For compatibility you should change this to something like:
> 
>     dev_warn(card->dev, "Only one dai codec found in DTS, enabled rt5645
>                          AD filter\n");
>     rt5645_sel_asrc_clk_src(codec, RT5645_AD_STEREO_FILTER,
>                                    RT5645_CLK_SEL_I2S1_ASRC);
> }
> 

I will use this in next version.
Thanks!
