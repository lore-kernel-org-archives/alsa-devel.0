From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 4/5] Android: avoid link_warning
Date: Fri, 15 Mar 2019 13:18:48 +0100
Message-ID: <77c916c1-4265-5929-9c8b-4ace67ff4490@perex.cz>
References: <20190315091706.26772-1-cwhuang@linux.org.tw>
 <20190315091706.26772-5-cwhuang@linux.org.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0CEC5F896B2
 for <alsa-devel@alsa-project.org>; Fri, 15 Mar 2019 13:18:52 +0100 (CET)
In-Reply-To: <20190315091706.26772-5-cwhuang@linux.org.tw>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Chih-Wei Huang <cwhuang@android-x86.org>
Cc: alsa-devel@alsa-project.org, Chih-Wei Huang <cwhuang@linux.org.tw>
List-Id: alsa-devel@alsa-project.org

Dne 15. 03. 19 v 10:17 Chih-Wei Huang napsal(a):
> It will be treated as an error.
> 
> Signed-off-by: Chih-Wei Huang <cwhuang@linux.org.tw>
> ---
>  src/pcm/pcm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c
> index 11aec805..4bb5fe5f 100644
> --- a/src/pcm/pcm.c
> +++ b/src/pcm/pcm.c
> @@ -1053,7 +1053,7 @@ int snd_pcm_hwsync(snd_pcm_t *pcm)
>  	snd_pcm_unlock(pcm);
>  	return err;
>  }
> -#ifndef DOC_HIDDEN
> +#if !defined(DOC_HIDDEN) && !defined(ANDROID)
>  link_warning(snd_pcm_hwsync, "Warning: snd_pcm_hwsync() is deprecated, consider to use snd_pcm_avail()");
>  #endif

Create a new option in the configure script (--disable-hwsync-warning or
so). I don't think that this should be Android only specific case.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
