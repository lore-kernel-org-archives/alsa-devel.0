From: Rob Duncan <rduncan@tesla.com>
Subject: Re: More snd_pcm_ioplug_avail_update() questions
Date: Mon, 30 Jul 2018 11:55:45 -0700
Message-ID: <dw77emin4wblji.fsf@tesla.com>
References: <dw77emin53c7a3.fsf@tesla.com> <s5hzhyev5oj.wl-tiwai@suse.de>
 <dw77emfu06cc60.fsf@tesla.com> <s5hmuueysfk.wl-tiwai@suse.de>
 <dw77emeffqca5y.fsf@tesla.com> <s5hk1piyqp1.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-0019bd01.pphosted.com (mx0a-0019bd01.pphosted.com
 [148.163.151.57])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B84E2673A0
 for <alsa-devel@alsa-project.org>; Mon, 30 Jul 2018 20:55:47 +0200 (CEST)
In-Reply-To: <s5hk1piyqp1.wl-tiwai@suse.de>
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

At 08:14 on Thu, Jul 26 2018, Takashi wrote:

> Maybe we can track the own applptr (e.g. transfer_ptr or such) and
> calculate the transfer size from it instead of snd_pcm_mmap_begin();
> i.e. write some open codes of alternative snd_pcm_mmap_begin() there.
>
> Then transfer_ptr is updated again in snd_pcm_ioplug_mmap_commit() as
> well when applptr is updated.
>
> Of course, there is a smarter way, I'd happily take another approach.

Thanks for the hint.  I'm not sure I 100% understand your suggestion,
though.  Unfortunately I don't think I'll have an opportunity to try
this for a few weeks.

Rob.
