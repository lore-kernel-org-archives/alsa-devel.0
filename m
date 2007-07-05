From: "Roy Huang" <royhuang9@gmail.com>
Subject: Re: [PATCH]fix mmap emulation bug of recording doesn't
	work
Date: Thu, 5 Jul 2007 14:17:35 +0800
Message-ID: <afe668f90707042317p3452107fsbfcec50930a5fd61@mail.gmail.com>
References: <afe668f90707032251v693c78a6g37e2e009ec13f3b0@mail.gmail.com>
	<afe668f90707040718j15495e7bt375b62eb355a1a28@mail.gmail.com>
	<s5hlkdw6qiu.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.178])
	by alsa0.perex.cz (Postfix) with ESMTP id 705DB24529
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Jul 2007 08:17:36 +0200 (CEST)
Received: by py-out-1112.google.com with SMTP id u77so4228548pyb
	for <alsa-devel@alsa-project.org>; Wed, 04 Jul 2007 23:17:35 -0700 (PDT)
In-Reply-To: <s5hlkdw6qiu.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

There is no problem with rate plugin. If no plugin is used, record can
works. If any plugin is used, it will have problem.

If mmap emulation is enabled, data is copied from driver to hw layer's
buffer, then to upper layer. In snd_pcm_hw_t, appl_ptr is used to
indicate the position in hw layer's buffer where last byte is copied
to upper layer. But there is no way to know the position in hw layer's
buffer where the last byte is copied from driver.

In function snd_pcm_hw_avail_update, it calls
snd_pcm_mmap_capture_avail to find how much data is available for
upper layer, denote the amount of available data as s1. Part of the
available data is already in hw layer's buffer, denote the amount of
this part of data as s2. But snd_pcm_hw_avail_update calls
snd_pcm_read_mmap to copy data as much as s1 from driver to hw layer's
buffer. In fact only (s1-s2) is needed to be copied.

So in new function snd_pcm_hw_avail_update, only data in amout of
(s1-s2) will be copied by snd_pcm_read_mmap.

Roy

On 7/5/07, Takashi Iwai <tiwai@suse.de> wrote:
> At Wed, 4 Jul 2007 22:18:24 +0800,
> Roy Huang wrote:
> >
> > Record doesn't work if enabling mmap emulation and rate conversion
> > needed, this patch fix this bug.
>
> Thanks for the patch.  I need to check your changes in detail as it's
> not so obvious.  What is the problem with rate plugin and
> mmap-emulation?  From what I find in your patch, it's something to do
> with the hw_ptr update mismatch.
>
>
> Takashi
>
