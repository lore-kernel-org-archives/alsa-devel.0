From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: When select 2.1 profile in pulseaudio,
 how do pulseaudio select notebook 's internal subwoofer or 5.1
 external speaker ?
Date: Wed, 5 Aug 2015 10:51:22 +0800
Message-ID: <CAN8cciby0EvPPB8DvM-efCZdnD_vnzRwL17dZ9EpF65MNVCHnw@mail.gmail.com>
References: <CAN8ccia43iJJOkB9w=XOxHBNtaO52ExJ4brKZCFGT=sxcik0VA@mail.gmail.com>
 <1572017.Cv3FZsEbDC@luklap.workgroup>
 <CAN8ccibtBLuTDv6ABvuFv-HCv=R7ntJfKR64bO=-XjUAOQvcWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f169.google.com (mail-ob0-f169.google.com
 [209.85.214.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 0F1C1261484
 for <alsa-devel@alsa-project.org>; Wed,  5 Aug 2015 04:51:24 +0200 (CEST)
Received: by obdeg2 with SMTP id eg2so21960111obd.0
 for <alsa-devel@alsa-project.org>; Tue, 04 Aug 2015 19:51:23 -0700 (PDT)
In-Reply-To: <CAN8ccibtBLuTDv6ABvuFv-HCv=R7ntJfKR64bO=-XjUAOQvcWg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>, =?UTF-8?B?xYF1a2FzeiBXb2puacWCb3dpY3o=?= <lukasz.wojnilowicz@gmail.com>, tiwai@suse.de, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Anssi Hannula <anssi.hannula@iki.fi>
List-Id: alsa-devel@alsa-project.org

>
> +static const struct snd_pcm_chmap_elem acer_pcm_chmaps[] = {
>
> + { .channels = 2, + .map = { SNDRV_CHMAP_FL, SNDRV_CHMAP_FR } }, + {
.channels = 4, + .map = { SNDRV_CHMAP_FL, SNDRV_CHMAP_FR,
>
> + SNDRV_CHMAP_LFE, SNDRV_CHMAP_NA } }, /* LFE only on left */
>
> + { .channels = 4, + .map = { SNDRV_CHMAP_FL, SNDRV_CHMAP_FR,
>
> + SNDRV_CHMAP_RL, SNDRV_CHMAP_RR } },
>
> + { .channels = 6,
>
> + .map = { SNDRV_CHMAP_FL, SNDRV_CHMAP_FR,
>
> + SNDRV_CHMAP_RL, SNDRV_CHMAP_RR,
>
> + SNDRV_CHMAP_FC, SNDRV_CHMAP_LFE } },
>
> + { }
>
> +};

After testing with ubuntu 15.10 alpha and modified snd-dummy

alsa-lib seem using the first channel map which has FL, FR and LFE , this
mean that 2.1 profile always use your notebook internal speaker/subwoofer
even when your notebook support 5.1 external speakers

this behaviour is different from those desktop with external 5.1 speakers
using 2.1 profile


you may need to implement dynamic channel map which change when line out
jack is plugged if you want to use 2.1 profile with external 5.1 speakers
