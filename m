From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Add post-CODEC bias level callback
 for machine driver
Date: Mon, 06 Dec 2010 12:34:36 +0000
Message-ID: <1291638876.3281.27.camel@odin>
References: <1291466957-30982-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 37E192414E
	for <alsa-devel@alsa-project.org>; Mon,  6 Dec 2010 13:34:40 +0100 (CET)
Received: by wwc33 with SMTP id 33so3782815wwc.20
	for <alsa-devel@alsa-project.org>; Mon, 06 Dec 2010 04:34:39 -0800 (PST)
In-Reply-To: <1291466957-30982-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Sat, 2010-12-04 at 12:49 +0000, Mark Brown wrote:
> Currently the machine driver can only do bias level configuration before
> the CODEC bias level is brought up. This means that the machine cannot do
> any configuration which depends on the CODEC bias level being maintained.
> Provide a post-CODEC callback which allows the machine driver to do things
> like enable the FLL on a CODEC which is brought down to BIAS_OFF when idle.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

> ---
>  include/sound/soc.h  |    2 ++
>  sound/soc/soc-dapm.c |    4 ++++
>  2 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/include/sound/soc.h b/include/sound/soc.h
> index 0eea08e..4abc2f8 100644
> --- a/include/sound/soc.h
> +++ b/include/sound/soc.h
> @@ -632,6 +632,8 @@ struct snd_soc_card {
>  	/* callbacks */
>  	int (*set_bias_level)(struct snd_soc_card *,
>  			      enum snd_soc_bias_level level);

I wonder if it's best we now make this 

set_bias_level_pre() ?

to avoid any confusion.

Liam

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
