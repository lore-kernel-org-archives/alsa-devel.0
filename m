From: Ricardo Biehl <rbpoficial@gmail.com>
Subject: what is exactly pcm.boundary?
Date: Thu, 5 Jan 2017 16:10:38 -0200
Message-ID: <CAAu8Fse4GcOV5PkgnWQfBSQjM3SoiEurVuhvuNgQ3zD_8TeHbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f43.google.com (mail-wm0-f43.google.com [74.125.82.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 6EB0726776E
 for <alsa-devel@alsa-project.org>; Thu,  5 Jan 2017 19:10:40 +0100 (CET)
Received: by mail-wm0-f43.google.com with SMTP id c85so256550110wmi.1
 for <alsa-devel@alsa-project.org>; Thu, 05 Jan 2017 10:10:40 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello. After some thoughts in ALSA internals (hw_ptr, appl_ptr, mmap'ed buffer,
ioctls) I got me in many doubts. I would love if you help me understanding this.

Well, in src/pcm/pcm_local.h  line ~469:

1	static inline snd_pcm_uframes_t snd_pcm_mmap_playback_avail(snd_pcm_t *pcm)
2	{
3		snd_pcm_sframes_t avail;
4		avail = *pcm->hw.ptr + pcm->buffer_size - *pcm->appl.ptr;
5		if (avail < 0)
6			avail += pcm->boundary;
7		else if ((snd_pcm_uframes_t) avail >= pcm->boundary)
8			avail -= pcm->boundary;
9		return avail;
10	}

First, I assumed that both hw_ptr and appl_ptr always points to addresses inside
a REGION of memory that is exactly the size of buffer = (period_size * periods).

I've also tried to imagine line 4 as: The forward distance between appl_ptr and
hw_ptr where our application can write new samples:
	|s0|s1|s2|s3|s4|s5|s6|s7|s8|s9|    buffer_size = 10
For example, if hw_ptr is on 's1' and appl_ptr is on 's7' we'll have
( 1 + 10 - 7 = 4 ) [s8,s9,s0,s1] available to write, right?

	hw_ptr = Last sample that sound device has eaten up in ring buffer.
	appl_ptr = Last sample that application has written in ring buffer.

Ok, the problem comes, for example, when hw_ptr is on 's9' and appl_ptr is on
's4', so the sum is ( 9 + 10 - 4 = 15 ) -- a number greater than buffer_size.
Although I expected pcm->boundary is equal buffer_size and then the test in 7th
line would correct it:
	(9 + 10 - 4 = 15)
	(15 >= 10)  7th line condition test
        (15 - buffer_size = __5__)
resulting in five [s5,s6,s7,s8,s9] samples available. But it's not.

Why? And what is exactly 'boundary' ?
I read this
<http://www.mail-archive.com/alsa-user@lists.sourceforge.net/msg29891.html>
but doesn't help me

Another question ... can I thrust in hw_ptr value after a HWSYNC? will it be the
exactly value of the current processed sample?

And to end ... is the latency of HWSYNC operation insignificant, or it could
block or something that increases latency may happen?

Thank you very much! Cheers :-)

--
Ricardo Biehl Pasquali
