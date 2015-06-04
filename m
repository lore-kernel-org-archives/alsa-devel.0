From: gianluca <gianlucarenzi@eurekelettronica.it>
Subject: Re: Still have problems/issues using SGTL5000 with
 i.MX28 CPU
Date: Thu, 04 Jun 2015 16:40:21 +0200
Message-ID: <55706355.1050607@eurekelettronica.it>
References: <55681B8B.6010700@eurekelettronica.it>
 <CAOMZO5DQg6=nbvn31eMMraLdzGN+jG6kgufy2N7KRCW36dxidQ@mail.gmail.com>
 <55687C24.3090809@eurekelettronica.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx7.acantho.net (mx7.acantho.net [213.174.182.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 19E482606A2
 for <alsa-devel@alsa-project.org>; Thu,  4 Jun 2015 16:40:49 +0200 (CEST)
Received: (from root@localhost)
 by mx7.acantho.net (8.14.3/8.13.4/Debian-3sarge1) id t54EemiK028758
 for <alsa-devel@alsa-project.org>; Thu, 4 Jun 2015 16:40:48 +0200
In-Reply-To: <55687C24.3090809@eurekelettronica.it>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, Sascha Hauer <s.hauer@pengutronix.de>, Peter Chen <peter.chen@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I did some other steps into digging the platform driver (mxs-saif.c) and 
the codec driver (sgtl5000.c) adding some dev_dbg() functions:

> Now I modified the mxs-saif.c and sgtl5000.c with a lot of debugging info, just to let me know if there is something which can be substantially different from IMX28EVK and EK340:
>
> Here is the dmesg output for IMX28EVK recording 5 seconds of audio (I do not modify the INPUT SOURCE, so I suppose it is MIC_IN as amixer tells me that:)
>
> Simple mixer control 'Capture Mux',0
>   Capabilities: enum
>   Items: 'MIC_IN' 'LINE_IN'
>   Item0: 'MIC_IN'

Cmd: arecord -c 2 -f S16_LE -r 22050 -D hw:0,1 -t wav -d 5 /tmp/sample.wav

> ---- DMESG OUTPUT:
>
> mxs-saif 80046000.saif: mxs_saif_startup
> sgtl5000 0-000a: sgtl5000_set_dai_sysclk Enter
> mxs-saif 80046000.saif: mxs_saif_set_dai_sysclk CLKID: 0 FREQ: 11289600 DIR: 0
> sgtl5000 0-000a: sgtl5000_set_dai_fmt Enter fmt: 16385
> sgtl5000 0-000a: sgtl5000_readable Enter
> sgtl5000 0-000a: sgtl5000_volatile Enter
> mxs-saif 80046000.saif: mxs_saif_set_dai_fmt fmt: 16385
> sgtl5000 0-000a: sgtl5000_pcm_hw_params Enter
> sgtl5000 0-000a: sgtl5000_readable Enter
> sgtl5000 0-000a: sgtl5000_volatile Enter
> sgtl5000 0-000a: sgtl5000_set_clock Enter
> sgtl5000 0-000a: sgtl5000_readable Enter
> sgtl5000 0-000a: sgtl5000_volatile Enter
> sgtl5000 0-000a: sgtl5000_readable Enter
> sgtl5000 0-000a: sgtl5000_volatile Enter
> sgtl5000 0-000a: sgtl5000_readable Enter
> sgtl5000 0-000a: sgtl5000_volatile Enter
> sgtl5000 0-000a: sgtl5000_readable Enter
> sgtl5000 0-000a: sgtl5000_volatile Enter
> mxs-saif 80046000.saif: mxs_saif_hw_params
> mxs-saif 80046000.saif: mclk 11289600 rate 22050
> mxs-saif 80046000.saif: master saif0
> mxs-saif 80046000.saif: mxs_saif_prepare
> sgtl5000 0-000a: sgtl5000_set_bias_level Enter
> sgtl5000 0-000a: power_vag_event event 1
> sgtl5000 0-000a: sgtl5000_readable Enter
> sgtl5000 0-000a: sgtl5000_volatile Enter
> sgtl5000 0-000a: sgtl5000_readable Enter
> sgtl5000 0-000a: sgtl5000_volatile Enter
> sgtl5000 0-000a: sgtl5000_readable Enter
> sgtl5000 0-000a: sgtl5000_volatile Enter
> sgtl5000 0-000a: sgtl5000_readable Enter
> sgtl5000 0-000a: sgtl5000_volatile Enter
> sgtl5000 0-000a: power_vag_event event 2
> sgtl5000 0-000a: sgtl5000_readable Enter
> sgtl5000 0-000a: sgtl5000_volatile Enter
> sgtl5000 0-000a: sgtl5000_readable Enter
> sgtl5000 0-000a: sgtl5000_volatile Enter
> sgtl5000 0-000a: sgtl5000_set_bias_level Enter
> mxs-saif 80046000.saif: mxs_saif_trigger
> mxs-saif 80046000.saif: start
> mxs-saif 80046000.saif: CTRL 0x2000807 STAT 0x80000040
> mxs-saif 80042000.saif: CTRL 0x1 STAT 0x80010010
> mxs-saif 80046000.saif: mxs_saif_irq
> mxs-saif 80046000.saif: underrun!!! 1
> mxs-saif 80046000.saif: SAIF_CTRL 2000807 SAIF_STAT 80000001
> mxs-saif 80046000.saif: mxs_saif_trigger
> mxs-saif 80046000.saif: stop
> sgtl5000 0-000a: sgtl5000_set_bias_level Enter
> sgtl5000 0-000a: power_vag_event event 4
> sgtl5000 0-000a: sgtl5000_readable Enter
> sgtl5000 0-000a: sgtl5000_volatile Enter
> sgtl5000 0-000a: sgtl5000_readable Enter
> sgtl5000 0-000a: sgtl5000_volatile Enter
> sgtl5000 0-000a: sgtl5000_readable Enter
> sgtl5000 0-000a: sgtl5000_volatile Enter
> sgtl5000 0-000a: sgtl5000_readable Enter
> sgtl5000 0-000a: sgtl5000_volatile Enter
> sgtl5000 0-000a: sgtl5000_readable Enter
> sgtl5000 0-000a: sgtl5000_volatile Enter
> sgtl5000 0-000a: sgtl5000_readable Enter
> sgtl5000 0-000a: sgtl5000_volatile Enter
> sgtl5000 0-000a: sgtl5000_readable Enter
> sgtl5000 0-000a: sgtl5000_volatile Enter
> sgtl5000 0-000a: power_vag_event event 8
> sgtl5000 0-000a: sgtl5000_set_bias_level Enter
>

and the file /tmp/sample.wav is correctly created:
-rw-r--r--  1 root root 441044 Jan  1 00:01 sample.wav

and now dmesg output of EK340 with the same command:

> mxs-saif 80046000.saif: mxs_saif_startup
> sgtl5000 0-000a: sgtl5000_set_dai_sysclk Enter
> mxs-saif 80046000.saif: mxs_saif_set_dai_sysclk CLKID: 0 FREQ: 11289600 DIR: 0
> sgtl5000 0-000a: sgtl5000_set_dai_fmt Enter fmt: 16385
> sgtl5000 0-000a: sgtl5000_readable Enter
> sgtl5000 0-000a: sgtl5000_volatile Enter
> mxs-saif 80046000.saif: mxs_saif_set_dai_fmt fmt: 16385
> sgtl5000 0-000a: sgtl5000_pcm_hw_params Enter
> sgtl5000 0-000a: sgtl5000_readable Enter
> sgtl5000 0-000a: sgtl5000_volatile Enter
> sgtl5000 0-000a: sgtl5000_set_clock Enter
> sgtl5000 0-000a: sgtl5000_readable Enter
> sgtl5000 0-000a: sgtl5000_volatile Enter
> sgtl5000 0-000a: sgtl5000_readable Enter
> sgtl5000 0-000a: sgtl5000_volatile Enter
> sgtl5000 0-000a: sgtl5000_readable Enter
> sgtl5000 0-000a: sgtl5000_volatile Enter
> sgtl5000 0-000a: sgtl5000_readable Enter
> sgtl5000 0-000a: sgtl5000_volatile Enter
> mxs-saif 80046000.saif: mxs_saif_hw_params
> mxs-saif 80046000.saif: mclk 11289600 rate 22050
> mxs-saif 80046000.saif: master saif0
> mxs-saif 80046000.saif: mxs_saif_prepare
> sgtl5000 0-000a: sgtl5000_set_bias_level Enter
> sgtl5000 0-000a: power_vag_event event 1
> sgtl5000 0-000a: sgtl5000_readable Enter
> sgtl5000 0-000a: sgtl5000_volatile Enter
> sgtl5000 0-000a: sgtl5000_readable Enter
> sgtl5000 0-000a: sgtl5000_volatile Enter
> sgtl5000 0-000a: sgtl5000_readable Enter
> sgtl5000 0-000a: sgtl5000_volatile Enter
> sgtl5000 0-000a: sgtl5000_readable Enter
> sgtl5000 0-000a: sgtl5000_volatile Enter
> sgtl5000 0-000a: power_vag_event event 2
> sgtl5000 0-000a: sgtl5000_readable Enter
> sgtl5000 0-000a: sgtl5000_volatile Enter
> sgtl5000 0-000a: sgtl5000_readable Enter
> sgtl5000 0-000a: sgtl5000_volatile Enter
> sgtl5000 0-000a: sgtl5000_set_bias_level Enter
> mxs-saif 80046000.saif: mxs_saif_trigger
> mxs-saif 80046000.saif: start
> mxs-saif 80046000.saif: CTRL 0x2000807 STAT 0x80000040
> mxs-saif 80042000.saif: CTRL 0x1 STAT 0x80010010
> mxs-saif 80046000.saif: mxs_saif_irq
> mxs-saif 80046000.saif: underrun!!! 1
> mxs-saif 80046000.saif: SAIF_CTRL 2000807 SAIF_STAT 80000000
> mxs-saif 80046000.saif: mxs_saif_trigger
> mxs-saif 80046000.saif: stop
> sgtl5000 0-000a: sgtl5000_set_bias_level Enter
> sgtl5000 0-000a: power_vag_event event 4
> sgtl5000 0-000a: sgtl5000_readable Enter
> sgtl5000 0-000a: sgtl5000_volatile Enter
> sgtl5000 0-000a: sgtl5000_readable Enter
> sgtl5000 0-000a: sgtl5000_volatile Enter
> sgtl5000 0-000a: sgtl5000_readable Enter
> sgtl5000 0-000a: sgtl5000_volatile Enter
> sgtl5000 0-000a: sgtl5000_readable Enter
> sgtl5000 0-000a: sgtl5000_volatile Enter
> sgtl5000 0-000a: sgtl5000_readable Enter
> sgtl5000 0-000a: sgtl5000_volatile Enter
> sgtl5000 0-000a: sgtl5000_readable Enter
> sgtl5000 0-000a: sgtl5000_volatile Enter
> sgtl5000 0-000a: sgtl5000_readable Enter
> sgtl5000 0-000a: sgtl5000_volatile Enter
> sgtl5000 0-000a: power_vag_event event 8
> sgtl5000 0-000a: sgtl5000_set_bias_level Enter

The only difference to me is the SAIF_STAT value into the mxs_saif_irq() 
function:
- on IMX28EVK it is 80000001 that means BUSY, and in the EK340 it is 
80000000 that is NOT BUSY.

What is it happening????


On 05/29/2015 04:48 PM, gianluca wrote:
> On 05/29/2015 03:50 PM, Fabio Estevam wrote:
>>> Now we need to record some sounds as soon as the SGTL5000 has the
>>> SAIF1 line
>>> used for caputure (line in / mic in).
>>
>> Does recording work on mx28evk with 4.0.4?
>>
>
> Well, is that linux kernel version so important? I can surely say it
> works with 3.12.1.
>
> Porting to 4.0.4 means a (partial) rewrite of some device-tree files. I
> can do in a couple of days if you want. But I think I can check out what
> is really happened in our board. Something related to dma / irq??
>
> In IMX28EVK it works out-of-the-box, in EK340 it does not.
>
> Regarding at the last mail I can clearly see:
>
>> When recording from IMX28EVK boards here is the SAIF1_STAT register
>> (0x80046010):
>> 0x80000001 (BIT31 PRESENT and BIT0 BUSY)
>> ...
>> 0x80010001 (BIT31 PRESENT, BIT16 DMA_PREQ and BIT0 BUSY)
>> ...
>> 0x80000001 (BIT31 PRESENT and BIT0 BUSY)
>> ...
>> 0x80010001 (BIT31 PRESENT, BIT16 DMA_PREQ and BIT0 BUSY)
>>
>> and when finishing recording:
>>
>> 0x80010010 (BIT31 PRESENT, BIT16 DMA_PREQ and BIT4 FIFO_SERVICE_IRQ)
>>
>> in the EK340 while recording (0x80046010):
>> 0x80000000 (BIT31 PRESENT)
>> ...
>> ...
>> ...
>> 0x80000000 (BIT31 PRESENT)
>>
>> and finally:
>>> # arecord: pcm_read:1801: read error: Input/output error
>>
>>> # devmem2 0x80046010
>>> /dev/mem opened.
>>> Memory mapped at address 0xb6f07000.
>>> Value at address 0x80046010 (0xb6f07010): 0x80000000
>>
>> It seems no IRQ or DMA actions are involved in EK340 for recording.
>> May be I have some DMA Clash or IRQ bad handling? In the device tree I
>> cannot see anything wrong... Some other driver is using the same DMA
>> Channel for SAIF1 ?????
>>
>> Anyway here is the cat /proc/interrupts for IMX28EVK:
>>>
>>> # cat /proc/interrupts
>>>            CPU0
>>>  16:      32790         -  48  MXS Timer Tick
>>>  17:       5327         -  82  mxs-dma
>>>  18:          0         -  83  mxs-dma
>>>  25:          6         -  96  mxs-mmc
>>>  26:          0         -  97  mxs-mmc
>>> 195:          0         -  80  mxs-dma
>>> 196:        141         -  81  mxs-dma
>>> 197:         73         -  68  mxs-dma
>>> 213:          0         -  59  mxs-saif
>>> 214:          2         -  58  mxs-saif
>>> 215:          0         -  10  mxs-lradc-touchscreen
>>> 216:          0         -  14  mxs-lradc-thresh0
>>> 217:          0         -  15  mxs-lradc-thresh1
>>> 218:          0         -  16  mxs-lradc-channel0
>>> 219:          0         -  17  mxs-lradc-channel1
>>> 220:          0         -  18  mxs-lradc-channel2
>>> 221:          0         -  19  mxs-lradc-channel3
>>> 222:          0         -  20  mxs-lradc-channel4
>>> 223:          0         -  21  mxs-lradc-channel5
>>> 224:          0         -  22  mxs-lradc-channel6
>>> 225:          0         -  23  mxs-lradc-channel7
>>> 226:          0         -  24  mxs-lradc-button0
>>> 227:          0         -  25  mxs-lradc-button1
>>> 228:          0         -  29  RTC alarm
>>> 229:         79         - 111  80058000.i2c
>>> 233:          0         - 112  8006a000.serial
>>> 234:          0         - 115  80070000.serial
>>> 235:       1759         -  47  uart-pl011
>>> 236:          0         -  93  ci_hdrc_imx
>>> 237:          0         -  92  ci_hdrc_imx
>>> 238:         64         - 101  800f0000.ethernet
>>> 239:          0         - 102  800f4000.ethernet
>>> Err:          0
>>
>> I suppose IRQ 196 and 197 are used for SAIF core because I can see
>> them changing when recording...
>>
>>
>> and here the same for EK340:
>>
>>> # cat /proc/interrupts
>>>            CPU0
>>>  16:      28189         -  48  MXS Timer Tick
>>>  17:       6735         -  82  mxs-dma
>>>  18:          0         -  83  mxs-dma
>>>  20:        989         -  85  mxs-dma
>>>  25:         11         -  96  mxs-mmc
>>>  26:          0         -  97  mxs-mmc
>>>  27:         24         -  99  mxs-sdio
>>>  48:          0  gpio-mxs  19  80064000.pwm
>>> 196:          0         -  80  mxs-dma
>>> 197:          0         -  81  mxs-dma
>>> 198:         76         -  68  mxs-dma
>>> 199:          0         -  69  mxs-dma
>>> 213:          0         -  59  mxs-saif
>>> 214:          3         -  58  mxs-saif
>>> 215:          1         -  10  mxs-lradc-touchscreen
>>> 216:          0         -  14  mxs-lradc-thresh0
>>> 217:          0         -  15  mxs-lradc-thresh1
>>> 218:          0         -  16  mxs-lradc-channel0
>>> 219:          0         -  17  mxs-lradc-channel1
>>> 220:          0         -  18  mxs-lradc-channel2
>>> 221:          0         -  19  mxs-lradc-channel3
>>> 222:          0         -  20  mxs-lradc-channel4
>>> 223:          0         -  21  mxs-lradc-channel5
>>> 224:          0         -  22  mxs-lradc-channel6
>>> 225:          0         -  23  mxs-lradc-channel7
>>> 226:          0         -  24  mxs-lradc-button0
>>> 227:          0         -  25  mxs-lradc-button1
>>> 228:          0         -  29  RTC alarm
>>> 229:         84         - 111  80058000.i2c
>>> 230:          0         - 110  8005a000.i2c
>>> 234:          0         - 113  8006c000.serial
>>> 235:          0         - 114  8006e000.serial
>>> 236:       2062         -  47  uart-pl011
>>> 237:          0         -  93  ci_hdrc_imx
>>> 238:          0         -  92  ci_hdrc_imx
>>> 239:         64         - 101  800f0000.ethernet
>>> Err:          0
>>
>> When recording in EK340, the only IRQ is changing between recording
>> sessions is the 198, but it is not present in the IMX28EVK...
>>
>> Some device-tree clash???
>
> On the EK340 I have 3 sdconnector and I use the SDIO3 for wifi. On the
> IMX28EVK I still have only two sd-card connector.
> Is it something related to it?
>
> the IRQs number 198 and 199 what do they mean?? How can I check where
> they are claimed??
>


-- 
Eurek s.r.l.                          |
Electronic Engineering                | http://www.eurek.it
via Celletta 8/B, 40026 Imola, Italy  | Phone: +39-(0)542-609120
p.iva 00690621206 - c.f. 04020030377  | Fax:   +39-(0)542-609212
