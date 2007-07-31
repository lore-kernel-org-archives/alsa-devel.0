From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH v3] ASoC CS4270 codec device driver
Date: Tue, 31 Jul 2007 11:12:44 -0500
Message-ID: <46AF5F7C.5020309@freescale.com>
References: <1185896812320-git-send-email-timur@freescale.com>
	<s5h4pjkva0g.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id E507E24361
	for <alsa-devel@alsa-project.org>;
	Tue, 31 Jul 2007 18:12:48 +0200 (CEST)
In-Reply-To: <s5h4pjkva0g.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Tue, 31 Jul 2007 10:46:52 -0500,
> Timur Tabi wrote:
>> This patch adds ALSA SoC support for the Cirrus Logic CS4270 codec.  The
>> following features are suppored:
>>
>> 1) Stand-alone and software mode
>> 2) Software mode via I2C only
>> 3) Master mode, not Slave
>> 4) No power management
>>
>> Signed-off-by: Timur Tabi <timur@freescale.com>
> 
> Thanks, it can be now applied fine.
> 
> The only thing I noticed is below (oh I should have mentioned it
> before...):
> 
>> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
>> index e5fb437..7824880 100644
>> --- a/sound/soc/codecs/Kconfig
>> +++ b/sound/soc/codecs/Kconfig
>> @@ -17,3 +17,23 @@ config SND_SOC_WM8753
>>  config SND_SOC_WM9712
>>  	tristate
>>  	depends on SND_SOC
>> +
>> +# Cirrus Logic CS4270 Codec
>> +config SND_SOC_CS4270
>> +	tristate
>> +	depends on SND_SOC
>> +
>> +# Cirrus Logic CS4270 Codec Hardware Mute Support
>> +# Select if you have external muting circuitry attached to your CS4270.
>> +config SND_SOC_CS4270_HWMUTE
>> +	bool
>> +	depends on SND_SOC_CS4270
>> +
>> +# Cirrus Logic CS4270 Codec VD = 3.3V Errata
>> +# Select if you are affected by the errata where the part will not function
>> +# if MCLK divide-by-1.5 is selected and VD is set to 3.3V.  The driver will
>> +# not select any sample rates that require MCLK to be divided by 1.5.
>> +config SND_SOC_CS4270_VD33_ERRATA
>> +	bool
>> +	depends on SND_SOC_CS4270
>> +
> 
> I'd suggest to convert these comments to help texts.
> Also, usually the items to be chosen via menuconfig have
> 	tristate "XXXX"
> or
> 	bool "XXX"
> 
> Could you fix them, then I'll finally merge it to upstream?

I am following the model of the other Kconfig options.  If I add the "XXXX" and the help 
text, then they become selectable from "make menuconfig", but they would be the only ones 
to show up like that.

I think the reason why they are like this is because they're supposed to be selected from 
the machine driver that uses them, like this:

config SND_AT91_SOC_ETI_B1_WM8731
	tristate "SoC Audio support for WM8731-based Endrelia ETI-B1 boards"
	depends on SND_AT91_SOC && (MACH_ETI_B1 || MACH_ETI_C1)
	select SND_AT91_SOC_SSC
	select SND_SOC_WM8731
	help
	  Say Y if you want to add support for SoC audio on WM8731-based
	  Endrelia Technologies Inc ETI-B1 or ETI-C1 boards.

So that the only way you can specify the CS4270 is if you have a machine driver that uses it.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
