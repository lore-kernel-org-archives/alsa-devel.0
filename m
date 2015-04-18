From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: Assert in pcm_params.c
Date: Sat, 18 Apr 2015 12:07:26 +0100
Message-ID: <201504181207.26711.gineera@aspect135.co.uk>
References: <201504180908.47022.gineera@aspect135.co.uk>
 <CAN8cciYukOJMwfcmnss+QdTCuNN4=4pi11aOSCHNjyaKO-Komw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from 5.array2.smtp.34sp.com (5.array2.smtp.34sp.com [46.183.10.83])
 by alsa0.perex.cz (Postfix) with ESMTP id BC3312615F7
 for <alsa-devel@alsa-project.org>; Sat, 18 Apr 2015 13:05:08 +0200 (CEST)
Received: from smtpauth1.array1.smtp.34sp.com (lvs3.34sp.com [80.82.124.221])
 by 5.array2.smtp.34sp.com (Postfix) with ESMTP id C120420293
 for <alsa-devel@alsa-project.org>; Sat, 18 Apr 2015 12:05:04 +0100 (BST)
In-Reply-To: <CAN8cciYukOJMwfcmnss+QdTCuNN4=4pi11aOSCHNjyaKO-Komw@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On Saturday 18 April 2015 09:54, Raymond Yau wrote:
> > Hi,
> >
> > The following assert is being hit in pcm_params.c:
> >
> > "pcm_params.c:2249: snd1_pcm_hw_params_slave: Assertion `err >= 0'>
> > failed."
>
> > This is from a developer using Portaudio in his own application; I have
> > yet to ascertain full details, but it is trying successive sample rates to 
> > see which are valid.
> >
> > Does this point to a flaw in the configuration or possibly a bug in
> > Alsa-lib or can it occur just as a result of misuse of the Alsa API?
>
> http://www.alsa-project.org/alsa-doc/alsa-lib/group___p_c_m___h_w___params.
>html
>
> Only snd_pcm_hw_params_test_rate() can be call multiple times,
> Verify if a rate is available inside a configuration space for a PCM.
>
> Those snd_pcm_hw_params_ser_rate*  functions restrict the configuration
> space to one rate and can be called once only

The stream is being opened and closed at each attempt.

Regards

Alan
