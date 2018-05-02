From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [alsa-lib][PATCH 1/2] ucm: adding the folder of
 card_long_name when finding verb conf file
Date: Wed, 2 May 2018 08:43:37 +0200
Message-ID: <f42b0f64-61b5-7eeb-adc9-3c5d07d68517@perex.cz>
References: <1525241286-16498-1-git-send-email-hui.wang@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 4BC0F2673A6
 for <alsa-devel@alsa-project.org>; Wed,  2 May 2018 08:43:41 +0200 (CEST)
In-Reply-To: <1525241286-16498-1-git-send-email-hui.wang@canonical.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hui Wang <hui.wang@canonical.com>, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Applied. Thanks.

Dne 2.5.2018 v 08:08 Hui Wang napsal(a):
> The board configuration file and verb conf file are allowed to be
> in the folder named of card_long_name, so when finding the verb conf
> file, we need to check if it is in the folder of card_long_name or
> card_name.
> 
> Signed-off-by: Hui Wang <hui.wang@canonical.com>
> ---
>  src/ucm/parser.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/src/ucm/parser.c b/src/ucm/parser.c
> index 2d76152..219edb9 100644
> --- a/src/ucm/parser.c
> +++ b/src/ucm/parser.c
> @@ -1056,6 +1056,7 @@ static int parse_verb_file(snd_use_case_mgr_t *uc_mgr,
>  	char filename[MAX_FILE];
>  	char *env = getenv(ALSA_CONFIG_UCM_VAR);
>  	int err;
> +	char *folder_name;
>  
>  	/* allocate verb */
>  	verb = calloc(1, sizeof(struct use_case_verb));
> @@ -1082,12 +1083,17 @@ static int parse_verb_file(snd_use_case_mgr_t *uc_mgr,
>  	}
>  
>  	/* open Verb file for reading */
> +	if (!strncmp(uc_mgr->conf_file_name, uc_mgr->card_long_name, MAX_CARD_LONG_NAME))
> +		folder_name = uc_mgr->card_long_name;
> +	else
> +		folder_name = uc_mgr->card_name;
> +
>  	if (env)
>  		snprintf(filename, sizeof(filename), "%s/%s/%s",
> -			 env, uc_mgr->card_name, file);
> +			 env, folder_name, file);
>  	else
>  		snprintf(filename, sizeof(filename), "%s/ucm/%s/%s",
> -			 snd_config_topdir(), uc_mgr->card_name, file);
> +			 snd_config_topdir(), folder_name, file);
>  	filename[sizeof(filename)-1] = '\0';
>  	
>  	err = uc_mgr_config_load(filename, &cfg);
> 


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
