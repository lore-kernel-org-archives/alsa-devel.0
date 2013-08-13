From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: dapm: Don't create routes when
	creating kcontrols
Date: Tue, 13 Aug 2013 10:54:12 +0200
Message-ID: <5209F434.1020105@metafoo.de>
References: <1376347108-23482-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
 (mailhost.informatik.uni-hamburg.de [134.100.9.70])
 by alsa0.perex.cz (Postfix) with ESMTP id 031C2265173
 for <alsa-devel@alsa-project.org>; Tue, 13 Aug 2013 11:02:45 +0200 (CEST)
In-Reply-To: <1376347108-23482-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

On 08/13/2013 12:38 AM, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
>
> Attempting to create the route as part of adding a mux control causes us
> to attempt to add the same route twice since we loop over all sources
> for the mux after creating the control. Instead do the addition in the
> callers.
>
> Signed-off-by: Mark Brown <broonie@linaro.org>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks.

[...]
> @@ -821,7 +822,7 @@ static int dapm_new_mux(struct snd_soc_dapm_widget *w)
>   	path = list_first_entry(&w->sources, struct snd_soc_dapm_path,
>   				list_sink);

The two lines above can also be removed

>
> -	ret = dapm_create_or_share_mixmux_kcontrol(w, 0, path);
> +	ret = dapm_create_or_share_mixmux_kcontrol(w, 0);
>   	if (ret < 0)
>   		return ret;
>
>
