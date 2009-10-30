From: Bill Gatliff <bgat@billgatliff.com>
Subject: Re: [PATCH] Add support for CLKOUT to wm8731 codec
	driver
Date: Fri, 30 Oct 2009 11:50:20 -0500
Message-ID: <4AEB194C.700@billgatliff.com>
References: <1256829202-2508-1-git-send-email-bgat@billgatliff.com>
	<1256829202-2508-2-git-send-email-bgat@billgatliff.com>
	<20091029160534.GE15559@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 85BBC10380F
	for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2009 17:50:19 +0100 (CET)
Received: by fg-out-1718.google.com with SMTP id d23so2802857fga.2
	for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2009 09:50:18 -0700 (PDT)
In-Reply-To: <20091029160534.GE15559@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
>
>> +		dev_dbg(codec->dev, PREFIX "%s turning off CLKOUT\n", __func__);
>> +		reg = wm8731_read_reg_cache(codec, WM8731_PWR);
>> +		reg |= (1 << WM8731_PWR_CLKOUTPD);
>> +		wm8731_write(codec, WM8731_PWR, reg);
>> +	}
>>     
>
> It'd be better define a new clock for the CLKOUT pin rather than munging
> it in with the master clock.  MCLK is always an input on the WM8731, the
> CLKOUT output is a separate pin and so including it in MCLK is likely to
> make things confusing and could well introduce errors.
>   

Could you explain more about what you meant by this?  I'm trying to
rework these patches now, and I don't understand how to implement what
you are suggesting.


b.g.

-- 
Bill Gatliff
bgat@billgatliff.com
