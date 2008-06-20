From: randall <lists_rlr@roadrunner.com>
Subject: Re: note on Suse 10.3 build
Date: Fri, 20 Jun 2008 12:50:24 -0700
Message-ID: <200806201250.25197.lists_rlr@roadrunner.com>
References: <200806191502.36138.lists_rlr@roadrunner.com>
	<s5hiqw4poxq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mta11.adelphia.net (mta11.adelphia.net [68.168.78.205])
	by alsa0.perex.cz (Postfix) with ESMTP id 4794C2464D
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Jun 2008 21:50:27 +0200 (CEST)
In-Reply-To: <s5hiqw4poxq.wl%tiwai@suse.de>
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

Takashi writes:

> You did something wrong, if the changes you did are really only the
> above ones.
>
> Did you try alsa-driver-kmp package on openSUSE BS multimedia:audio
> repo?

Yes, made no difference.

This morning I carefully built the kernel step-by-step and found that changing 
this parameter in config for the kernel enabled my Nvidia MCP61 sound card to 
work:

CONFIG_SND_SOC =m

Once I set this to module, and rebuilt, then I was able to successfully have 
sound working.

Good thing it's just a one parameter change.

- Randall
