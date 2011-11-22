From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Fix wrong define for
 AD1836_ADC_WORD_OFFSET
Date: Tue, 22 Nov 2011 13:00:23 +0000
Message-ID: <20111122130023.GB6624@sirena.org.uk>
References: <1321926411.4764.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 0993B24362
	for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2011 14:00:27 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1321926411.4764.1.camel@phoenix>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lrg@ti.com>, Mark@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 22, 2011 at 09:46:51AM +0800, Axel Lin wrote:
> According to the datasheet:
> The BIT[5:4] of ADC Control Register 2 is to control the word width.
>         00 = 25 Bits
>         01 = 20 Bits
>         10 = 16 Bits
>         11 = Invalid
> 
> Thus, the AD1836_ADC_WORD_OFFSET should be defined as 4.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Applied, thanks.
