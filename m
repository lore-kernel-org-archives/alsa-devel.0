From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Strange sound of IDT 82hd206xx6 at font port in
	AC97 mode
Date: Tue, 4 Feb 2014 22:16:31 +0800
Message-ID: <CAN8cciZtetqAFq4uCC_qxN5+FmNRm58g1x2rzVWk4b-Zy3aHRA@mail.gmail.com>
References: <BLU0-SMTP22F128862C405DED98AB89ADAB0@phx.gbl>
 <CAN8cciZ+QwNpSnBmXuvKV9Hkqhfbo6CvY0bmx7rMQic9+tgb8A@mail.gmail.com>
 <BLU0-SMTP39216262BA66E5ED8A80E9BADAA0@phx.gbl>
 <CAN8ccianyNMd02ywO+AtbFoAsTxcm_Q8Fa-ab4hExAXi=Jw0Fw@mail.gmail.com>
 <BLU0-SMTP2290BB01520D451B3C3E1FCADAA0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f51.google.com (mail-qa0-f51.google.com
 [209.85.216.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E5792619E1
 for <alsa-devel@alsa-project.org>; Tue,  4 Feb 2014 15:16:32 +0100 (CET)
Received: by mail-qa0-f51.google.com with SMTP id f11so12391676qae.10
 for <alsa-devel@alsa-project.org>; Tue, 04 Feb 2014 06:16:32 -0800 (PST)
In-Reply-To: <BLU0-SMTP2290BB01520D451B3C3E1FCADAA0@phx.gbl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Randy Li <lxr1234@hotmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> >
> >
> > Simple mixer control 'Swap Center/LFE',0 Capabilities: pswitch
> > pswitch-joined penum Playback channels: Mono Mono: Playback [off]
> >
> >
> >
> > Do this switch change the output of center and lfe when you run
> >
> > speaker-test -c 6 -t wav -D hw:0,0
> >
> I only hear the font left and font right in both side of my
> headphone(the one for android)
> > seem that your are not using latest alsa driver
> The alsa driver? Well, shall I try the latest kernel?

Do the channel swap at the orange rack at rear panel ?

Do you have a speaker to test ?

This switch seem lost in the latest alsa driver
>
