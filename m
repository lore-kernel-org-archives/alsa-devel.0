From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Assert in pcm_params.c
Date: Tue, 18 Feb 2014 15:56:48 +0800
Message-ID: <CAN8cciYO8Wa5hGFZqdpRLrxHdS3Uh4jahcLvqQMJQ_W5YXT9Cw@mail.gmail.com>
References: <201402172056.22076.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f48.google.com (mail-qa0-f48.google.com
 [209.85.216.48])
 by alsa0.perex.cz (Postfix) with ESMTP id E0570265148
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 08:56:50 +0100 (CET)
Received: by mail-qa0-f48.google.com with SMTP id f11so22862819qae.7
 for <alsa-devel@alsa-project.org>; Mon, 17 Feb 2014 23:56:49 -0800 (PST)
In-Reply-To: <201402172056.22076.gineera@aspect135.co.uk>
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
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2014-02-18 4:56 GMT+08:00 Alan Horstmann <gineera@aspect135.co.uk>:

> Hi,
>
> I am trying to assist in a case that is getting this assert:-
>
> pcm_params.c:2249: snd1_pcm_hw_params_slave: Assertion `err >= 0' failed.
>
> and wondered if anyone could shed some light on what is likely to cause
> that,
> and whether it indicates an underlying fault?
>

you need to know which plugin  is used ?

this occur when error return by snd_pcm_xxxxxx_hw_refine_schange in the
plugin

e.g. route plugin in

https://bugzilla.redhat.com/show_bug.cgi?id=1051884



> The system (not mine) runs Linux Mint 13 (kernel 3.2.0) with PulseAudio,
> and
> we are debugging weird behaviour during Portaudio initialisation.  It is
> struggling to get consistent access to the Alsa devices, often retrying
> many
> times.
>
>
