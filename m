From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] add missing comparison to strcmp call
Date: Wed, 10 Nov 2010 13:13:04 +0000
Message-ID: <1289394784.3284.35.camel@odin>
References: <AANLkTi=Chhzawwe=84Z6K11TFi4hpe2d+zW4zNy49DLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id EB42F24429
	for <alsa-devel@alsa-project.org>; Wed, 10 Nov 2010 14:13:09 +0100 (CET)
Received: by eyg24 with SMTP id 24so228383eyg.38
	for <alsa-devel@alsa-project.org>; Wed, 10 Nov 2010 05:13:07 -0800 (PST)
In-Reply-To: <AANLkTi=Chhzawwe=84Z6K11TFi4hpe2d+zW4zNy49DLw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: abraham duenas <aduejazz@gmail.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Tue, 2010-11-09 at 15:43 -0600, abraham duenas wrote:
> >From f796e5f464d3454761b618912e5b4d14716c2bfc Mon Sep 17 00:00:00 2001
> From: abraham duenas <abraham.duenas@ti.com>
> Date: Tue, 9 Nov 2010 15:31:16 -0600
> Subject: [PATCH] add missing comparison to strcmp call
> 

Could do with a little more description here.

> 
> Signed-off-by: abraham duenas <abraham.duenas@ti.com>
> ---
>  src/ucm/main.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/src/ucm/main.c b/src/ucm/main.c
> index e233f41..a73595d 100644
> --- a/src/ucm/main.c
> +++ b/src/ucm/main.c
> @@ -774,9 +774,9 @@ int snd_use_case_get_list(snd_use_case_mgr_t *uc_mgr,
>         pthread_mutex_lock(&uc_mgr->mutex);
>         if (strcmp(identifier, "_verbs") == 0)
>                 err = get_verb_list(uc_mgr, list);
> -        else if (strcmp(identifier, "_enadevs"))
> +        else if (strcmp(identifier, "_enadevs") == 0)
>                 err = get_enabled_device_list(uc_mgr, list);
> -        else if (strcmp(identifier, "_enamods"))
> +        else if (strcmp(identifier, "_enamods") == 0)
>                  err = get_enabled_modifier_list(uc_mgr, list);
>          else {
>                  str1 = strchr(identifier, '/');

Looks fine to me, did this solve all your parsing issues ?

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
