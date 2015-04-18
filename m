From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Assert in pcm_params.c
Date: Sat, 18 Apr 2015 16:54:00 +0800
Message-ID: <CAN8cciYukOJMwfcmnss+QdTCuNN4=4pi11aOSCHNjyaKO-Komw@mail.gmail.com>
References: <201504180908.47022.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f43.google.com (mail-oi0-f43.google.com
 [209.85.218.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D3B02614EE
 for <alsa-devel@alsa-project.org>; Sat, 18 Apr 2015 10:54:05 +0200 (CEST)
Received: by oign205 with SMTP id n205so92376090oig.2
 for <alsa-devel@alsa-project.org>; Sat, 18 Apr 2015 01:54:02 -0700 (PDT)
In-Reply-To: <201504180908.47022.gineera@aspect135.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alan Horstmann <gineera@aspect135.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>
> Hi,
>
> The following assert is being hit in pcm_params.c:
>
> "pcm_params.c:2249: snd1_pcm_hw_params_slave: Assertion `err >= 0'
failed."
>
> This is from a developer using Portaudio in his own application; I have
yet to
> ascertain full details, but it is trying successive sample rates to see
which
> are valid.
>
> Does this point to a flaw in the configuration or possibly a bug in
Alsa-lib
> or can it occur just as a result of misuse of the Alsa API?
>
>

http://www.alsa-project.org/alsa-doc/alsa-lib/group___p_c_m___h_w___params.html

Only snd_pcm_hw_params_test_rate() can be call multiple times,
Verify if a rate is available inside a configuration space for a PCM.

Those snd_pcm_hw_params_ser_rate*  functions restrict the configuration
space to one rate and can be called once only
