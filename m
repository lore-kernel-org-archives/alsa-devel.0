From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] ASoC: rockchip: add bindings for spdif
	controller
Date: Fri, 4 Mar 2016 22:30:35 -0600
Message-ID: <20160305043035.GF13525@rob-hp-laptop>
References: <1457087514-1837-1-git-send-email-sugar.zhang@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 by alsa0.perex.cz (Postfix) with ESMTP id 5D53F2605CA
 for <alsa-devel@alsa-project.org>; Sat,  5 Mar 2016 05:30:44 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1457087514-1837-1-git-send-email-sugar.zhang@rock-chips.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sugar Zhang <sugar.zhang@rock-chips.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, heiko@sntech.de, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-rockchip@lists.infradead.org, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, broonie@kernel.org, Kumar Gala <galak@codeaurora.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 04, 2016 at 06:31:54PM +0800, Sugar Zhang wrote:
> this patch add compatible for rk3366/rk3368/rk3399 spdif,
> these three spdifs share the same type.
> 
> Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
> ---
> 
>  Documentation/devicetree/bindings/sound/rockchip-spdif.txt |  8 ++++++--
>  sound/soc/rockchip/rockchip_spdif.c                        | 13 ++++++++++---
>  2 files changed, 16 insertions(+), 5 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
