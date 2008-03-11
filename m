From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: Re: aplay doesnt work - new problem`
Date: Tue, 11 Mar 2008 16:09:34 -0700
Message-ID: <61445c750803111609v567e027t9519747865853c6c@mail.gmail.com>
References: <61445c750803111605u1c9b8f5ascdee2289c992488a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 660E11037F4
	for <alsa-devel@alsa-project.org>; Wed, 12 Mar 2008 00:09:37 +0100 (CET)
Received: by wr-out-0506.google.com with SMTP id 58so2015346wri.8
	for <alsa-devel@alsa-project.org>; Tue, 11 Mar 2008 16:09:35 -0700 (PDT)
In-Reply-To: <61445c750803111605u1c9b8f5ascdee2289c992488a@mail.gmail.com>
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

On Tue, Mar 11, 2008 at 4:05 PM, Pharaoh . <pharaoh137@gmail.com> wrote:

>
> I am trying to run my pcm external io type plugin on an arm based board. I
> have no kernel alsa driver
> and the user space plugin is supposed to take care of talking to DSP using
> shared memorty and send sound data.
>
> Since, I dont have kernel space ALSA driver, do I need to enable kernel
> ALSA support in .config?
>
> I am facing following problem,
>
> #aplay
> ALSA lib conf.c:2852:(snd_config_hook_load) cannot access file
> /home/pharaoh/alsa/cards/aliases.conf
> ALSA lib pcm.c:2014:(snd_pcm_open_conf) Invalid type for PCM default
> definition
> (id: default, value: cards.pcm.default)
> aplay: main:550: audio open error: Invalid argument
>
>
> I can see that, aliases.conf is being searched at wrong place (its
> actually looking on my host machine), how can I fix this?
>
> -pharaoh.
>

Also, I am trying to make aplay work first, so not using

aplay -D my_plug test.wav.

And aliases.conf is already on board in /share/alsa/cards.
