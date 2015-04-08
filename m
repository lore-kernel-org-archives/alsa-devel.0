From: Kever Yang <kever.yang@rock-chips.com>
Subject: Re: [PATCH v2] ASoC: max98090: add shutdown callback
	for max98090
Date: Wed, 08 Apr 2015 18:51:32 +0800
Message-ID: <55250834.8040208@rock-chips.com>
References: <1428488311-27237-1-git-send-email-wxt@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from regular1.263xmail.com (regular1.263xmail.com [211.150.99.140])
 by alsa0.perex.cz (Postfix) with ESMTP id 54DA2265268
 for <alsa-devel@alsa-project.org>; Wed,  8 Apr 2015 12:51:38 +0200 (CEST)
In-Reply-To: <1428488311-27237-1-git-send-email-wxt@rock-chips.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Caesar Wang <wxt@rock-chips.com>, Sonny Rao <sonnyrao@chromium.org>, Cheng-Yi Chiang <cychiang@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Mark Brown <broonie@kernel.org>, zhengxing <zhengxing@rock-chips.com>, "jay.xu" <xjq@rock-chips.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Takashi Iwai <tiwai@suse.de>, Tushar Behera <tushar.b@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Dylan Reid <dgreid@chromium.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hi Caesar,

On 04/08/2015 06:18 PM, Caesar Wang wrote:
> To fix pop noise when shutdown,the pop noise during shutdown
> is the pmic cutoff power of codec without any notice.
>
> Signed-off-by: jay.xu <xjq@rock-chips.com>
> Signed-off-by: zhengxing <zhengxing@rock-chips.com>
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
>
> Serien-cc: linux-kernel@vger.kernel.org
> Serien-cc: devicetree@vger.kernel.org
> Serien-cc: dianders@chromium.org
Typo? Should be "Series-cc" here I guess.

Thanks,
- Kever
