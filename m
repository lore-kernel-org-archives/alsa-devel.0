From: jeffy <jeffy.chen@rock-chips.com>
Subject: Re: [PATCH v5 1/9] ASoC: rockchip: Remove obsolete
	dmic-delay
Date: Tue, 22 Aug 2017 19:01:52 +0800
Message-ID: <599C0F20.7080807@rock-chips.com>
References: <20170822075729.8438-1-jeffy.chen@rock-chips.com>
 <20170822075729.8438-2-jeffy.chen@rock-chips.com>
 <20170822103241.wjiycavsro7abknj@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from regular1.263xmail.com (regular1.263xmail.com [211.150.99.130])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D53A267578
 for <alsa-devel@alsa-project.org>; Tue, 22 Aug 2017 13:01:59 +0200 (CEST)
In-Reply-To: <20170822103241.wjiycavsro7abknj@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, mengdong.lin@linux.intel.com, heiko@sntech.de, Liam Girdwood <lgirdwood@gmail.com>, Oder Chiou <oder_chiou@realtek.com>, briannorris@chromium.org, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, dianders@chromium.org, linux-rockchip@lists.infradead.org, mka@chromium.org, Takashi Iwai <tiwai@suse.com>, dgreid@chromium.org, lars@metafoo.de, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On 08/22/2017 06:32 PM, Mark Brown wrote:
> On Tue, Aug 22, 2017 at 03:57:20PM +0800, Jeffy Chen wrote:
>> This property is no longer used.
>
> I would still rather keep the existing property documented (the binding
> does need to be fixed) than remove it.  It's better practice and it's
> not costing a huge amount.
>

sorry, i should explain more in the commit msg...

just to clarify, this property is replaced by 
"realtek,dmic-init-delay-ms" in rt5514 driver:

a5461fd6c8f7 ASoC: rt5514: Add the DMIC initial delay to wait it ready.

which does exactly the same thing as the old one: perform a delay after 
set clk...

i can do that if you still insist to keep it, since it's harmless :)
