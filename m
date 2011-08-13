From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [linux-next] ASoC: sound/soc/samsung/i2s.c build
	failure
Date: Sat, 13 Aug 2011 15:29:26 +0900
Message-ID: <20110813062925.GB16171@opensource.wolfsonmicro.com>
References: <1313208043.29596.11.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6A79F103816
	for <alsa-devel@alsa-project.org>;
	Sat, 13 Aug 2011 08:29:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1313208043.29596.11.camel@phoenix>
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
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Aug 13, 2011 at 12:00:43PM +0800, Axel Lin wrote:
>   CC      sound/soc/samsung/i2s.o
> sound/soc/samsung/i2s.c:24:18: error: idma.h: No such file or directory
> sound/soc/samsung/i2s.c: In function 'samsung_i2s_dai_probe':
> sound/soc/samsung/i2s.c:883: error: implicit declaration of function 'idma_reg_addr_init'
> make[3]: *** [sound/soc/samsung/i2s.o] Error 1
> make[2]: *** [sound/soc/samsung] Error 2
> make[1]: *** [sound/soc] Error 2
> make: *** [sound] Error 2

> It is caused by commit a0c27ab2421c47dc7c53f797fffcc0d17cdb122c
> ASoC: Revert "ASoC: SAMSUNG: Add I2S0 internal dma driver"

> To fix the build error, I think we also need to revert
> commit 61100f405de5c16a0866de7843ed442090436e6a
> "ASoC: SAMSUNG: Modify I2S driver to support idma".

This is already fixed by cherry picking back the original commit, it
depended on some stuff from Kukjin's tree.
