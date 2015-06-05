From: "arnaud.mouiche@invoxia.com" <arnaud.mouiche@invoxia.com>
Subject: Re: [PATCH] ASoC: dapm: fix prefixed stream name
	matching in snd_soc_dapm_link_dai_widgets
Date: Fri, 05 Jun 2015 16:12:51 +0200
Message-ID: <5571AE63.60206@invoxia.com>
References: <1433511674-29156-1-git-send-email-arnaud.mouiche@invoxia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f170.google.com (mail-wi0-f170.google.com
 [209.85.212.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E4F226685B
 for <alsa-devel@alsa-project.org>; Fri,  5 Jun 2015 16:12:52 +0200 (CEST)
Received: by wifx6 with SMTP id x6so22122336wif.0
 for <alsa-devel@alsa-project.org>; Fri, 05 Jun 2015 07:12:52 -0700 (PDT)
Received: from [192.168.65.122] (AAnnecy-653-1-146-177.w86-200.abo.wanadoo.fr.
 [86.200.209.177])
 by mx.google.com with ESMTPSA id wx9sm10761705wjb.6.2015.06.05.07.12.51
 for <alsa-devel@alsa-project.org>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Jun 2015 07:12:51 -0700 (PDT)
In-Reply-To: <1433511674-29156-1-git-send-email-arnaud.mouiche@invoxia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Please, ignore this patch.

it is incorrect
(line "if (!w->sname || !strstr(w->sname, dai_w->name))" is not removed)

I will send one again.
Arnaud

Le 05/06/2015 15:41, Arnaud Mouiche a =E9crit :
> commit "ASoC: dapm: Modify widget stream name according to prefix"
> fixed a part of the problem when dai_w->name and w->sname are equal
> before being prefixed.
>
> Remains the case where w->sname is only a sub string of dai_w->name.
>
> For example, TLV320AIC3x codec defines the widget
> 	SND_SOC_DAPM_DAC("Left DAC", "Left Playback", DAC_PWR, 7, 0)
>
> In snd_soc_dapm_link_dai_widgets, we will failed to match
> 	"[prefix] Left Playback"
> with
> 	"[prefix] Playback".
>
> Since dai_w and w necessarily belongs to the same dapm when strstr()
> is called, they necessarily have the same prefix which allow us to
> compare 'w->sname + prefix_len' with  'dai_w->name + prefix_len' directly
> without length check.
>
> Signed-off-by: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
> ---
>   sound/soc/soc-dapm.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
> index e19a676..7194df4 100644
> --- a/sound/soc/soc-dapm.c
> +++ b/sound/soc/soc-dapm.c
> @@ -3392,6 +3392,9 @@ int snd_soc_dapm_link_dai_widgets(struct snd_soc_ca=
rd *card)
>   =

>   	/* For each DAI widget... */
>   	list_for_each_entry(dai_w, &card->widgets, list) {
> +		const char *prefix =3D soc_dapm_prefix(dai_w->dapm);
> +		size_t prefix_len =3D prefix ? strlen(prefix)+1 : 0;
> +
>   		switch (dai_w->id) {
>   		case snd_soc_dapm_dai_in:
>   		case snd_soc_dapm_dai_out:
> @@ -3416,6 +3419,8 @@ int snd_soc_dapm_link_dai_widgets(struct snd_soc_ca=
rd *card)
>   			}
>   =

>   			if (!w->sname || !strstr(w->sname, dai_w->name))
> +			if (!w->sname ||
> +			    !strstr(w->sname + prefix_len, dai_w->name + prefix_len))
>   				continue;
>   =

>   			if (dai_w->id =3D=3D snd_soc_dapm_dai_in) {
