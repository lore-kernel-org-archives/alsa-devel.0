From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: core - Add platform read and write.
Date: Mon, 4 Jul 2011 22:14:05 +0100
Message-ID: <4E122D1D.4010109@ti.com>
References: <1309774215-4083-1-git-send-email-lrg@ti.com>
	<20110704194140.GC32624@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 157E2103877
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Jul 2011 23:14:07 +0200 (CEST)
In-Reply-To: <20110704194140.GC32624@opensource.wolfsonmicro.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 04/07/11 20:41, Mark Brown wrote:
> On Mon, Jul 04, 2011 at 11:10:15AM +0100, Liam Girdwood wrote:
> 
>> +int snd_soc_platform_read(struct snd_soc_platform *platform,
>> +					unsigned int reg)
>> +{
>> +	unsigned int ret;
>> +
>> +	if (!platform->driver->read) {
>> +		dev_err(platform->dev, "platform has no read back\n");
>> +		return -1;
>> +	}
>> +
>> +	ret = platform->driver->read(platform, reg);
>> +	dev_dbg(platform->dev, "read %x => %x\n", reg, ret);
> 
> We should add tracepoints into these as well.

Ah, forgot to send that one with this one. It's on it's way now ;)

> 
>> +int snd_soc_platform_write(struct snd_soc_platform *platform,
>> +					 unsigned int reg, unsigned int val)
>> +{
>> +	if (!platform->driver->write) {
>> +		dev_err(platform->dev, "platform has no write back\n");
>> +		return -1;
> 
> Could return -EINVAL or something here - it's not like read where we're
> mixing with the in band data.

I was thinking that too, but consistency with the codec IO would mean return -1. 

However, I've no real preference. I happy to change to EINVAL.

Liam
