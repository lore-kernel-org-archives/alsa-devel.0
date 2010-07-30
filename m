From: Yoran Brondsema <yoran.brondsema@gmail.com>
Subject: Re: Driver for AK4555 codec
Date: Fri, 30 Jul 2010 10:00:12 +0200
Message-ID: <AANLkTin+ZNJD4dizxwK3=ocw3d0YUxZhnX8SkFhVjt9a@mail.gmail.com>
References: <AANLkTimnYLEe-sK2_DcYQAGqVYd+JnsJaSpRfdKBbeEi@mail.gmail.com>
	<20100729184233.GA9469@sirena.org.uk>
	<AANLkTinWJT36u99_vxOqXOADRNBT9VMy_5mOsBLE1PLO@mail.gmail.com>
	<33CE47F6-34E9-4E47-A8F6-C1091C1708D2@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) by alsa0.perex.cz (Postfix) with ESMTP id 5A7C324534
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Jul 2010 10:00:17 +0200 (CEST)
Received: by ywa6 with SMTP id 6so532311ywa.38
	for <alsa-devel@alsa-project.org>; Fri, 30 Jul 2010 01:00:14 -0700 (PDT)
In-Reply-To: <33CE47F6-34E9-4E47-A8F6-C1091C1708D2@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 30 July 2010 08:59, Mark Brown <broonie@opensource.wolfsonmicro.com>wrote:

>  On 29 Jul 2010, at 23:45, Yoran Brondsema <yoran.brondsema@gmail.com>
> wrote:
>
>   On 29 July 2010 20:42, Mark Brown <broonie@opensource.wolfsonmicro.com>wrote:
>
>> On Thu, Jul 29, 2010 at 09:18:43AM +0200, Yoran Brondsema wrote:
>>
>
> Don't drop CCs to the mailing lists; if nothing else advice is often useful
> to other people searching the mailing list archives.
>
>  So my main question is whether I have to write this lpc3xxx-ak4555.c. It
> would be great if someone could clear me up on  this.
>
>
> Yes, you'll have to write a driver for your machine. It says how the CODEC
> and CPU are wired up on your particular board - either component could also
> be used with another device, or another machine may have a different way of
> connecting the same components which requires a different setup.
>

I'm sorry for the CC, did "reply" instead of "reply-to-all". I've modified
an existing driver, and the two driver modules load fine when insmod'ing
them. However, when I run speaker-test I get the following message.
-bash-3.2# ./../../../../../../../tools/alsa-arm-utils/bin/speaker-test
speaker-test 1.0.17
Playback device is default
Stream parameters are 48000Hz, S16_LE, 1 channels
Using 16 octaves of pink noise
Rate set to 48000Hz (requested 48000Hz)
Buffer size range from 128 to 32768
Period size range from 64 to 1024
Using max buffer size 32768
Periods = 4
was set period_size = 1024
was set buffer_size = 32768
 0 - Front Left
Write error: -5,Input/output error
xrun_recovery failed: -5,Input/output error
Transfer failed: Operation not permitted
I checked the speaker-test code, and this happens after a call to
snd_pcm_writei(). The error code is -5, which corresponds to -EIO. In the
snd_pcm_writei() definition, the following code fails.

        if (CHECK_SANITY(! pcm->setup)) {
                SNDMSG("PCM not set up");
                return -EIO;
        }
However, in the init function of the codec driver
(linux/sound/soc/codecs/ak4555.c), I do

       ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1,
SNDRV_DEFAULT_STR1);
        if (ret < 0) {
                pr_err("uda1380: failed to create pcms\n");
                goto pcm_err;
        }
and every time ret >= 0.

What could be wrong?

Thank you,
Yoran
