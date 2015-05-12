From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel][PATCH 3/4] ASoC: wm8960: fix "RINPUT3" audio
	route error
Date: Tue, 12 May 2015 11:42:13 +0100
Message-ID: <20150512104213.GF3480@opensource.wolfsonmicro.com>
References: <c36ecb00aeb3115e208518c5e256f35f7b1308db.1431413323.git.zidan.wang@freescale.com> <d92199aca689cbb075bb3d0a4a9d8f54e5e61909.1431413323.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d92199aca689cbb075bb3d0a4a9d8f54e5e61909.1431413323.git.zidan.wang@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zidan Wang <zidan.wang@freescale.com>
Cc: tiwai@suse.de, broonie@kernel.org, lgirdwood@gmail.com, lars@metafoo.de, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, May 12, 2015 at 02:58:36PM +0800, Zidan Wang wrote:
> It should be "RINPUT3" instead of "LINPUT3" route to "Right Input
> Mixer".
> 
> Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Better to put bug fixes like this at the start of a series if
possible.

Thanks,
Charles
