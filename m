From: Rob Duncan <rduncan@tesla.com>
Subject: Re: More snd_pcm_ioplug_avail_update() questions
Date: Thu, 26 Jul 2018 07:19:19 -0700
Message-ID: <dw77emfu06cc60.fsf@tesla.com>
References: <dw77emin53c7a3.fsf@tesla.com> <s5hzhyev5oj.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-0019bd01.pphosted.com (mx0b-0019bd01.pphosted.com
 [148.163.155.1])
 by alsa0.perex.cz (Postfix) with ESMTP id 372BA26739D
 for <alsa-devel@alsa-project.org>; Thu, 26 Jul 2018 16:19:22 +0200 (CEST)
In-Reply-To: <s5hzhyev5oj.wl-tiwai@suse.de>
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


At 00:04 on Thu, Jul 26 2018, Takashi wrote:
>> Is it required that all available data has been committed between calls
>> to snd_pcm_ioplug_avail_update() on an IO plugin capture stream?
>
> Yes, the capture data is committed.
> The snd_pcm_ioplug_hw_ptr_update() should have reported the amount of
> data the slave PCM can actually transfer.  Hence the transfer call
> thereafter must fulfill the whole requested data.

But what I see is that snd_pcm_rate_avail_update() commits data in the
slave PCM in units of slave->period_size (via
snd_pcm_rate_grab_next_period()), which means that if there is a partial
period in the slave PCM mmap it will not be committed.

In other words, not all the available data will be commmitted before the
next call to snd_pcm_ioplug_avail_update().  This means that the data
will be discarded the next time that snd_pcm_ioplug_avail_update() is
called.

Rob.
