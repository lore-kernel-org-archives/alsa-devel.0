From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: Assert in pcm_params.c
Date: Mon, 20 Apr 2015 12:31:04 +0100
Message-ID: <201504201231.04341.gineera@aspect135.co.uk>
References: <201504180908.47022.gineera@aspect135.co.uk>
 <201504181207.26711.gineera@aspect135.co.uk>
 <CAN8cciaDr+0sdLPjOD1evTHjA6mSDMasM_ZgDpCanWE1Dbbd6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from 3.array2.smtp.34sp.com (3.array2.smtp.34sp.com [46.183.9.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 13DE62654F6
 for <alsa-devel@alsa-project.org>; Mon, 20 Apr 2015 13:31:00 +0200 (CEST)
Received: from smtpauth2.array1.smtp.34sp.com (lvs3.34sp.com [80.82.124.221])
 by 3.array2.smtp.34sp.com (Postfix) with ESMTP id ACA566B955
 for <alsa-devel@alsa-project.org>; Mon, 20 Apr 2015 12:30:58 +0100 (BST)
In-Reply-To: <CAN8cciaDr+0sdLPjOD1evTHjA6mSDMasM_ZgDpCanWE1Dbbd6w@mail.gmail.com>
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
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Monday 20 April 2015 08:08, you wrote:
> > > > Hi,
> > > >
> > > > The following assert is being hit in pcm_params.c:
> > > >
> > > > "pcm_params.c:2249: snd1_pcm_hw_params_slave: Assertion `err >= 0'>
> > > > failed."
> > > >
> > > > This is from a developer using Portaudio in his own application; I
<snip>
> > > > Does this point to a flaw in the configuration or possibly a bug in
> > > > Alsa-lib or can it occur just as a result of misuse of the Alsa API?
>
> http://www.alsa-project.org/alsa-doc/alsa-lib/group___p_c_m___h_w___params.
> > >
> > > Only snd_pcm_hw_params_test_rate() can be call multiple times,
> > > Verify if a rate is available inside a configuration space for a PCM.
> > >
> > > Those snd_pcm_hw_params_ser_rate*  functions restrict the configuration
> > > space to one rate and can be called once only
> >
> > The stream is being opened and closed at each attempt.
>
> Seem Delta 44 does not support 2,4,6 or 8 channels

This issue is not on Delta44, but an Intel motherboard.  But I would not 
expect to hit an assert in Alsa-lib whatever we do, surely?

Regards

Alan
