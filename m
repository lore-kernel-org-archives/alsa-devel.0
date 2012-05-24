From: Ola Lilja <ola.o.lilja@stericsson.com>
Subject: Re: [PATCH 10/11] ASoC: codecs: Add AB8500 codec-driver
Date: Thu, 24 May 2012 08:21:25 +0200
Message-ID: <4FBDD365.7080304@stericsson.com>
References: <1336485450-27405-1-git-send-email-ola.o.lilja@stericsson.com>
	<20120508182751.GJ15893@opensource.wolfsonmicro.com>
	<4FBC8C11.6020602@stericsson.com>
	<20120523174009.GE4064@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog116.obsmtp.com (eu1sys200aog116.obsmtp.com
	[207.126.144.141])
	by alsa0.perex.cz (Postfix) with ESMTP id 2997B103E6F
	for <alsa-devel@alsa-project.org>;
	Thu, 24 May 2012 08:21:34 +0200 (CEST)
In-Reply-To: <20120523174009.GE4064@opensource.wolfsonmicro.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org

On 05/23/2012 07:40 PM, Mark Brown wrote:

> On Wed, May 23, 2012 at 09:04:49AM +0200, Ola Lilja wrote:
>> On 05/08/2012 08:27 PM, Mark Brown wrote:
> 
>> >> +	SOC_ENUM("Charge Pump High Threshold For Low Voltage",
>> >> +		soc_enum_envdeththre),
>> >> +	SOC_ENUM("Charge Pump Low Threshold For Low Voltage",
>> >> +		soc_enum_envdetlthre),
>> >> +	SOC_ENUM("Charge Pump Envelope Detection", soc_enum_envdetcpen),
>> >> +	SOC_ENUM("Charge Pump Envelope Detection Decay Time",
>> >> +		soc_enum_envdettime),
> 
>> > Again, why is this all exposed to userspace?
> 
>> These one we need as ALSA-controls. They are parameters that we can tune during
>> runtime and are not hard-wired in any way.
> 
> This seems incredibly surprising - are you sure the configuration isn't
> simply a case of enabling and disabling the charge pump voltage scaling?


Well, yes. One of the control enables/disables the ability to use another
charge-pump voltage when the signal gets over a certain threshold. The other
parameters are tuning of this theshold and responsiveness. This feature can be
changed during runtime depending of quality vs. powersaving needs.
