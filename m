From: Vaclav Peroutka <vaclavpe@gmail.com>
Subject: Re: SND-SOC - how to test drivers ?
Date: Wed, 1 Dec 2010 22:18:04 +0100
Message-ID: <AANLkTimeVwGDtbE-L+y_dnScLFPk1E9xTQLjvDScd_NP@mail.gmail.com>
References: <AANLkTikE9aF38vg9WkYAVWTSXY23E7qxkQRyfsBJas6Y@mail.gmail.com>
	<AANLkTimT0aoTP+MghUvvRru83hCyCG_ALKxbvOBOcQTW@mail.gmail.com>
	<AANLkTi=SLNeQ5mEFKztB9cmDh3AUVz0fYOB6LGKzf6nL@mail.gmail.com>
	<AANLkTikBz5t-hUxQYfF6Q_hwyO50hxgxfhhF-FaoAjT4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 265B224425
	for <alsa-devel@alsa-project.org>; Wed,  1 Dec 2010 22:18:05 +0100 (CET)
Received: by wyi11 with SMTP id 11so7406940wyi.38
	for <alsa-devel@alsa-project.org>; Wed, 01 Dec 2010 13:18:04 -0800 (PST)
In-Reply-To: <AANLkTikBz5t-hUxQYfF6Q_hwyO50hxgxfhhF-FaoAjT4@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2010/12/1 Jassi Brar <jassisinghbrar@gmail.com>:
> On Wed, Dec 1, 2010 at 6:14 AM, Vaclav Peroutka <vaclavpe@gmail.com> wrote:
>> 2010/11/23 Jassi Brar <jassisinghbrar@gmail.com>:
>>> On Tue, Nov 23, 2010 at 6:24 AM, Vaclav Peroutka <vaclavpe@gmail.com> wrote:
>>>
>>> How about first making the driver work with some, non-Android, rootfs
>>> that has alsa-utils ?
>>>
>>
>> Hello, I did some progress, but not too much. I am getting "no
>> soundcards found" even if I have /dev/snd and /proc/asound like below.
>> What did I do wrong ?
>
> Please make sure you use the same I2S device (indexed) in ASoC machine
> driver as your board init file adds to the platform.
>

Unfortunately I don't know where to look. In the device the CPU
(s3c6410) has XPCM*0 pins connected to audio card and XPCM*1 pins
routed to GSM modem (not sure about that).

In the kernel sources I have several s3c_i2s sources. The raw one,
then s3c6410_i2s, s3c6410_i2s-v32 and s3c6410_i2s-v40. And they are
very different to each other. I am using s3c6410_i2s-v32 as it is used
in similar project. Anyway I am not sure which i2s file I should
use...

In kernel dmesg I have following:
<6>[    3.006951] Advanced Linux Sound Architecture Driver Version 1.0.18a.
<4>[    3.028690] No device for DAI MAX9880
<4>[    3.037007] No device for DAI s3c-i2s
<4>[    3.045335] [s3c6410_max9880_init][s3c6410_max9880_init]
platform_set_drvdata
<4>[    3.062157] s3c_i2s_probe
<4>[    3.070666] s3c_snd_txctrl
<4>[    3.078908] I2S off
<4>[    3.087042] s3c_snd_rxctrl
<4>[    3.095348] I2S off
<4>[    3.103452] Maxim MAX9880 Audio CODEC 0.12
<4>[    3.111595] max9880_probe assign i2c address
0x10max9880_codec_probe - max9880 found
<6>[    3.130565] max9880: max9880_init
<4>[    3.138988] Entered s3c24xx_pcm_new
<4>[    3.147131] Entered s3c24xx_pcm_preallocate_dma_buffer
<4>[    3.155941] Entered s3c24xx_pcm_preallocate_dma_buffer
<6>[    3.164518] asoc: MAX9880 <-> s3c-i2s mapping ok
<6>[    3.173180] max9880: max9880_dapm_event 769
<6>[    3.173193]
<6>[    3.200174] max9880: max9880_dapm_event 0
<6>[    3.200187]
<6>[    3.216540] max9880: max9880_add_widgets
<6>[    3.216554]
<3>[    3.232180] Failed to add route LMICIN->Mic Input
<6>[    3.240256] max9880: max9880_add_controls
<6>[    3.240271]
<6>[    3.437446] ALSA device list:
<6>[    3.443669]   #0: S3C6410 MAX9880 (MAX9880)
