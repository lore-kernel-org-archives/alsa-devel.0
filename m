From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: dapm: Fix NULL pointer dereference
 in snd_soc_dapm_new_dai
Date: Thu, 21 Mar 2019 08:59:55 -0500
Message-ID: <13b5c552-69a6-f1e0-174c-b5aa48560858@linux.intel.com>
References: <1553163085-16845-1-git-send-email-pankaj.laxminarayan.bharadiya@intel.com>
 <20190321123156.GB5684@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 55A2BF80791
 for <alsa-devel@alsa-project.org>; Thu, 21 Mar 2019 14:59:58 +0100 (CET)
In-Reply-To: <20190321123156.GB5684@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>, Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
Cc: lgirdwood@gmail.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

On 3/21/19 7:31 AM, Mark Brown wrote:

> On Thu, Mar 21, 2019 at 03:41:25PM +0530, Pankaj Bharadiya wrote:
>
>>   outfree_kcontrol_news:
>>   	devm_kfree(card->dev, (void *)template.kcontrol_news);
>> -	snd_soc_dapm_free_kcontrol(card, &private_value,
>> -				   rtd->dai_link->num_params, w_param_text);
>> +	if (w_param_text)
>> +		snd_soc_dapm_free_kcontrol(card, &private_value,
>> +				rtd->dai_link->num_params, w_param_text);
> This is very non-obvious - it's not at all clear why we'd need the text
> to free controls.  If there is an issue here it seems like it'd be
> better to make sure that snd_soc_dapm_free_kcontrol() can cope with that
> being NULL, that will be clearer and also avoid potential issues with
> other callers.

I believe the issue is real, but you need to look at the entire code to fig=
ure it out

 =A0=A0=A0 /* allocate memory for control, only in case of multiple configs=
 */
 =A0=A0=A0 if (rtd->dai_link->num_params > 1) {
 =A0=A0=A0 =A0=A0=A0 w_param_text =3D devm_kcalloc(card->dev,
 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 rtd->dai_link-=
>num_params,
 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 sizeof(char *)=
, GFP_KERNEL);
 =A0=A0=A0 =A0=A0=A0 if (!w_param_text) {
 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 ret =3D -ENOMEM;
 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 goto param_fail;
 =A0=A0=A0 =A0=A0=A0 }

 =A0=A0=A0 =A0=A0=A0 template.num_kcontrols =3D 1;
 =A0=A0=A0 =A0=A0=A0 template.kcontrol_news =3D
 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 snd_soc_dapm_alloc_kcont=
rol(card,
 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 link_name,
 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 rtd->dai_link-=
>params,
 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 rtd->dai_link-=
>num_params,
 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 w_param_text, =
&private_value);
 =A0=A0=A0 =A0=A0=A0 if (!template.kcontrol_news) {
 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 ret =3D -ENOMEM;
 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 goto param_fail;
 =A0=A0=A0 =A0=A0=A0 }
 =A0=A0=A0 } else {
 =A0=A0=A0 =A0=A0=A0 w_param_text =3D NULL; <<<< this is set when there is =
a single config
 =A0=A0=A0 }
 =A0=A0=A0 dev_dbg(card->dev, "ASoC: adding %s widget\n", link_name);

 =A0=A0=A0 w =3D snd_soc_dapm_new_control_unlocked(&card->dapm, &template);
 =A0=A0=A0 if (IS_ERR(w)) {
 =A0=A0=A0 =A0=A0=A0 ret =3D PTR_ERR(w);
 =A0=A0=A0 =A0=A0=A0 goto outfree_kcontrol_news; <<< the control creation f=
ailed
 =A0=A0=A0 }

 =A0=A0=A0 w->priv =3D rtd;

 =A0=A0=A0 return w;

outfree_kcontrol_news:
 =A0=A0=A0 devm_kfree(card->dev, (void *)template.kcontrol_news);

<<< and in the function below we try to access w_param_text and private_val=
ue which haven't been allocated.

 =A0=A0=A0 snd_soc_dapm_free_kcontrol(card, &private_value,
 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0 rtd->dai_link->num_params, =
w_param_text);

That said I agree with Mark that it's better to change snd_soc_dapm_free_kc=
ontrol directly.
