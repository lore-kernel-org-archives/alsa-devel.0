From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [for 2.6.34][PATCH] ALSA: pcm_lib - fix xrun
	functionality
Date: Fri, 26 Mar 2010 17:24:13 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1003261723080.3925@eeebox2.perex-int.cz>
References: <1269612445-14245-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id BA03224334
	for <alsa-devel@alsa-project.org>; Fri, 26 Mar 2010 17:24:14 +0100 (CET)
In-Reply-To: <1269612445-14245-1-git-send-email-jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 26 Mar 2010, Jarkko Nikula wrote:

> The commit 4d96eb255c53ab5e39b37fd4d484ea3dc39ab456 broke the interrupt
> time xrun functionality (stream stop etc.) if the CONFIG_SND_PCM_XRUN_DEBUG
> is not set. This is because the xrun() is null defined without it.
>
> Fix this by letting the function xrun() to be always defined as it was
> before.
>
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> Cc: Jaroslav Kysela <perex@perex.cz>

Oops. This is why I didn't see the broken behaviour in my tests (compiling 
everything with debug mode ;-). I applied this patch to my GIT tree. 
Thanks.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
