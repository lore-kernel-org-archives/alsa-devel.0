From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH] ASoC: dapm - fix prefix for DAPM muxes
Date: Tue, 24 May 2011 21:45:04 +0300
Message-ID: <20110524214504.bc02203f.jhnikula@gmail.com>
References: <1306255149-4519-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id E1FCB10386A
	for <alsa-devel@alsa-project.org>;
	Tue, 24 May 2011 20:45:07 +0200 (CEST)
Received: by eyg5 with SMTP id 5so2520523eyg.38
	for <alsa-devel@alsa-project.org>; Tue, 24 May 2011 11:45:06 -0700 (PDT)
In-Reply-To: <1306255149-4519-1-git-send-email-lrg@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 24 May 2011 17:39:09 +0100
Liam Girdwood <lrg@ti.com> wrote:

> Make sure DAPM muxes have a valid kcontrol name instead of NULL.
> 
> Signed-off-by: Liam Girdwood <lrg@ti.com>
> ---
>  sound/soc/soc-dapm.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
> index 456617e..c5d98e3 100644
> --- a/sound/soc/soc-dapm.c
> +++ b/sound/soc/soc-dapm.c
> @@ -489,10 +489,10 @@ static int dapm_new_mux(struct snd_soc_dapm_context *dapm,
>  	wlist->widgets[wlistentries - 1] = w;
>  
>  	if (!kcontrol) {
> -		if (dapm->codec)
> +		if (dapm->codec && dapm->codec->name_prefix)
>  			prefix = dapm->codec->name_prefix;
>  		else
> -			prefix = NULL;
> +			prefix = w->name;
>  
This didn't look correct to play with prefix. A quick look revealed
that there is indeed breakage from commit af46800 ("ASoC: Implement mux
control sharing") and this fix doesn't fix it on rx51.

I think the breakage must come from dapm_is_shared_kcontrol() that
returns always 1 and dapm_new_mux() ends up using w->kcontrol_news
[0].name instead of previous w->name.

dapm_is_shared_kcontrol() returns always 1 since it gets
&w->kcontrol_news[0] as an argument and &w->kcontrol_news[i] will
match when iterating the same widget with i==0.

	list_for_each_entry(w, &dapm->card->widgets, list) {
		for (i = 0; i < w->num_kcontrols; i++) {
			if (&w->kcontrol_news[i] == kcontrol_new) {
				if (w->kcontrols)
					*kcontrol = w->kcontrols[i];
				return 1;
			}
		}
	}

It works rx51 if I start the iteration from i==1 but it looks the
actual fix is to the check that we are not iterating the same widget.

-- 
Jarkko
