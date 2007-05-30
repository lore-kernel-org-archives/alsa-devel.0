From: Timur Tabi <timur@freescale.com>
Subject: Re: ASoC and a codec that can't be controlled
Date: Wed, 30 May 2007 13:10:28 -0500
Message-ID: <465DBE14.5020206@freescale.com>
References: <46531097.5040600@freescale.com>	
	<1179934677.12071.30.camel@a10072.wolfsonmicro.main>	
	<46574453.10808@freescale.com>	
	<1180354247.5816.30.camel@a10072.wolfsonmicro.main>	
	<465C78B6.3000001@freescale.com>
	<1180529741.29590.54.camel@a10072.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 93153244F7
	for <alsa-devel@alsa-project.org>;
	Wed, 30 May 2007 20:10:38 +0200 (CEST)
In-Reply-To: <1180529741.29590.54.camel@a10072.wolfsonmicro.main>
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

>> I guess I just don't understand why the codec driver is acting like the "master" driver of 
>> ASOC.  IMHO, the codec driver should be doing two things:
> 
> I guess this is due to an ordering issue we had during early
> development. We had to make sure that the I2C probe of the codec
> succeeded before registering the card, pcms, etc. Fwiw, I do intend to
> address this in future versions (I should probably add a road map to the
> wiki now).

In that case, I think we can solve this problem as well as the PowerPC device tree problem 
in one shot, because they're basically the same problem.

Anyway, let me see if I get this right:

1. The first function called is eti_b1_init().
2. eti_b1_init() calls platform_device_add() to add an soc-audio class device and register 
the eti_b1_snd_devdata structure.
3. The registration causes a number of things to happen, one of which is a call to 
soc_probe().
4. soc_probe() sees that the snd_soc_machine_eti_b1.probe is NULL, so that part is skipped.
3. soc_probe() sees that snd_soc_machine_eti_b1.dai_link->cpu_dai->probe is also NULL, so 
that part is skipped. (eti_b1_snd_devdata.machine == snd_soc_machine_eti_b1)
4. soc_probe() sees that soc_codec_dev_wm8731.probe is not NULL, so it calls wm8731_probe().
5. wm8731_probe() registers an I2C driver.
6. The I2C class driver calls wm8731_i2c_driver.attach_adapter, which is wm8731_i2c_attach().
7. wm8731_i2c_attach() calls i2c_probe(), which in turn calls wm8731_codec_probe()
8. wm8731_codec_probe() allocates a snd_soc_codec structure.
8. wm8731_codec_probe() calls wm8731_init().

This means that if there is no I2C support, wm8731_init() will never be called.

9. wm8731_init() initializes the snd_soc_codec structure.

Question: why doesn't wm8731_probe() initialize the non-I2C parts of the snd_soc_codec 
structure?  For example, snd_soc_codec.dai, snd_soc_codec.name, and snd_soc_codec.owner? 
That way, the snd_soc_codec structure will be properly initialized even when there's no I2C.

10. wm8731_init() calls snd_soc_new_pcms.
11. wm8731_init() exits, wm8731_codec_probe() exits, wm8731_i2c_attach() exits, and then 
wm8731_probe() exits.  Control returns to soc_probe().
12. soc_probe() notices that eti_b1_snd_devdata.platform.probe is NULL, so it skips that.

Question: why don't you define a function for at91_soc_platform.probe, and in that 
function you can call snd_soc_new_pcms()?  That way, you guarantee the codec driver's I2C 
interface is initialized before snd_soc_new_pcms() is called, and you avoid have PCM calls 
in the codec driver.

>> ASOC and the machine driver should then work in tandem to decide which driver will do what 
>> and which capabilities are *actually* supported.  *Something* needs to look at the entire 
>> system and say to each device, "Well, yes, I know about this little feature of yours, but 
>> we're just not going to support that today."
>>
> 
> The machine driver pretty much already does this. It can override valid
> hardware configurations and return -EINVAl if required. 

Do you have an example of that?  Would that be eti_b1_hw_params()?

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
