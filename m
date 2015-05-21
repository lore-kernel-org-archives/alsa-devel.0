From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Assert in pcm_params.c
Date: Fri, 22 May 2015 04:29:40 +0800
Message-ID: <CAN8cciahbz-BbySy_0CUxDZ8Ce4cmv7DX48wdbuXfGGj8=x2KQ@mail.gmail.com>
References: <201504180908.47022.gineera@aspect135.co.uk>
 <201505192022.50591.gineera@aspect135.co.uk>
 <s5h4mn7u54s.wl-tiwai@suse.de>
 <201505211656.04334.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f178.google.com (mail-ob0-f178.google.com
 [209.85.214.178])
 by alsa0.perex.cz (Postfix) with ESMTP id E633626587B
 for <alsa-devel@alsa-project.org>; Thu, 21 May 2015 22:29:41 +0200 (CEST)
Received: by obfe9 with SMTP id e9so68986757obf.1
 for <alsa-devel@alsa-project.org>; Thu, 21 May 2015 13:29:41 -0700 (PDT)
In-Reply-To: <201505211656.04334.gineera@aspect135.co.uk>
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

> I've had a positive confirmation that the patch removing the asserts does
fix
> the 'crash' in the reporter's system.  So instead it is simply a failure
of
> the snd_pcm_hw_params() call, which ultimately can be handled in the users
> code.
>
> I do wonder (as does Raymond) why this fails.  Is 6-chans expected to
fail on
> 'front'?  In particular the earlier setting of channels/rate/format does
not
> fail?  Perhaps I will ask for RULES_DEBUG enabled?
>
>

period_max is only 32 , this mean that some combination are not possible
