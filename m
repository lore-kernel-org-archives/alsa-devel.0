From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] ALSA: pcm: Properly close timer when
 freeing slaves
Date: Mon, 21 Dec 2009 09:13:46 +0100 (CET)
Message-ID: <alpine.LNX.2.00.0912210911540.2598@eeebox2.perex-int.cz>
References: <604760770912201227g60e71a3alb86f36c2a4da3d4e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 88FEE10384E
	for <alsa-devel@alsa-project.org>; Mon, 21 Dec 2009 09:13:46 +0100 (CET)
In-Reply-To: <604760770912201227g60e71a3alb86f36c2a4da3d4e@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Chen <seven.steps@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sun, 20 Dec 2009, Daniel Chen wrote:

> Hi,
>
> Here's a patch originally from Dan McCombs against alsa-lib.git HEAD
> fixing a fairly nasty fd leak for timers.

Thanks for notice. The patch proposed patch does reset hw->period_event 
and pcm->fast_ops variables (the application might reuse pcm handle after 
hw_free call to initialize PCM handle for another parameters). My 
corrected version is in ALSA GIT now:

http://git.alsa-project.org/?p=alsa-lib.git;a=commitdiff;h=a256766c10c52cb6667de8a65f5cbb332fad4cc7

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
