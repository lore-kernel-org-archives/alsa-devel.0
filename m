From: Timur Tabi <timur@freescale.com>
Subject: Re: ASoC and a codec that can't be controlled
Date: Tue, 29 May 2007 13:47:45 -0500
Message-ID: <465C7551.1010404@freescale.com>
References: <46531097.5040600@freescale.com>	
	<1179934677.12071.30.camel@a10072.wolfsonmicro.main>	
	<46574453.10808@freescale.com>
	<1180354247.5816.30.camel@a10072.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id BCE29243CD
	for <alsa-devel@alsa-project.org>;
	Tue, 29 May 2007 20:47:51 +0200 (CEST)
In-Reply-To: <1180354247.5816.30.camel@a10072.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Liam Girdwood wrote:
> On Fri, 2007-05-25 at 15:17 -0500, Timur Tabi wrote:
>> Liam Girdwood wrote:
>>
>>> These are used for setting up the dynamic audio power management and
>>> won't be needed in stand alone mode.
>> So if I don't care about power management, can I completely ignore anything with "dapm" in it?
> 
> Yes.
> 
>> Also, do I need a codec driver at all, even if I can't control the codec?  That is, can I 
>> do stuff like this:
>>
>> static struct snd_soc_device mysoc_snd_devdata = {
>> 	.machine = &snd_soc_machine_mysoc,
>> 	.platform = &mysoc_soc_platform,
>> };
>>
>> static struct snd_soc_dai_link mpc8610hpcd_dai = {
>> 	.name = "CS4270",
>> 	.stream_name = "CS4270",
>> 	.cpu_dai = &mysoc_i2s_dai,
>> 	.init = mpc8610hpcd_machine_init,
>> 	.ops = &mpc8610hpcd_ops,
>> };
> 
> Yes, although my feeling is that a codec "driver" would still be needed
> to define the capabilities of your codec within the audio subsystem.

Another question:

Why do I need to specify the codec DAI in two different structures?

eti_b1_wm8731.c:

static struct snd_soc_dai_link eti_b1_dai = {
	.name = "WM8731",
	.stream_name = "WM8731",
	.cpu_dai = &at91_i2s_dai[1],
	.codec_dai = &wm8731_dai,	<----
	.init = eti_b1_wm8731_init,
	.ops = &eti_b1_ops,
};

wm8731.c:

static int wm8731_init(struct snd_soc_device *socdev)
{
	struct snd_soc_codec *codec = socdev->codec;
...
	int reg, ret = 0;

	codec->dai = &wm8731_dai;	<-----

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
