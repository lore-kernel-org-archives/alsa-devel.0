From: Brian Rhodes <bgr@acdstar.com>
Subject: Re: ASoC: pxa2xx-i2s
Date: Fri, 23 Jan 2009 10:50:39 -0600
Message-ID: <4979F55F.70600@acdstar.com>
References: <4975E030.5080905@acdstar.com>
	<4975F160.8040001@gmail.com>	<4976042B.6060604@acdstar.com>
	<49764F15.6080008@acdstar.com>	<20090121132313.GA29953@sirena.org.uk>	<49775159.7070708@linespeed.net>	<20090121193230.GA15911@sirena.org.uk>
	<497781D8.50003@acdstar.com> <20090121222718.GA23539@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from manowar.linespeed.net (linespeed.net [75.146.159.141])
	by alsa0.perex.cz (Postfix) with ESMTP id B1A1724469
	for <alsa-devel@alsa-project.org>; Fri, 23 Jan 2009 17:50:48 +0100 (CET)
In-Reply-To: <20090121222718.GA23539@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Wed, Jan 21, 2009 at 02:13:12PM -0600, Brian Rhodes wrote:
>
>   
>> No, the 270 is the clock master on the I2S bus.  The codec is sourcing 
>> the clock input using the PLL.  I apologize for being unclear.
>>     
>
> I think it's me that's not being clear, sorry - I'm trying to find out
> is if the LRCLK and BCLK signals on the I2S bus itself are being driven
> by the codec or by the I2S controller.  If the codec driver is the clock
> master then your earlier speculation that your problems with the I2S
> controller may be due to some interaction with the codec driver are more
> likely to be true.
>
>   
I'm curious if you think this problem may be arising from the toggling 
of the direction of BCLK on the PXA while the I2S clock is enabled.  I'm 
sure there are people who have a reason for switching the bit clock 
master, but I'm thinking that this should not be explicitly done if it 
is not changing.
