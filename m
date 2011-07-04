From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH] ASoC: wm8731: set the ACTIVE bit if bias
	ON entered
Date: Mon, 04 Jul 2011 11:46:30 +0200
Message-ID: <4E118BF6.6010205@atmel.com>
References: <ccd4b125244271af7978948689cf1dcef37bc06b.1309368631.git.nicolas.ferre@atmel.com>
	<1309517034-26110-1-git-send-email-nicolas.ferre@atmel.com>
	<20110701161506.GC23784@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sjogate2.atmel.com (newsmtp5.atmel.com [204.2.163.5])
	by alsa0.perex.cz (Postfix) with ESMTP id 1E2DF1037F2
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Jul 2011 11:46:50 +0200 (CEST)
In-Reply-To: <20110701161506.GC23784@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, lrg@ti.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Le 01/07/2011 18:15, Mark Brown :
> On Fri, Jul 01, 2011 at 12:43:54PM +0200, Nicolas Ferre wrote:
>> Resuming from a suspend/resume cycle, the ACTIVE bit was not set even if a
>> stream had actually been processing.
>> Setting this bit at entering SND_SOC_BIAS_ON level will ensure this.
> 
> This will set the bit even for analogue bypass paths which don't need
> it.  I'd suggest making the active bit a supply widget supplying the DAC
> and ADC rather than something open coded, that should do the right thing
> I think.

Ah, ok... but I fear that I do not know the whole system enough for this
addition ;-(
Do you think you can code this modification, I will be happy to test it,
if you want...

Best regards,
-- 
Nicolas Ferre
