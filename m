From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] alsaucm: Report failure to set a device
 due to missing verb setup
Date: Sun, 10 Oct 2010 11:45:54 +0100
Message-ID: <1286707554.3429.19.camel@odin>
References: <1286572314-8035-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 7BB47103814
	for <alsa-devel@alsa-project.org>;
	Sun, 10 Oct 2010 12:45:57 +0200 (CEST)
Received: by wwb28 with SMTP id 28so2208089wwb.20
	for <alsa-devel@alsa-project.org>; Sun, 10 Oct 2010 03:45:57 -0700 (PDT)
In-Reply-To: <1286572314-8035-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-10-08 at 14:11 -0700, Mark Brown wrote:
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  alsaucm/usecase.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/alsaucm/usecase.c b/alsaucm/usecase.c
> index 2db26f1..d1420c0 100644
> --- a/alsaucm/usecase.c
> +++ b/alsaucm/usecase.c
> @@ -94,8 +94,10 @@ static int list_verb_device_status(snd_use_case_mgr_t *uc_mgr)
>  	int i, enabled, num;
>  
>  	verb = snd_use_case_get_verb(uc_mgr);
> -	if (verb == NULL)
> +	if (verb == NULL) {
> +		printf(" no verb currently enabled.\n");
>  		return -ENODEV;
> +	}
>  
>  	num = snd_use_case_get_device_list(uc_mgr, verb, &device_list);
>  	if (num <= 0) {

Both Applied.

Jaroslav, are you going to apply these to your ucm branch ?

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
