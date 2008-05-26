From: "Benjamin van den Hout" <bvdhout@gmail.com>
Subject: Re: Kernel crash in snd-aloop (2)
Date: Mon, 26 May 2008 12:44:09 +0200
Message-ID: <d5eabee70805260344l204b966bj958f8039563df2f5@mail.gmail.com>
References: <d5eabee70805210741p256d4b3dmaa15fbd39df7c53f@mail.gmail.com>
	<d5eabee70805220602p73154e2buc1bd9e38d0c314e3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.247])
	by alsa0.perex.cz (Postfix) with ESMTP id 78C53248CF
	for <alsa-devel@alsa-project.org>;
	Mon, 26 May 2008 12:44:11 +0200 (CEST)
Received: by rv-out-0708.google.com with SMTP id f25so1713360rvb.32
	for <alsa-devel@alsa-project.org>; Mon, 26 May 2008 03:44:09 -0700 (PDT)
In-Reply-To: <d5eabee70805220602p73154e2buc1bd9e38d0c314e3@mail.gmail.com>
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,

Anybody have something to say about this? :)

Kind regards,
Benjamin

On 22/05/2008, Benjamin van den Hout <bvdhout@gmail.com> wrote:
>
> Hello,
>
> So after much experimentation and thinking, I think I can come up with the
> following scenario why the kernel crashes:
>
> When the aloop soundcard is closed by jackd, all data structures are freed.
> This is OK, but the code forgets to check if any timers are still running.
> Most of the time this goes well and nothing bad happens. But sometimes the
> dpcm->timer.function fires after all data is cleaned up/freed. And that is
> of course not very desirable.
>
> I've attached a patch to the alsa-driver-hg20080516 version of
> drivers/aloop-kernel.c This patch does a del_timer() in three places, I
> would love to hear feedback from you guys on the list if some del_timers can
> be eliminated? It seems a bit paranoia but it works perfectly in my test
> setup.
>
> So what do you guys think? I've never submitted patches before so I'm not
> sure if this is the correct procedure. Please correct me if necessary...
>
> Kind regards,
> Benjamin van den Hout
>
>


-- 
Groeten,
Benjamin

Call me for free! http://www.pushcall.com/client/?key=benjamin
