From: Matthew Gregan <kinetik@flim.org>
Subject: Re: Hang in snd_pcm_writei with alsa-pulse plugin
Date: Tue, 2 Nov 2010 17:44:21 +1300
Message-ID: <20101102044421.GA2588@flim.org>
References: <20101101013819.GA22823@flim.org> <4CCEF918.90807@colin.guthr.ie>
	<AANLkTikxDrqXGVwk=-dGokWWxbHyeLKNEZzM3pvH2QKv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from flim.org (flim.org [65.99.223.158])
	by alsa0.perex.cz (Postfix) with ESMTP id 1FDB11037EC
	for <alsa-devel@alsa-project.org>; Tue,  2 Nov 2010 05:44:28 +0100 (CET)
Received: from brak (unknown [121.98.132.55])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by flim.org (Postfix) with ESMTPSA id CF26B1438F
	for <alsa-devel@alsa-project.org>; Tue,  2 Nov 2010 04:43:35 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <AANLkTikxDrqXGVwk=-dGokWWxbHyeLKNEZzM3pvH2QKv@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

At 2010-11-02T10:43:54+0800, Raymond Yau wrote:
> No much response because there are bugs in atest2.c
> 
>   /* prefill sound buffers and begin playback */
>   fill(pcm);
> 
>   while (++count) {
> 
> The program had filled the buffer but the output does not indicate those
> write

This doesn't affect the result of the testcase.  count is only used to pause
and resume less frequently than every iteration of the write loop.

> I can confirm that the program seem hang after a few pause/unpause when
> using alsa-pulse plugin
> 
> However it assert when using hw device
> 
>   assert(bsize / psize >= 4);

The assert is present because I've only tested on systems where this
assertion holds true.  It's likely that the loop timing would need to be
changed to work correctly in other cases.

Thanks for confirming that you can reproduce the problem.  I've since
discovered that it's possible to produce the same problem with the
PulseAudio API directly, so I'll take this up on pulseaudio-discuss@.

Cheers,
-mjg
-- 
Matthew Gregan                     |/
                                  /|                    kinetik@flim.org
