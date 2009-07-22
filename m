From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: tlv320aic3x: Enable PLL when not
	bypassed
Date: Wed, 22 Jul 2009 13:42:14 +0100
Message-ID: <20090722124214.GA28188@rakim.wolfsonmicro.main>
References: <1248263104-12142-1-git-send-email-chaithrika@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DF29F1038D0
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Jul 2009 14:42:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1248263104-12142-1-git-send-email-chaithrika@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Chaithrika U S <chaithrika@ti.com>
Cc: khilman@deeprootsystems.com, alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 22, 2009 at 07:45:04AM -0400, Chaithrika U S wrote:
> PLL was not being enabled when it was not bypassed. This patch
> enables the PLL when it is used. Additionally, it disables the PLL
> when it is bypassed.
> 
> Without this patch, the audio on TI DM646x EVM and DM355 EVM
> does not work properly. The bit clocks and the frame sync signals
> from the codec are not correct and hence the playback/record are faster
> than usual for most sample rates. The reason for this was that the PLL
> was not enabled when it was not bypassed.

Looks reasonable though I've no knowledge of the CODEC.  Sounds like
this is needed in 2.6.31?
