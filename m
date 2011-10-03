From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Remove needless  codec->dapm.bias_level assignment
 to SND_SOC_BIAS_OFF
Date: Mon, 3 Oct 2011 14:16:48 +0100
Message-ID: <20111003131647.GK3731@opensource.wolfsonmicro.com>
References: <1317644236.2724.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1317644236.2724.1.camel@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Vinod Koul <vinod.koul@linux.intel.com>, Harsha Priya <priya.harsha@intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 03, 2011 at 08:17:16PM +0800, Axel Lin wrote:
> This assignment is done by the snd_soc_register_codec so there is no need
> to redo it in probe function of a codec driver.

Applied, thanks.
