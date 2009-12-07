From: Raul Xiong <raulxiong@gmail.com>
Subject: Re: io-plugin does not call start callback function
Date: Mon, 7 Dec 2009 14:45:19 +0800
Message-ID: <358341420912062245t5cdacc6fycfaff4e9800ea3c0@mail.gmail.com>
References: <4B17A5CC.5050906@gmail.com> <4B17DE74.6@gmail.com>
	<358341420912040013m526a834bl968668da7b9f3c07@mail.gmail.com>
	<4B1C29D8.5090605@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f211.google.com (mail-fx0-f211.google.com
	[209.85.220.211])
	by alsa0.perex.cz (Postfix) with ESMTP id BA43F245C1
	for <alsa-devel@alsa-project.org>; Mon,  7 Dec 2009 07:45:19 +0100 (CET)
Received: by fxm3 with SMTP id 3so4420837fxm.4
	for <alsa-devel@alsa-project.org>; Sun, 06 Dec 2009 22:45:19 -0800 (PST)
In-Reply-To: <4B1C29D8.5090605@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stefan Schoenleitner <dev.c0debabe@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Stefan

What you said is basically right. I reviewed the code pcm.c in alsa-lib, it
shows the call procedure. But now I'm a little confused. In
snd_pcm_avail_update function, it computes with the pcm->hw.ptr value. And
in the plug-in we will write, only pcm->hw_ptr is updated. But who will link
these two value and when they are linking. I didn't find it.

2009/12/7 Stefan Schoenleitner <dev.c0debabe@gmail.com>

> Hi,
>
> Raul Xiong wrote:
> > Hi Stefan
> >
> > This is because your pointer callback function is not implemented
> properly.
> > "pointer" callback function should return the right position of the
> > playback/capture buffer, apps over alsa framework will call
> > snd_pcm_avail_update to get the position.
> > Also, you should call snd_pcm_ioplug_set_param_minmax in your
> > play_hw_constraint function to define the buffer size relevant
> parameters.
>
> after a full day of experimenting and trying to find out why the start
> callback function is not called I observed something interesting:
>
>
> It seems that for the io plugin there is an application pointer
> io->appl_ptr and the hardware pointer io->hw_ptr.
>
> Once playback is started, the start callback function is *not* called,
> but instead data transfer is started immediately.
> More precisely, each time the pointer callback function is called to get
> the current position of the hardware pointer and after that the transfer
> function is called to do the actual data transfer.
>
> After each call of the transfer function the number of transfered frames
> is returned (i.e. the number of frames that have been written to some
> buffer we would like to fill behind a file descriptor).
> However, as data transfers have to be timed precisely, we can not just
> increment the hw_ptr from inside the transfer callback function.
>
> If the hw_ptr is not touched at all (thus it stays 0 at all times), a
> few more transfers are performed until the application pointer appl_ptr
> has reached a certain (high) amount of "transfered" frames.
>
> Then, which is most interesting, the start callback function *is* called
> followed by calls to the pointer and polling/revent callback functions.
> As I am not incrementing the hw_ptr at any place right now, the revent
> polling function is called endlessly.
>
>
>
> After a full day of even more experiments I think I know how it is
> supposed to work:
>
>
> In the beginning a certain amount of frames (I guess this is the
> "start_threshold") is transfered (or more precisely prefilled in the
> output buffer).
> As soon as this start threshold is reached the start callback function
> is called and alsa waits until the hardware pointer hw_ptr has reached a
> certain position so that the next data transfers can be performed.
> For this reason it seems that the hw_ptr can be seen as the pointer that
> indicates how many frames already have been received (and maybe even
> processed) at the receiving end.
> Besides it also polls the filedescriptor(s) to check if the next data
> transfers can be performed (without blocking actually).
>
>
> At the moment I'm not sure if my assumptions above are close enough to
> reality, but at least I think that I understand what is going on now.
>
> If something like this would have been in the alsa documentation I guess
> it would have saved me like a week of work.
>
> cheers,
> stefan
>
