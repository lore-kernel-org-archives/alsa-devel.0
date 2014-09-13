From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: Master Plan on rewinding
Date: Sat, 13 Sep 2014 16:43:26 +0600
Message-ID: <54141FCE.7010806@gmail.com>
References: <540C76E0.9050808@gmail.com>	<CAN8cciZcnJ4sM37-nCiYa4F98O5=jcQpXD+ApKip1d4T+-6m9g@mail.gmail.com>	<541132F2.6040201@gmail.com>
 <CAN8ccibVYiDO8_rZYS-NR5A_QB3B0HA_7qZX8EMm8w_ANx6kaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f45.google.com (mail-la0-f45.google.com
 [209.85.215.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A28A261ADC
 for <alsa-devel@alsa-project.org>; Sat, 13 Sep 2014 12:43:28 +0200 (CEST)
Received: by mail-la0-f45.google.com with SMTP id b17so2330495lan.18
 for <alsa-devel@alsa-project.org>; Sat, 13 Sep 2014 03:43:28 -0700 (PDT)
In-Reply-To: <CAN8ccibVYiDO8_rZYS-NR5A_QB3B0HA_7qZX8EMm8w_ANx6kaw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, David Henningsson <david.henningsson@canonical.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

13.09.2014 14:57, Raymond Yau wrote:
>
>  >>
>  >>  >
>  >>  > On my desktop PC, on snd-hda-intel with analog outputs for S16LE
>  >> stereo, the granularity is 32 bytes (= 8 samples), and I get the pointer
>  >> granularity of 64 bytes (=16 samples) over HDMI. The minimum period size
>  >> is 32 samples in both cases.
>  >>
>  >> Do you mean hda-Intel does not support arbritray period size when you
>  >> say the granularity is 32 bytes ?
>  >>
>  >> However the granularity of the emulated hda sound card inside any VM
>  >> depend on the vm and the backend audio system and sound card
>  >
>  >
>  > The precise meaning is defined here:
>  >
>  > http://mailman.alsa-project.org/pipermail/alsa-devel/2014-May/076475.html
>
> Do you mean the different hda controllers may have different granularity ?

Yes. My two hda controllers have different granularity.

> Do your two hda controllers have different Fifo size ?

If you mean the result of snd_pcm_hw_params_get_fifo_size(), then both 
cards return 0. I call this function after snd_pcm_hw_params(), as 
recommended by the documentation.

-- 
Alexander E. Patrakov
