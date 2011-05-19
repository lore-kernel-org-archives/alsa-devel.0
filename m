From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH 0/2] ASoC: davinci: ping-pong buffers for
	mcasp on da850evm
Date: Thu, 19 May 2011 12:08:09 +0100
Message-ID: <4DD4FA19.70107@ti.com>
References: <cover.1305723716.git.bengardiner@nanometrics.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id C4D6A103847
	for <alsa-devel@alsa-project.org>;
	Thu, 19 May 2011 13:08:13 +0200 (CEST)
In-Reply-To: <cover.1305723716.git.bengardiner@nanometrics.ca>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ben Gardiner <bengardiner@nanometrics.ca>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Subhasish Ghosh <subhasish@mistralsolutions.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "Nori,
	Sekhar" <nsekhar@ti.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, Troy Kisky <troy.kisky@boundarydevices.com>
List-Id: alsa-devel@alsa-project.org

On 18/05/11 14:27, Ben Gardiner wrote:
> davinci-i2s enables the use of ping-pong buffers by copying the sram sizes
> specified by platform data into the dma params used by davinci-pcm.
> 
> This patch series first implements that same behaviour in davinic-mcasp
> and then specified sram sizes and eventq's for da850evm.
> 
> To achieve the use of ping-pong buffers at runtime this patch depends also
> on the conversion of da850's SRAM allocator to the "Share RAM" region from 
> the "ARM Local RAM" region -- originally proposed by Subhasish Ghosh[1] and
> recently reposted by myself [2].
> 
> This is because the "ARM Local RAM" region currently used by the da850 SRAM
> allocator is not addressable by the EDMA. The resulting behaviour, when
> ping-pong buffers are used by davinci-pcm, is that playback produces silence
> and capture acquires silence.
> 
> However, there is no change in behaviour for da850evm build with the in-tree
> defconfig since suspend allocates SRAM which prevents a successful allocation
> of 8K by davinci-pcm and thus the behaviour falls back to the usual scheme.
> 
> In the case of da850evm builds where CONFIG_SUSPEND is not set, playback 
> will produce silence and capture will acquire silence until such time as the
> patches to change the da850 SRAM allocator to the "Shared RAM" region are 
> merged.
> 
> [1] http://article.gmane.org/gmane.linux.kernel/1098928
> [2] http://article.gmane.org/gmane.linux.ports.arm.kernel/117261
> 
> Ben Gardiner (2):
>   ASoC: davinci-mcasp: enable ping-pong SRAM buffers
>   davinci: da850evm: enable mcasp ping-pong buffers and eventq's
> 
>  arch/arm/mach-davinci/board-da850-evm.c |    5 ++++-
>  sound/soc/davinci/davinci-mcasp.c       |    2 ++
>  2 files changed, 6 insertions(+), 1 deletions(-)
> 

Both

Acked-by: Liam Girdwood <lrg@ti.com>
