From: Markus Franke <markus.franke@s2002.tu-chemnitz.de>
Subject: DMA buffer gets played only once
Date: Wed, 05 Sep 2007 11:50:33 +0530
Message-ID: <46DE4AB1.20206@hrz.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from john.hrz.tu-chemnitz.de (john.hrz.tu-chemnitz.de
	[134.109.132.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 326EE10387C
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Sep 2007 08:18:54 +0200 (CEST)
Received: from [203.145.183.24] (helo=dexsys58.DOMAIN.dexceldesigns.com)
	by john.hrz.tu-chemnitz.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.66) (envelope-from <markus.franke@s2002.tu-chemnitz.de>)
	id 1ISoDy-0006TH-VG
	for alsa-devel@alsa-project.org; Wed, 05 Sep 2007 08:18:51 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dear Alsa Developers/Users,

I am working on a SoC Alsa driver for the WM8973. Currently I am facing 
the problem that after playing once the whole preallocated DMA buffer 
the playback stops and Alsa returns with

---snip---
ALSA sound/core/pcm_native.c:1526: playback drain error (DMA or IRQ 
trouble?)
---snap---


As far as I understood the callflow is like this:

pcm_prepare() --> pcm_trigger(TRIGGER_START) --> 
snd_pcm_period_elapsed() from interrupt handler or DMA callback --> 
pcm_pointer() --> pcm_trigger(TRIGGER_STOP) --> pcm_prepare() --> .....

With each call of pcm_trigger(TRIGGER_START) I am transfering one period 
of sounddata. For some reason the playback stops once the DMA buffer (in 
my 8 example it holds 8 periods of data) is finished and the pointer 
should wrap around to the beginning through pcm_pointer() callback. I 
checked return values of pcm_pointer() and tried to trace it back 
through Alsa/SoC stack without success. It seems like that after the 8th 
period is transferred pcm_trigger(TRIGGER_STOP) isn't getting called. 
Instead of this I get a lot of calls to pcm_pointer() which result 
finally in the above mentioned Alsa error message. I checked 
pcm_pointer() return values but everything seems to be fine I think.

Below you can find some verbose printk's I added to the source code:

---snip---
vi1888-i2s: vi1888_i2s_startup()-->
vi1888-pcm: vi1888_pcm_open()-->
vi1888-i2s: vi1888_i2s_set_dai_fmt()-->
vi1888-i2s: vi1888_i2s_set_dai_sysclk()-->
vi1888-i2s: vi1888_i2s_hw_params()-->
vi1888-pcm: vi1888_pcm_hw_params()-->
hw_params: DMA for I2S PCM Stereo out initialized (dma_bytes=32768, 
period_size=4096)
vi1888-i2s: vi1888_i2s_set_dai_fmt()-->
vi1888-i2s: vi1888_i2s_set_dai_sysclk()-->
vi1888-pcm: vi1888_pcm_hw_params()-->
hw_params: DMA for I2S PCM Stereo out initialized (dma_bytes=32768, 
period_size=4096)
vi1888-pcm: vi1888_pcm_prepare()-->
vi1888-i2s: vi1888_i2s_prepare()-->
vi1888-pcm: vi1888_pcm_trigger()-->
vi1888-pcm: vi1888_pcm_dma_userCallback()-->
vi1888-pcm: vi1888_pcm_pointer()-->
pcm_pointer returns 1024
vi1888-pcm: vi1888_pcm_trigger()-->
vi1888-pcm: vi1888_pcm_prepare()-->
vi1888-i2s: vi1888_i2s_prepare()-->
vi1888-pcm: vi1888_pcm_trigger()-->
vi1888-pcm: vi1888_pcm_dma_userCallback()-->
vi1888-pcm: vi1888_pcm_pointer()-->
pcm_pointer returns 2048
vi1888-pcm: vi1888_pcm_trigger()-->
vi1888-pcm: vi1888_pcm_prepare()-->
vi1888-i2s: vi1888_i2s_prepare()-->
vi1888-pcm: vi1888_pcm_trigger()-->
vi1888-pcm: vi1888_pcm_dma_userCallback()-->
vi1888-pcm: vi1888_pcm_pointer()-->
pcm_pointer returns 3072
vi1888-pcm: vi1888_pcm_trigger()-->
vi1888-pcm: vi1888_pcm_prepare()-->
vi1888-i2s: vi1888_i2s_prepare()-->
vi1888-pcm: vi1888_pcm_trigger()-->
vi1888-pcm: vi1888_pcm_dma_userCallback()-->
vi1888-pcm: vi1888_pcm_pointer()-->
pcm_pointer returns 4096
vi1888-pcm: vi1888_pcm_trigger()-->
vi1888-pcm: vi1888_pcm_prepare()-->
vi1888-i2s: vi1888_i2s_prepare()-->
vi1888-pcm: vi1888_pcm_trigger()-->
vi1888-pcm: vi1888_pcm_dma_userCallback()-->
vi1888-pcm: vi1888_pcm_pointer()-->
pcm_pointer returns 5120
vi1888-pcm: vi1888_pcm_trigger()-->
vi1888-pcm: vi1888_pcm_prepare()-->
vi1888-i2s: vi1888_i2s_prepare()-->
vi1888-pcm: vi1888_pcm_trigger()-->
vi1888-pcm: vi1888_pcm_dma_userCallback()-->
vi1888-pcm: vi1888_pcm_pointer()-->
pcm_pointer returns 6144
vi1888-pcm: vi1888_pcm_trigger()-->
vi1888-pcm: vi1888_pcm_prepare()-->
vi1888-i2s: vi1888_i2s_prepare()-->
vi1888-pcm: vi1888_pcm_trigger()-->
vi1888-pcm: vi1888_pcm_dma_userCallback()-->
vi1888-pcm: vi1888_pcm_pointer()-->
pcm_pointer returns 7168
vi1888-pcm: vi1888_pcm_trigger()-->
vi1888-pcm: vi1888_pcm_prepare()-->
vi1888-i2s: vi1888_i2s_prepare()-->
vi1888-pcm: vi1888_pcm_trigger()-->
vi1888-pcm: vi1888_pcm_dma_userCallback()-->
vi1888-pcm: vi1888_pcm_pointer()-->
pcm_pointer returns 0
vi1888-pcm: vi1888_pcm_pointer()-->
pcm_pointer returns 1024
vi1888-pcm: vi1888_pcm_pointer()-->
pcm_pointer returns 2048
vi1888-pcm: vi1888_pcm_pointer()-->
pcm_pointer returns 3072
vi1888-pcm: vi1888_pcm_pointer()-->
pcm_pointer returns 4096
vi1888-pcm: vi1888_pcm_pointer()-->
pcm_pointer returns 5120
vi1888-pcm: vi1888_pcm_pointer()-->
pcm_pointer returns 6144
vi1888-pcm: vi1888_pcm_pointer()-->
pcm_pointer returns 7168
vi1888-pcm: vi1888_pcm_pointer()-->
pcm_pointer returns 0
vi1888-pcm: vi1888_pcm_pointer()-->
pcm_pointer returns 1024

.
.
.
.
.
.
.

ALSA sound/core/pcm_native.c:1526: playback drain error (DMA or IRQ 
trouble?)
---snap---

I get this output when trying to play a 16-bit stereo WAV file.

Thanks for any help on this,

Regards,
Markus Franke
