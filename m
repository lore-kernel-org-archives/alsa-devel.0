From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: standard read/write vs event waiting routines
 (poll) in ALSA
Date: Wed, 31 Jul 2019 19:03:30 +0200
Message-ID: <6d91a30f-07a0-d5cc-6796-7480ed4e6989@perex.cz>
References: <CAFwn9n1mL0tE8CaD+tF1vWBQv-E5hidz3B12WiHzxRhvpHs8fQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7D791F800C0
 for <alsa-devel@alsa-project.org>; Wed, 31 Jul 2019 19:03:33 +0200 (CEST)
In-Reply-To: <CAFwn9n1mL0tE8CaD+tF1vWBQv-E5hidz3B12WiHzxRhvpHs8fQ@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Diego Buffa <diego.buffa@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dne 31. 07. 19 v 18:05 Diego Buffa napsal(a):
> Hi all,
> I am trying to learn more about ALSA, I always used example found in the
> howtos but now I would go further.
> 
> I went though ALSA documentation (
> https://www.alsa-project.org/alsa-doc/alsa-lib/pcm.html) and in the
> specific the transfer methods.
> Basically I don't understand the advantages of using poll instead of
> traditional blocking read/write.
> 
> Generally I know that using poll I can multiplex I/O on several files, but
> in ALSA I cannot create the poll descriptor array as I want, as I must use
> snd_pcm_poll_descriptors() which requires that the poll descriptor array
> should have the size returned by snd_pcm_poll_descriptors_count().
> 
> Am I supposed to realloc the poll array descriptor once I set it up with
> ALSA, and add my own files? Should I then always check poll array
> descriptor with snd_pcm_poll_descriptors_revents() before checking my own
> files? And in this case it is safe to call
> snd_pcm_poll_descriptors_revents() with a  poll array descriptor bigger
> than the size returned by snd_pcm_poll_descriptors_count()?
> 
> Many thanks in advance.

All ALSA poll functions works only with the ALSA file descriptors. Basically,
allocate your pollfd array as big as you like and get the file descriptors
from ALSA to this array (using the returned count) and check those descriptors
through ALSA (revents function). Look to alsa-utils/alsaloop/pcmjob.c for an
example.

						Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
