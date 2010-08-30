From: Sven Zeisberg <sven.zeisberg@googlemail.com>
Subject: Re: imx-ssi in master mode?
Date: Mon, 30 Aug 2010 08:32:52 +0200
Message-ID: <4C7B5094.4020907@googlemail.com>
References: <4C768708.50903@googlemail.com>
	<20100827115416.GD1473@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 0D32424458
	for <alsa-devel@alsa-project.org>;
	Mon, 30 Aug 2010 08:32:56 +0200 (CEST)
Received: by fxm11 with SMTP id 11so3097668fxm.38
	for <alsa-devel@alsa-project.org>; Sun, 29 Aug 2010 23:32:55 -0700 (PDT)
In-Reply-To: <20100827115416.GD1473@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Sascha Hauer <s.hauer@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

  Hi Sascha,

again - thanks for your help! We start working on this now and hopefully 
return soon with results...


Sven


Am 27.08.2010 13:54, schrieb Sascha Hauer:
> On Thu, Aug 26, 2010 at 05:23:53PM +0200, Sven Zeisberg wrote:
>>    Hi
>>
>> I found that the i.MX25 can not transfer multichannels frames through
>> SSI when it is set up as slave.
>> (when the i.MX25 SSI is set up as slave, the SSI is set to "normal" mode
>> in which only one word per frame is transfered)
>>
>> Now I'm wondering if anybody has successfully used a codec with the
>> i.MX25 SSI set up as Master. When we do this here, we can see that the
>> i.MX25 is generating the bit clock but no frame sync.
> Master mode is currently not supported by the i.MX driver. You'd have to
> implement the clk_get_rate functions for the ssi clocks first before
> implementing the missing pieces in the driver.
>
> Sascha
>
>
