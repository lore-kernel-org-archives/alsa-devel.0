From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: wm8991: Fix wrong bit setting for
 WM8991_POWER_MANAGEMENT_2
Date: Fri, 14 Oct 2011 20:36:20 +0100
Message-ID: <20111014193619.GJ2931@opensource.wolfsonmicro.com>
References: <1318565280.10049.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1318565280.10049.1.camel@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Graeme Gregory <gg@opensource.wolfsonmicro.com>, Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 14, 2011 at 12:08:00PM +0800, Axel Lin wrote:
> If (fakepower & ((1 << WM8991_INMIXR_PWR_BIT)|(1 << WM8991_AINRMUX_PWR_BIT))))
> is false, we should clear WM8991_AINR_ENA bits instead of WM8991_AINL_ENA.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Applied both, thanks.
