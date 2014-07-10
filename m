From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH alsa-lib 3/5] pcm: Add sw_params API
 functions to get/set timestamp type
Date: Thu, 10 Jul 2014 15:22:06 +0200
Message-ID: <53BE937E.6020107@ladisch.de>
References: <1404997757-15500-1-git-send-email-tiwai@suse.de>
 <1404997757-15500-4-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 8A997260786
 for <alsa-devel@alsa-project.org>; Thu, 10 Jul 2014 15:22:07 +0200 (CEST)
In-Reply-To: <1404997757-15500-4-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
Cc: Daniel Thompson <daniel.thompson@linaro.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> @@ -1899,6 +1918,7 @@ int snd_pcm_dump_sw_setup(snd_pcm_t *pcm, snd_output_t *out)
>  		return -EIO;
>  	}
>  	snd_output_printf(out, "  tstamp_mode  : %s\n", snd_pcm_tstamp_mode_name(pcm->tstamp_mode));
> +	snd_output_printf(out, "  tstamp_type  : %s\n", snd_pcm_tstamp_type_name(pcm->tstamp_mode));

> @@ -5613,6 +5634,7 @@ int snd_pcm_sw_params_current(snd_pcm_t *pcm, snd_pcm_sw_params_t *params)
>  int snd_pcm_sw_params_dump(snd_pcm_sw_params_t *params, snd_output_t *out)
>  {
>  	snd_output_printf(out, "tstamp_mode: %s\n", snd_pcm_tstamp_mode_name(params->tstamp_mode));
> +	snd_output_printf(out, "tstamp_type: %s\n", snd_pcm_tstamp_type_name(params->tstamp_mode));

_type, not _mode


Regards,
Clemens
