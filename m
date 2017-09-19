From: jeffy <jeffy.chen@rock-chips.com>
Subject: Re: [PATCH v12 2/2] ASoC: rockchip: Use bus_type to
 distinguish rt5514 dsp from rt5514 codec
Date: Tue, 19 Sep 2017 21:04:26 +0800
Message-ID: <59C115DA.4000907@rock-chips.com>
References: <20170919025439.7107-1-jeffy.chen@rock-chips.com>
 <20170919025439.7107-2-jeffy.chen@rock-chips.com>
 <20170919124613.egvojfhq74vhyvuh@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from regular1.263xmail.com (regular1.263xmail.com [211.150.99.130])
 by alsa0.perex.cz (Postfix) with ESMTP id BED3F266F0D
 for <alsa-devel@alsa-project.org>; Tue, 19 Sep 2017 15:04:34 +0200 (CEST)
In-Reply-To: <20170919124613.egvojfhq74vhyvuh@sirena.co.uk>
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
Cc: alsa-devel@alsa-project.org, heiko@sntech.de, Liam Girdwood <lgirdwood@gmail.com>, briannorris@chromium.org, dianders@chromium.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, mka@chromium.org, Takashi Iwai <tiwai@suse.com>, dgreid@chromium.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On 09/19/2017 08:46 PM, Mark Brown wrote:
> On Tue, Sep 19, 2017 at 10:54:39AM +0800, Jeffy Chen wrote:
>> Currently rt5514 dsp and rt5514 codec are sharing the same compatible.
>> Use bus_type to distinguish rt5514 dsp from rt5514 codec.
>
> This doens't apply against current code, please check and resend.
>

i sent a new series which contains all my patches and base on 
840cc455c5f5 Add linux-next specific files for 20170919

please help to check, thanks :)

https://py3.patchwork.dja.id.au/patch/66384/
...
https://py3.patchwork.dja.id.au/patch/66389/
