From: Diego Buffa <diego.buffa@gmail.com>
Subject: Re: standard read/write vs event waiting routines
 (poll) in ALSA
Date: Thu, 1 Aug 2019 11:04:17 +0200
Message-ID: <CAFwn9n3E1_qxi=xioM2+G8NFhppLEZBNWe1A6gW4iU=CGZavzQ@mail.gmail.com>
References: <CAFwn9n1mL0tE8CaD+tF1vWBQv-E5hidz3B12WiHzxRhvpHs8fQ@mail.gmail.com>
 <6d91a30f-07a0-d5cc-6796-7480ed4e6989@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 546CCF804CB
 for <alsa-devel@alsa-project.org>; Thu,  1 Aug 2019 11:04:55 +0200 (CEST)
Received: by mail-yb1-xb2e.google.com with SMTP id x188so3255507yba.8
 for <alsa-devel@alsa-project.org>; Thu, 01 Aug 2019 02:04:55 -0700 (PDT)
In-Reply-To: <6d91a30f-07a0-d5cc-6796-7480ed4e6989@perex.cz>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Jaroslav,
many thanks for your answer, if I understand correctly pcmjob.c, you are
polling on capture, play and ctrl files (thread_job1).
So in this case it is clear the scope of the polling, sorry I just look at
https://www.alsa-project.org/alsa-doc/alsa-lib/_2test_2pcm_8c-example.html and
I was not understanding the advantage of using poll.

Regards,
d.

On Wed, Jul 31, 2019 at 7:03 PM Jaroslav Kysela <perex@perex.cz> wrote:

> Dne 31. 07. 19 v 18:05 Diego Buffa napsal(a):
> > Hi all,
> > I am trying to learn more about ALSA, I always used example found in the
> > howtos but now I would go further.
> >
> > I went though ALSA documentation (
> > https://www.alsa-project.org/alsa-doc/alsa-lib/pcm.html) and in the
> > specific the transfer methods.
> > Basically I don't understand the advantages of using poll instead of
> > traditional blocking read/write.
> >
> > Generally I know that using poll I can multiplex I/O on several files,
> but
> > in ALSA I cannot create the poll descriptor array as I want, as I must
> use
> > snd_pcm_poll_descriptors() which requires that the poll descriptor array
> > should have the size returned by snd_pcm_poll_descriptors_count().
> >
> > Am I supposed to realloc the poll array descriptor once I set it up with
> > ALSA, and add my own files? Should I then always check poll array
> > descriptor with snd_pcm_poll_descriptors_revents() before checking my own
> > files? And in this case it is safe to call
> > snd_pcm_poll_descriptors_revents() with a  poll array descriptor bigger
> > than the size returned by snd_pcm_poll_descriptors_count()?
> >
> > Many thanks in advance.
>
> All ALSA poll functions works only with the ALSA file descriptors.
> Basically,
> allocate your pollfd array as big as you like and get the file descriptors
> from ALSA to this array (using the returned count) and check those
> descriptors
> through ALSA (revents function). Look to alsa-utils/alsaloop/pcmjob.c for
> an
> example.
>
>                                                 Jaroslav
>
> --
> Jaroslav Kysela <perex@perex.cz>
> Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
>
