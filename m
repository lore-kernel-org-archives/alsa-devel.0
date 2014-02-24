From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH 0/7] ASoC: Intel: Add support for Baytrail
	SST DSP
Date: Mon, 24 Feb 2014 20:16:01 +0000
Message-ID: <1393272961.2323.75.camel@loki>
References: <1393255622-31365-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 577DC2654EC
 for <alsa-devel@alsa-project.org>; Mon, 24 Feb 2014 21:16:31 +0100 (CET)
In-Reply-To: <1393255622-31365-1-git-send-email-jarkko.nikula@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2014-02-24 at 17:26 +0200, Jarkko Nikula wrote:
> This set adds support for Baytrail SST DSP with RT5640 based machine
> driver. Design is quite similar and is actually inherited from Intel
> Haswell SST DSP drivers that were posted recently. Reason for another
> implementation is that there are more differences than similarities
> between Haswell and Baytrail.
> 
> First difference comes from the SHIM registers that are 32-bit on
> Haswell and 64-bit on Baytrail. Also memory map and message mailbox is
> different. Second difference is message passing and message headers
> between host and SST DSP. For instance the DSP notifies the host using
> different SHIM registers and bits than on Haswell.
> 
> Biggest difference comes from the DSP firmware. It has different IPC
> messages, stream setup and how DMA pointer is tracked. Currently
> firmware has less features than Haswell DSP firmware and it doesn't
> support compress offload and volume controls support.
> 
> The RT5640 based machine driver is for our customer reference boards
> but at quick test it appears to work on Asus T100 too. Note currently
> the SST is the I2S master on this machine driver and codec is set to
> use I2C BCLK as it's input clock.
> 
> Jarkko Nikula (7):
>   ASoC: Intel: Add Baytrail SST ID and Baytrail specific register bits
>   ASoC: Intel: Add Intel Baytrail SST DSP support
>   ASoC: Intel: Add Intel Baytrail SST DSP IPC support
>   ASoC: Intel: Add Intel Baytrail SST PCM platform driver
>   ASoC: Intel: Add machine driver for Baytrail SST with RT5640 codec
>   ASoC: Intel: Add Baytrail SST and byt-rt5640 machine driver probing
>   ASoC: Intel: Add build support for Baytrail SST
> 

All 

Acked-by: Liam Girdwood <liam.r.girdwood@intel.com>
