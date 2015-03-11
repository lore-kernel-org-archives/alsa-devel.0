From: Yomi Ogunwumi <abyomi0@gmail.com>
Subject: Re: Issues and/or possible bugs in alsa
Date: Wed, 11 Mar 2015 09:41:45 -0400
Message-ID: <CACui-2k_6R7SG2_o0SO+oLMNz-Lo7zpY6tuvOOYJ1eq7N056hg@mail.gmail.com>
References: <CACui-2k8j3ZWtmvwiE3V5apuQ0g-dn=wN-h4miExDYLLR4diWA@mail.gmail.com>
 <54ED8466.7020102@gmail.com>
 <CAN8cciYnyLahS2gQ0g0vSaNj+xo=Tz9_FQ9L-WazOb1t5no_kA@mail.gmail.com>
 <54F1C10B.2050008@gmail.com> <s5hmw3ygjcx.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f178.google.com (mail-ig0-f178.google.com
 [209.85.213.178])
 by alsa0.perex.cz (Postfix) with ESMTP id F013526530A
 for <alsa-devel@alsa-project.org>; Wed, 11 Mar 2015 14:41:50 +0100 (CET)
Received: by igal13 with SMTP id l13so36742969iga.1
 for <alsa-devel@alsa-project.org>; Wed, 11 Mar 2015 06:41:46 -0700 (PDT)
In-Reply-To: <s5hmw3ygjcx.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Is there anything else I need to do?

On Sat, Feb 28, 2015 at 10:13 AM, Takashi Iwai <tiwai@suse.de> wrote:

> At Sat, 28 Feb 2015 18:22:19 +0500,
> Alexander E. Patrakov wrote:
> >
> > 28.02.2015 15:00, Raymond Yau wrote:
> > >
> > > It is strange that your hdmi card have a softvol control ,
> > >
> > > Was  the softvol control created when you swap the card number by
> > > index=1,0 ?
> > >
> >
> > The control was created when I used a custom asoundrc in order to test
> > dmix on top of hdmi. Since then, I removed the customization, but there
> > is no easy way to remove the control, as it is always saved on shutdown
> > and restored on boot even if there is nothing in the current .asoundrc
> > that uses it. I will remove it from the state file using a livecd, just
> > to avoid such questions in the future.
>
> Right, there is no command so far for removing a user ctl element.
> It's relatively trivial to implement, though, e.g. in amixer or
> alsactl, I guess.  Any taker?
>
>
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>



-- 
*Yomi*
