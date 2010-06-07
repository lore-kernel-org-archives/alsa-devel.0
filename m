From: Ryan Mallon <ryan@bluewatersys.com>
Subject: Re: [RFC PATCH v3 1/3] ep93xx i2s core support
Date: Tue, 08 Jun 2010 10:21:53 +1200
Message-ID: <4C0D7101.6030506@bluewatersys.com>
References: <1275628285-12642-1-git-send-email-ryan@bluewatersys.com>
	<1275628285-12642-2-git-send-email-ryan@bluewatersys.com>
	<0D753D10438DA54287A00B0270842697636F83B425@AUSP01VMBX24.collaborationhost.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hayes.bluewaternz.com (mail.bluewatersys.com [202.124.120.130])
	by alsa0.perex.cz (Postfix) with ESMTP id 630AC10380B
	for <alsa-devel@alsa-project.org>;
	Tue,  8 Jun 2010 00:21:57 +0200 (CEST)
In-Reply-To: <0D753D10438DA54287A00B0270842697636F83B425@AUSP01VMBX24.collaborationhost.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: H Hartley Sweeten <hartleys@visionengravers.com>
Cc: "john.cooper@third-harmonic.com" <john.cooper@third-harmonic.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "chasedouglas@gmail.com" <chasedouglas@gmail.com>, "buytenh@wantstofly.org" <buytenh@wantstofly.org>, "r&d4@dave-tech.it" <r&d4@dave-tech.it>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>, "marshall@coolbananas.co.nz" <marshall@coolbananas.co.nz>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "dhuggins@cs.cmu.edu" <dhuggins@cs.cmu.edu>
List-Id: alsa-devel@alsa-project.org

H Hartley Sweeten wrote:
> On Thursday, June 03, 2010 10:11 PM, Ryan Mallon wrote:
>> Add ep93xx core support for i2s audio
>>
>> Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
>> ---
>>  arch/arm/mach-ep93xx/clock.c                    |   69 ++++++++++++++++++++++-
>>  arch/arm/mach-ep93xx/core.c                     |   31 ++++++++++
>>  arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h |   10 +++
>>  arch/arm/mach-ep93xx/include/mach/platform.h    |    1 +
>>  4 files changed, 110 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-ep93xx/clock.c b/arch/arm/mach-ep93xx/clock.c
>> index 5f80092..503d430 100644
>> --- a/arch/arm/mach-ep93xx/clock.c
>> +++ b/arch/arm/mach-ep93xx/clock.c
>> @@ -43,7 +43,8 @@ static unsigned long get_uart_rate(struct clk *clk);
>>  
>>  static int set_keytchclk_rate(struct clk *clk, unsigned long rate);
>>  static int set_div_rate(struct clk *clk, unsigned long rate);
>> -
>> +static int set_i2s_sclk_rate(struct clk *clk, unsigned long rate);
>> +static int set_i2s_lrclk_rate(struct clk *clk, unsigned long rate);
>>  
>>  static struct clk clk_xtali = {
>>  	.rate		= EP93XX_EXT_CLK_RATE,
>> @@ -108,6 +109,31 @@ static struct clk clk_video = {
>>  	.set_rate	= set_div_rate,
>>  };
>>  
>> +static struct clk clk_i2s_mclk = {
>> +	.sw_locked	= 1,
>> +	.enable_reg	= EP93XX_SYSCON_I2SCLKDIV,
>> +	.enable_mask	= (EP93XX_SYSCON_CLKDIV_ENABLE  |
>> +			   EP93XX_SYSCON_I2SCLKDIV_SPOL |
>> +			   EP93XX_SYSCON_I2SCLKDIV_ORIDE),
> 
> Setting the SPOL and ORIDE bits here might cause problems in the future.
> Granted, your i2s driver is currently the only user so its probably ok
> for now.
> 
> But, you might want to move the setting of those two bits along with the
> SLAVE and DROP bits to the core registration function.  The clock support
> should only be enabling/disabling and setting the rates for the clocks.

Okay, sounds sensible. Possibly I should add acquire/release functions
in addition to the register, something like:

void __init ep93xx_register_i2s(void)
{
	platform_device_register(&ep93xx_i2s_device);
}

int ep93xx_i2s_acquire(unsigned pins, int override, int sclk_falling)
{
	unsigned set_bits = pins,
		 clear_bits = EP93XX_SYSCON_DEVCFG_I2SONSSP |
			      EP93XX_SYSCON_DEVCFG_I2SONAC97;

	if (pins != EP93XX_SYSCON_DEVCFG_I2SONSSP &&
	    pins != EP93XX_SYSCON_DEVCFG_I2SONAC97)
		return -EINVAL;

	if (override)
		set_bits |= EP93XX_SYSCON_I2SCLKDIV_ORIDE;
	else
		clear_bits |= EP93XX_SYSCON_I2SCLKDIV_ORIDE;

	if (sclk_falling)
		set_bits |= EP93XX_SYSCON_I2SCLKDIV_SPOL;
	else
		clear_bits |= EP93XX_SYSCON_I2SCLKDIV_SPOL;

	ep93xx_devcfg_clear_bits(clear_bits);
	ep93xx_devcfg_set_bits(set_bits);
	return 0;
}

>> +	.set_rate	= set_div_rate,
> 
> By calling the set_div_rate routine your only updating the master clock
> rate.  Should the new rate be pushed down to the children?  Actually the
> new rates for the children will be established automatically when the
> master clock rate is changed.  But a clk_get_rate for the children will
> return an incorrect value.  Maybe just add a get_rate method for the
> children?

The code basically assumes that the clocks will always be set in the
order: mclk, sclk, lrclk. Since the i2s driver is the only user, this
should be a valid assumption. Possibly a comment should be put in to
state that this assumption is made.

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan@bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
