From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoc: wm8731: fix wm8731_check_osc()
	connected condition
Date: Wed, 25 May 2011 13:11:55 +0100
Message-ID: <4DDCF20B.4080701@ti.com>
References: <1306230657-28649-1-git-send-email-nicolas.ferre@atmel.com>
	<20110525111529.GC10797@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 46FAB10380F
	for <alsa-devel@alsa-project.org>;
	Wed, 25 May 2011 14:12:00 +0200 (CEST)
In-Reply-To: <20110525111529.GC10797@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On 25/05/11 12:15, Mark Brown wrote:
> On Tue, May 24, 2011 at 11:50:57AM +0200, Nicolas Ferre wrote:
>> The crystal oscillator is only enabled if the WM8731_SYSCLK_XTAL master clock
>> is specified. Fix the connected() struct snd_soc_dapm_route function to take
>> this into account. Oscillator is not enabled on machine that need it otherwise.
>>
>> Machine drivers have to make sure that they use the proper SYSCLK value.
>>
>> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> Adding Liam - Nicolas, please remember to CC all maintainers on patches.
> 

Acked-by: Liam Girdwood <lrg@ti.com>
