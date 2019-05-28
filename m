From: Connor McAdams <conmanx360@gmail.com>
Subject: Re: Merging the new firmware files for CA0132 into
	alsa-firmware
Date: Tue, 28 May 2019 15:24:39 -0400
Message-ID: <CAM8Agx3cs-SbE0zw+UExnS0JVo77Q-h40sef3XesBex+2AeL9A@mail.gmail.com>
References: <s5hblzmvdcq.wl-tiwai@suse.de>
 <9668d632-c5c9-5114-39cb-0e8a105a547c@perex.cz>
 <s5ha7f679o6.wl-tiwai@suse.de> <58dfb36f-47ba-c62f-c39d-e05d000159b7@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EC474F8072E
 for <alsa-devel@alsa-project.org>; Tue, 28 May 2019 21:28:17 +0200 (CEST)
Received: by mail-ot1-x329.google.com with SMTP id i2so18870417otr.9
 for <alsa-devel@alsa-project.org>; Tue, 28 May 2019 12:28:17 -0700 (PDT)
In-Reply-To: <58dfb36f-47ba-c62f-c39d-e05d000159b7@perex.cz>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Yes, I did end up getting permission from Creative themselves to
redistribute the files. That was back in November of 2018.

I also asked them to email Takashi Iwai to confirm, which I think they
ended up doing.

My contact within Creative has not responded since December of 2018,
when I asked for a name to go with the email he told me to use for the
sign-off, and I think that was why the Linux firmware people weren't
willing to accept it.

If you need any more information, let me know.

On Tue, May 28, 2019 at 3:19 PM Jaroslav Kysela <perex@perex.cz> wrote:
>
> Dne 28. 05. 19 v 19:47 Takashi Iwai napsal(a):
> > On Tue, 28 May 2019 18:38:48 +0200,
> > Jaroslav Kysela wrote:
> >>
> >> Dne 28. 05. 19 v 16:54 Takashi Iwai napsal(a):
> >>> Hi,
> >>>
> >>> it seems that Connor's previous attempt to put a couple of ca0132
> >>> firmware files into linux-firmware tree didn't go through,
> >>> unfortunately.  And now I'm thinking of taking them into alsa-firmware
> >>> package as a stop-gap.  We already distribute other ca0132 firmware
> >>> files, so the addition shouldn't be a big problem.
> >>>
> >>> Jaroslav, what do you think?
> >>
> >> No problem. The same situation is for the SoC SOF firmware files (drivers are
> >> in kernel, firmware files are missing). Perhaps, we can release those files
> >> quickly in alsa-firmware and then migrate them slowly to linux-firmware.
> >
> > OK, now pushed to alsa-firmware git repo.
> >
> > BTW, the situation is slightly different from SOF.  At this time, the
> > problem was that it's been submitted by a third person.
>
> Ok, so we don't have a licence for those files? Connor, have you tried to
> contact Creative for a permission to use/distribute those files?
>
>                                                 Jaroslav
>
> --
> Jaroslav Kysela <perex@perex.cz>
> Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
