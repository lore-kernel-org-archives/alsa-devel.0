From: Karthik Ramgopal <applefreakpeeps@gmail.com>
Subject: Re: No sound on Acer Aspire 6935G
Date: Tue, 28 Apr 2009 14:08:18 +0800
Message-ID: <4b8c423b0904272308o5baaf3e0v703016169372a4c9@mail.gmail.com>
References: <4b8c423b0904250904i226fd458we275c263475a3b8c@mail.gmail.com>
	<s5hpreyh1bh.wl%tiwai@suse.de>
	<4b8c423b0904271901i2f32a3e2r40a8b3f481e46a1d@mail.gmail.com>
	<s5h63gp2usp.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.251])
	by alsa0.perex.cz (Postfix) with ESMTP id 869AC2446E
	for <alsa-devel@alsa-project.org>;
	Tue, 28 Apr 2009 08:08:19 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c3so223765ana.2
	for <alsa-devel@alsa-project.org>; Mon, 27 Apr 2009 23:08:18 -0700 (PDT)
In-Reply-To: <s5h63gp2usp.wl%tiwai@suse.de>
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

Yeah I added these 2 lines to the end of /etc/modprobe.d/alsa-base.conf

alias snd-card-0 snd-hda-intel
options snd-hda-intel model=acer-aspire-4930g

This is enough to pass the model option to the driver right?
I will post the alsa-info.sh output after I get back home from work.

Karthik

On Tue, Apr 28, 2009 at 1:48 PM, Takashi Iwai <tiwai@suse.de> wrote:

> At Tue, 28 Apr 2009 10:01:59 +0800,
> Karthik Ramgopal wrote:
> >
> > No progress... Same status as before even after adding model.
>
> Are you sure that the model option is passed to the driver?
> Give alsa-info.sh output in that state.
>
>
> Takashi
>
