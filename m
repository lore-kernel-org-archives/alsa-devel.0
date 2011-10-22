From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ASoC: max98095: Convert codec->hw_write
 to snd_soc_write
Date: Sat, 22 Oct 2011 11:09:39 +0100
Message-ID: <20111022100939.GA3727@opensource.wolfsonmicro.com>
References: <1318650362.6399.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 46F9B103819
	for <alsa-devel@alsa-project.org>;
	Sat, 22 Oct 2011 12:09:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1318650362.6399.1.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: Peter Hsiang <peter.hsiang@maxim-ic.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Oct 15, 2011 at 11:46:02AM +0800, Axel Lin wrote:
> codec->hw_write is broken now, convert codec->hw_write to snd_soc_write.
> 
> The hardware has 2 banks of registers sharing a section in I2C register space.
> The 1st bank is the primary one and is cached.
> The 2nd bank is for loading coefficients only and they do not need cache.
> These coefficients registers are therefore direct writes.
> Thus we set cache_bypass flag to deal with this before calling snd_soc_write.

Applied, thanks.
