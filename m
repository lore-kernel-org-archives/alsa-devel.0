From: Brian Rhodes <bgr@acdstar.com>
Subject: Re: ASoC: pxa2xx-i2s
Date: Wed, 21 Jan 2009 14:13:12 -0600
Message-ID: <497781D8.50003@acdstar.com>
References: <4975E030.5080905@acdstar.com> <4975F160.8040001@gmail.com>
	<4976042B.6060604@acdstar.com> <49764F15.6080008@acdstar.com>
	<20090121132313.GA29953@sirena.org.uk>
	<49775159.7070708@linespeed.net>
	<20090121193230.GA15911@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from manowar.linespeed.net (linespeed.net [75.146.159.141])
	by alsa0.perex.cz (Postfix) with ESMTP id 52830243E4
	for <alsa-devel@alsa-project.org>; Wed, 21 Jan 2009 21:13:26 +0100 (CET)
In-Reply-To: <20090121193230.GA15911@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org, Brian Rhodes <bgr@acdstar.com>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Wed, Jan 21, 2009 at 10:46:17AM -0600, Brian G Rhodes wrote:
>   
>> Mark Brown wrote:
>>     
>
>   
>>> What is the clock master in your system?
>>>       
>
>   
>> The master is the i2s controller sysclk.  The dac2x is in slave mode.  
>> Though the i2s controller isn't directly supplying the bit clock to the 
>> codec in this case.  We're using the PLL on the dac2x.
>>     
>
> Just to confirm, the codec is the clock master on the I2S bus itself?
>
>   
No, the 270 is the clock master on the I2S bus.  The codec is sourcing 
the clock input using the PLL.  I apologize for being unclear.
