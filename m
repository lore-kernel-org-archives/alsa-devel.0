From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: snd_pcm_avail_update() needed before
	snd_pcm_delay() with hda-intel
Date: Fri, 6 Jun 2008 20:46:12 -0400
Message-ID: <75b66ecd0806061746r1f542ed2i6c966465c1475152@mail.gmail.com>
References: <8235e6f40806061254v41604524l4e43647482602098@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.245])
	by alsa0.perex.cz (Postfix) with ESMTP id 3FEA624534
	for <alsa-devel@alsa-project.org>;
	Sat,  7 Jun 2008 02:46:16 +0200 (CEST)
Received: by rv-out-0708.google.com with SMTP id f25so1263623rvb.32
	for <alsa-devel@alsa-project.org>; Fri, 06 Jun 2008 17:46:12 -0700 (PDT)
In-Reply-To: <8235e6f40806061254v41604524l4e43647482602098@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Christian Morales Vega <cmorve69@yahoo.es>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 6, 2008 at 3:54 PM, Christian Morales Vega
<cmorve69@yahoo.es> wrote:
> snd_pcm_avail_update() documentation says: "Using of this function is
> useless for the standard read/write operations. Use it only for mmap
> access. See to snd_pcm_delay."
>
> snd_pcm_delay() documentation says: "Note this function does not
> update the actual r/w pointer for applications. The function
> snd_pcm_avail_update() have to be called before any begin+commit
> operation."
>
> My english is far from perfect, and so the problem can be that I
> missunderstood the docs but:
> 1- "Using of this function"? Should not be "Use of this function"?

I would just say "This function is useless for...".

> 2- Is snd_pcm_avail_update() really useless when not using mmap?

The pcm.c example referenced right below that comment would indicate otherwise:

http://www.alsa-project.org/alsa-doc/alsa-lib/group___p_c_m.html#g41ca534658076885d9b077ad674750cd

> I have a SB Live! where snd_pcm_delay() always returns the correct
> value, without any need for snd_pcm_avail_update(). But the same code
> in the same machine with an hda-intel AD1988 needs a call to
> snd_pcm_avail_update() before snd_pcm_delay() to give the correct
> result. Without it snd_pcm_delay() always returns the value that *was*
> correct in the last snd_pcm_writei() call.
>
> So should the "application frame position" be always updated, or only
> in read/write operations? In the first case AD1988 fails, in the
> second case perhaps SB Live! is making too mucho work ;-)

Is this with the latest ALSA HG sources?

The SBLive driver is better working and more mature, so I'd presume it
to be correct.  Takashi-san?

Lee
