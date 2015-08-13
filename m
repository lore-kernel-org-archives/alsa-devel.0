From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 17/25] ALSA: firewire-tascam: add skeleton
 for TASCAM FireWire series
Date: Thu, 13 Aug 2015 16:18:10 +0900
Message-ID: <55CC44B2.6080200@sakamocchi.jp>
References: <1439425221-30826-1-git-send-email-o-takashi@sakamocchi.jp>	<1439425221-30826-18-git-send-email-o-takashi@sakamocchi.jp>
 <s5hy4hfzox8.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 43B8D2604A1
 for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2015 09:18:13 +0200 (CEST)
In-Reply-To: <s5hy4hfzox8.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On Aug 13 2015 15:24, Takashi Iwai wrote:
> On Thu, 13 Aug 2015 02:20:13 +0200,
> Takashi Sakamoto wrote:
>>
>> This commit adds a new driver for TASCAM FireWire series. In this commit,
>> this driver just creates/removes card instance according to bus event.
>> More functionalities will be added in following commits.
>>
>> TASCAM FireWire series consists of:
>>   * PDI 1394P23 for IEEE 1394 PHY layer
>>   * PDI 1394L40 for IEEE 1394 LINK layer and IEC 61883 interface
>>   * XILINX XC9536XL
>>   * XILINX Spartan-II XC2S100
>>   * ATMEL AT91M42800A
>>
>> Ilya Zimnovich had investigated TASCAM FireWire series in 2011, and
>> discover some features of his FW-1804. You can see a part of his research
>> in FFADO project.
>> http://subversion.ffado.org/wiki/Tascam
>>
>> A part of my work is based on Ilya's investigation, while this series
>> doesn't support the FW-1804, because of a lack of config ROM
>> information and its protocol detail, especially for PCM channels.
>>
>> I observed that FW-1884 and FW-1082 don't work properly with 1394 OHCI
>> controller based on VT6315. The controller can actually communicate packets
>> to these models, while these models generate no sounds. It may be due to
>> the PHY/LINK layer issues. Using 1394 OHCI controller produced by the other
>> vendors such as Texas Instruments may enable to work. Or adding another
>> node on the bus.
>>
>> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
>> ---
>>   sound/firewire/Kconfig         |  11 +++
>>   sound/firewire/Makefile        |   1 +
>>   sound/firewire/tascam/Makefile |   2 +
>>   sound/firewire/tascam/tascam.c | 155 +++++++++++++++++++++++++++++++++++++++++
>>   sound/firewire/tascam/tascam.h |  28 ++++++++
>>   5 files changed, 197 insertions(+)
>>   create mode 100644 sound/firewire/tascam/Makefile
>>   create mode 100644 sound/firewire/tascam/tascam.c
>>   create mode 100644 sound/firewire/tascam/tascam.h
>>
>> diff --git a/sound/firewire/Kconfig b/sound/firewire/Kconfig
>> index 80f3b57..605cb91 100644
>> --- a/sound/firewire/Kconfig
>> +++ b/sound/firewire/Kconfig
>> @@ -135,4 +135,15 @@ config SND_FIREWIRE_DIGI00X
>>   	 To compile this driver as a module, choose M here: the module
>>   	 will be called snd-firewire-digi00x.
>>
>> +config SND_FIREWIRE_TASCAM
>> +	tristate "TASCAM FireWire series support"
>> +	select SND_FIREWIRE_LIB
>> +	help
>> +	 Say Y here to include support for TASCAM.
>> +	  * FW-1884
>> +	  * FW-1082
>> +
>> +	 To compile this driver as a module, choose M here: the module
>> +	 will be called snd-firewire-tascam.
>> +
>>   endif # SND_FIREWIRE
>> diff --git a/sound/firewire/Makefile b/sound/firewire/Makefile
>> index 5325d15..6ae50f5 100644
>> --- a/sound/firewire/Makefile
>> +++ b/sound/firewire/Makefile
>> @@ -12,3 +12,4 @@ obj-$(CONFIG_SND_SCS1X) += snd-scs1x.o
>>   obj-$(CONFIG_SND_FIREWORKS) += fireworks/
>>   obj-$(CONFIG_SND_BEBOB) += bebob/
>>   obj-$(CONFIG_SND_FIREWIRE_DIGI00X) += digi00x/
>> +obj-$(CONFIG_SND_FIREWIRE_TASCAM) += tascam/
>> diff --git a/sound/firewire/tascam/Makefile b/sound/firewire/tascam/Makefile
>> new file mode 100644
>> index 0000000..29bdbce
>> --- /dev/null
>> +++ b/sound/firewire/tascam/Makefile
>> @@ -0,0 +1,2 @@
>> +snd-firewire-tascam-objs := tascam.o
>> +obj-m += snd-firewire-tascam.o
>
> This should be
> obj-$(CONFIG_SND_FIREWIRE_TASCAM) += snd-firewire-tascam.o

Indeed. I completely forgot it...


Thank you

Takashi Sakamoto
