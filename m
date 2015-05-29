From: gianluca <gianlucarenzi@eurekelettronica.it>
Subject: Re: Still have problems/issues using SGTL5000 with
	i.MX28 CPU
Date: Fri, 29 May 2015 10:41:34 +0200
Message-ID: <5568263E.1040006@eurekelettronica.it>
References: <55681B8B.6010700@eurekelettronica.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx7.acantho.net (mx7.acantho.net [213.174.182.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 4729726043E
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2015 10:44:02 +0200 (CEST)
Received: (from root@localhost)
 by mx7.acantho.net (8.14.3/8.13.4/Debian-3sarge1) id t4T8hfU2000618
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2015 10:43:41 +0200
In-Reply-To: <55681B8B.6010700@eurekelettronica.it>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: fabio.estevam@freescale.com
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Peter Chen <peter.chen@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 05/29/2015 09:55 AM, gianluca wrote:

>
> and this morning I found this too:
>
>> https://community.freescale.com/message/496426#496426
>
> Now I can check this out too, but I am very UNCONFIDENT it will NO
> USEFUL to me, as in the EVK everything is working, meanwhile in EK340 it
> does not work for record, but only for playback... :-(
>
> Last but not least the boards are different by SoC version:
>
> IMX28EVK is using i.MX287
> EK340    is using i.MX286
>

I did some steps ahead:

When recording from IMX28EVK boards here is the SAIF1_STAT register 
(0x80046010):
0x80000001 (BIT31 PRESENT and BIT0 BUSY)
...
0x80010001 (BIT31 PRESENT, BIT16 DMA_PREQ and BIT0 BUSY)
...
0x80000001 (BIT31 PRESENT and BIT0 BUSY)
...
0x80010001 (BIT31 PRESENT, BIT16 DMA_PREQ and BIT0 BUSY)

and when finishing recording:

0x80010010 (BIT31 PRESENT, BIT16 DMA_PREQ and BIT4 FIFO_SERVICE_IRQ)

in the EK340 while recording (0x80046010):
0x80000000 (BIT31 PRESENT)
...
...
...
0x80000000 (BIT31 PRESENT)

and finally:
> # arecord: pcm_read:1801: read error: Input/output error

> # devmem2 0x80046010
> /dev/mem opened.
> Memory mapped at address 0xb6f07000.
> Value at address 0x80046010 (0xb6f07010): 0x80000000

It seems no IRQ or DMA actions are involved in EK340 for recording.
May be I have some DMA Clash or IRQ bad handling? In the device tree I 
cannot see anything wrong... Some other driver is using the same DMA 
Channel for SAIF1 ?????

Anyway here is the cat /proc/interrupts for IMX28EVK:
>
> # cat /proc/interrupts
>            CPU0
>  16:      32790         -  48  MXS Timer Tick
>  17:       5327         -  82  mxs-dma
>  18:          0         -  83  mxs-dma
>  25:          6         -  96  mxs-mmc
>  26:          0         -  97  mxs-mmc
> 195:          0         -  80  mxs-dma
> 196:        141         -  81  mxs-dma
> 197:         73         -  68  mxs-dma
> 213:          0         -  59  mxs-saif
> 214:          2         -  58  mxs-saif
> 215:          0         -  10  mxs-lradc-touchscreen
> 216:          0         -  14  mxs-lradc-thresh0
> 217:          0         -  15  mxs-lradc-thresh1
> 218:          0         -  16  mxs-lradc-channel0
> 219:          0         -  17  mxs-lradc-channel1
> 220:          0         -  18  mxs-lradc-channel2
> 221:          0         -  19  mxs-lradc-channel3
> 222:          0         -  20  mxs-lradc-channel4
> 223:          0         -  21  mxs-lradc-channel5
> 224:          0         -  22  mxs-lradc-channel6
> 225:          0         -  23  mxs-lradc-channel7
> 226:          0         -  24  mxs-lradc-button0
> 227:          0         -  25  mxs-lradc-button1
> 228:          0         -  29  RTC alarm
> 229:         79         - 111  80058000.i2c
> 233:          0         - 112  8006a000.serial
> 234:          0         - 115  80070000.serial
> 235:       1759         -  47  uart-pl011
> 236:          0         -  93  ci_hdrc_imx
> 237:          0         -  92  ci_hdrc_imx
> 238:         64         - 101  800f0000.ethernet
> 239:          0         - 102  800f4000.ethernet
> Err:          0

I suppose IRQ 196 and 197 are used for SAIF core because I can see them 
changing when recording...


and here the same for EK340:

> # cat /proc/interrupts
>            CPU0
>  16:      28189         -  48  MXS Timer Tick
>  17:       6735         -  82  mxs-dma
>  18:          0         -  83  mxs-dma
>  20:        989         -  85  mxs-dma
>  25:         11         -  96  mxs-mmc
>  26:          0         -  97  mxs-mmc
>  27:         24         -  99  mxs-sdio
>  48:          0  gpio-mxs  19  80064000.pwm
> 196:          0         -  80  mxs-dma
> 197:          0         -  81  mxs-dma
> 198:         76         -  68  mxs-dma
> 199:          0         -  69  mxs-dma
> 213:          0         -  59  mxs-saif
> 214:          3         -  58  mxs-saif
> 215:          1         -  10  mxs-lradc-touchscreen
> 216:          0         -  14  mxs-lradc-thresh0
> 217:          0         -  15  mxs-lradc-thresh1
> 218:          0         -  16  mxs-lradc-channel0
> 219:          0         -  17  mxs-lradc-channel1
> 220:          0         -  18  mxs-lradc-channel2
> 221:          0         -  19  mxs-lradc-channel3
> 222:          0         -  20  mxs-lradc-channel4
> 223:          0         -  21  mxs-lradc-channel5
> 224:          0         -  22  mxs-lradc-channel6
> 225:          0         -  23  mxs-lradc-channel7
> 226:          0         -  24  mxs-lradc-button0
> 227:          0         -  25  mxs-lradc-button1
> 228:          0         -  29  RTC alarm
> 229:         84         - 111  80058000.i2c
> 230:          0         - 110  8005a000.i2c
> 234:          0         - 113  8006c000.serial
> 235:          0         - 114  8006e000.serial
> 236:       2062         -  47  uart-pl011
> 237:          0         -  93  ci_hdrc_imx
> 238:          0         -  92  ci_hdrc_imx
> 239:         64         - 101  800f0000.ethernet
> Err:          0

When recording in EK340, the only IRQ is changing between recording 
sessions is the 198, but it is not present in the IMX28EVK...

Some device-tree clash???


Regards,
-- 
Eurek s.r.l.                          |
Electronic Engineering                | http://www.eurek.it
via Celletta 8/B, 40026 Imola, Italy  | Phone: +39-(0)542-609120
p.iva 00690621206 - c.f. 04020030377  | Fax:   +39-(0)542-609212
