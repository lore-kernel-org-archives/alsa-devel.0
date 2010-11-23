From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [patch] pcm: add MMAP_EMUL to type names
Date: Tue, 23 Nov 2010 13:41:16 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1011231341030.8433@eeebox2.perex-int.cz>
References: <20101123110337.GK1522@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id A64AF103905
	for <alsa-devel@alsa-project.org>; Tue, 23 Nov 2010 13:41:16 +0100 (CET)
In-Reply-To: <20101123110337.GK1522@bicker>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <error27@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 23 Nov 2010, Dan Carpenter wrote:

> If we try to print this then it causes a read past the end of the array
> in snd_pcm_type_name().

Applied. Thanks.

 					Jaroslav

>
> diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c
> index 7409943..906b502 100644
> --- a/src/pcm/pcm.c
> +++ b/src/pcm/pcm.c
> @@ -1633,6 +1633,7 @@ static const char *const snd_pcm_type_names[] = {
> 	PCMTYPE(SOFTVOL),
>         PCMTYPE(IOPLUG),
>         PCMTYPE(EXTPLUG),
> +	PCMTYPE(MMAP_EMUL),
> };
>
> static const char *const snd_pcm_subformat_names[] = {
>

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
