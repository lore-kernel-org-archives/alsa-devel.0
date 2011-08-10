From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 3/4] ASoC: Blackfin: ADAU1373 eval board
 support
Date: Wed, 10 Aug 2011 08:09:55 +0200
Message-ID: <4E4220B3.7020105@metafoo.de>
References: <1312948364-2587-1-git-send-email-lars@metafoo.de>	<1312948364-2587-3-git-send-email-lars@metafoo.de>
	<CAHG8p1CuiJws=wSKrfAiY9E=rne=taPP-semYZQJWuHn19398w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
	(mailhost.informatik.uni-hamburg.de [134.100.9.70])
	by alsa0.perex.cz (Postfix) with ESMTP id 4952B24527
	for <alsa-devel@alsa-project.org>;
	Wed, 10 Aug 2011 08:12:10 +0200 (CEST)
In-Reply-To: <CAHG8p1CuiJws=wSKrfAiY9E=rne=taPP-semYZQJWuHn19398w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Scott Jiang <scott.jiang.linux@gmail.com>
Cc: alsa-devel@alsa-project.org, Mike Frysinger <vapier.adi@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org, uclinux-dist-devel@blackfin.uclinux.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 08/10/2011 07:27 AM, Scott Jiang wrote:
>> +config SND_SOC_BFIN_EVAL_ADAU1373
>> +       tristate "Support for the EVAL-ADAU1373 board on Blackfin eval boards"
>> +       depends on SND_BF5XX_I2S
>> +       select SND_BF5XX_SOC_I2S
>> +       select SND_SOC_ADAU1373
>> +       select I2C
> 
> Is it better to use depends on I2C?
> 

Not sure, I just kept the scheme used by the other blackfin board drivers. But
I guess it makes some sense change it to 'depends'. Especially if we consider
that there are going to be board drivers with support for both I2C and SPI.

- Lars
