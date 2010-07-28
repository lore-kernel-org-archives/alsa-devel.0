From: Adam Rosenberg <adam@alcorn.com>
Subject: using plug for sample format conversion
Date: Wed, 28 Jul 2010 12:55:03 -0400
Message-ID: <AANLkTik=MskE7rGhBmuyDtJTe5BAie7AckiANrheJ8Qi@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51]) by alsa0.perex.cz (Postfix) with ESMTP id 3A653244E0
	for <alsa-devel@alsa-project.org>;
	Wed, 28 Jul 2010 18:55:12 +0200 (CEST)
Received: by pwi6 with SMTP id 6so1156952pwi.38
	for <alsa-devel@alsa-project.org>; Wed, 28 Jul 2010 09:55:12 -0700 (PDT)
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
Cc: superquad.vortex2@gmail.com
List-Id: alsa-devel@alsa-project.org

>> I am trying to use plug to play audio files that are S16_LE but my
>> hardware only supports S32_LE.  It is not working.  Here is an example
>> of the problem using speaker-test.  First I use S32_LE and it works as
>> expected.  I then try S16_LE but it fails.  Does this mean the plug
>> plugin cannot convert between these sample formats?
>>
>> Thanks,
>> Adam
>>
>
>Please use latest version of speaker-test and alsa-lib.
>
>and post struct  snd_pcm_hardware of you driver
>

I am using the latest release of uClinux for Blackfin BF537 and do not
know how to configure and install the latest version of alsa-lib and
alsa-utils.  I am starting to understand how struct snd_pcm_hardware
is used by the ALSA PCM code but you are correct to assume I may have
something wrong.  Here is the struct:

static struct snd_pcm_hardware ourCS42448PcmHw =
{
	.info = (SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER ),
	.formats = SNDRV_PCM_FMTBIT_S32_LE,
	.rates = SNDRV_PCM_RATE_48000,
	.rate_min = 48000,
	.rate_max = 48000,
	.buffer_bytes_max = 32768,
	.channels_min = 1,
	.channels_max = 2,
	.period_bytes_max = 32768,
	.periods_min = 1,
	.period_bytes_min = 8,
	.periods_max = 4096,
};

Can you tell me how to configure and install the latest ALSA and
whether the snd_pcm_hardware is correct?

Thanks,
Adam


Adam Rosenberg
Software Engineer

Alcorn McBride Inc.
3300 South Hiawassee
Building 105
Orlando, FL 32835

(407) 296 - 5800 ext. 5490
