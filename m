From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] ASoC: make ops a pointer in 'struct
	snd_soc_dai'
Date: Mon, 2 Mar 2009 06:39:42 -0600
Message-ID: <ed82fe3e0903020439u497389ccp7ec35c7de37ad936@mail.gmail.com>
References: <f17812d70903011925w2a201e27m39fa001d4c700d45@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.148])
	by alsa0.perex.cz (Postfix) with ESMTP id 3234D24156
	for <alsa-devel@alsa-project.org>; Mon,  2 Mar 2009 13:39:44 +0100 (CET)
Received: by qw-out-1920.google.com with SMTP id 5so1793509qwf.56
	for <alsa-devel@alsa-project.org>; Mon, 02 Mar 2009 04:39:42 -0800 (PST)
In-Reply-To: <f17812d70903011925w2a201e27m39fa001d4c700d45@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Sun, Mar 1, 2009 at 9:25 PM, Eric Miao <eric.y.miao@gmail.com> wrote:

For starters, your patch is missing a list of files changed, so it's
hard for me to review it.

> diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
> index f1aa0c3..c6e155c 100644
> --- a/sound/soc/codecs/cs4270.c
> +++ b/sound/soc/codecs/cs4270.c
> @@ -635,6 +635,17 @@ error:
>
>  #endif /* USE_I2C*/
>
> +#ifdef USE_I2C

This patch won't apply, because it's based on an older version of cs4270.c.

-- 
Timur Tabi
Linux kernel developer at Freescale
