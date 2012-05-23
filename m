From: Ola Lilja <ola.o.lilja@stericsson.com>
Subject: Re: [PATCH 10/11] ASoC: codecs: Add AB8500 codec-driver
Date: Wed, 23 May 2012 09:04:49 +0200
Message-ID: <4FBC8C11.6020602@stericsson.com>
References: <1336485450-27405-1-git-send-email-ola.o.lilja@stericsson.com>
	<20120508182751.GJ15893@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog118.obsmtp.com (eu1sys200aog118.obsmtp.com
	[207.126.144.145])
	by alsa0.perex.cz (Postfix) with ESMTP id 4016B24458
	for <alsa-devel@alsa-project.org>;
	Wed, 23 May 2012 09:05:23 +0200 (CEST)
In-Reply-To: <20120508182751.GJ15893@opensource.wolfsonmicro.com>
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

On 05/08/2012 08:27 PM, Mark Brown wrote:

>> +static struct snd_kcontrol_new ab8500_ctrls[] = {
>> +	/* Charge pump */
>> +	SOC_ENUM("Charge Pump High Threshold For Low Voltage",
>> +		soc_enum_envdeththre),
>> +	SOC_ENUM("Charge Pump Low Threshold For Low Voltage",
>> +		soc_enum_envdetlthre),
>> +	SOC_ENUM("Charge Pump Envelope Detection", soc_enum_envdetcpen),
>> +	SOC_ENUM("Charge Pump Envelope Detection Decay Time",
>> +		soc_enum_envdettime),
> 
> Again, why is this all exposed to userspace?


These one we need as ALSA-controls. They are parameters that we can tune during
runtime and are not hard-wired in any way.
