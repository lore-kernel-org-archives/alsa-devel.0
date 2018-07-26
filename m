From: Rob Duncan <rduncan@tesla.com>
Subject: Re: More snd_pcm_ioplug_avail_update() questions
Date: Thu, 26 Jul 2018 08:02:33 -0700
Message-ID: <dw77emeffqca5y.fsf@tesla.com>
References: <dw77emin53c7a3.fsf@tesla.com> <s5hzhyev5oj.wl-tiwai@suse.de>
 <dw77emfu06cc60.fsf@tesla.com> <s5hmuueysfk.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-0019bd01.pphosted.com (mx0a-0019bd01.pphosted.com
 [148.163.151.57])
 by alsa0.perex.cz (Postfix) with ESMTP id 7DB5B26776E
 for <alsa-devel@alsa-project.org>; Thu, 26 Jul 2018 17:02:35 +0200 (CEST)
In-Reply-To: <s5hmuueysfk.wl-tiwai@suse.de>
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


At 07:37 on Thu, Jul 26 2018, Takashi wrote:
> OK, I seem to have misunderstood about what you meant as committed in
> the context.  Yes, if the available is partial, it might be not
> committed.  But I don't understand the next part.
>
> How will it be discarded at the next snd_pcm_ioplug_avail_update()?
> The data remains on the buffer, and applptr isn't changed.

Yes, that's the problem.  Because when snd_pcm_ioplug_avail_update() is
subsequently called it uses snd_pcm_mmap_begin() to get the offset into
the mmap for the destination of the capture transfer operation.  This is
essentially appl_ptr, which means that the data that has not yet been
commited will be overwritten by the transfer.

I guess that the offset could somehow be adjusted to point to after the
uncommitted data but I don't see a straightforward way to do that.  A
scheme along these lines would also have to adjust the size parameter
accordingly, of course.  This would sometimes mean that we cannot
transfer all the available data from the IO plugin.  Would that cause
any issues?

Rob.
