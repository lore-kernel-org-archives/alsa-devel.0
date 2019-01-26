From: Dimitris Papavasiliou <dpapavas@gmail.com>
Subject: Re: [PATCH 1/2] ASoC: pcm512x: Implement the
	set_bclk_ratio interface
Date: Sat, 26 Jan 2019 21:00:09 +0200
Message-ID: <bed2d410-1b67-c2e1-dd9b-3877917fef43@gmail.com>
References: <9b758d09-9b9b-77a1-6651-43755c67e6fd@gmail.com>
 <c20a4737-ab29-11e7-7780-4782463eb2cf@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com
 [209.85.208.66])
 by alsa0.perex.cz (Postfix) with ESMTP id C0BBE26680F
 for <alsa-devel@alsa-project.org>; Sat, 26 Jan 2019 20:00:12 +0100 (CET)
Received: by mail-ed1-f66.google.com with SMTP id y56so9937239edd.11
 for <alsa-devel@alsa-project.org>; Sat, 26 Jan 2019 11:00:12 -0800 (PST)
In-Reply-To: <c20a4737-ab29-11e7-7780-4782463eb2cf@axentia.se>
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
To: Peter Rosin <peda@axentia.se>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Matthias Reichl <hias@horus.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 1/26/19 8:48 PM, Peter Rosin wrote:
> On 2019-01-26 14:17, Dimitris Papavasiliou wrote:
>> +static int pcm512x_set_bclk_ratio(struct snd_soc_dai *dai, unsigned int ratio)
>> +{
>> +	struct snd_soc_component *component = dai->component;
>> +	struct pcm512x_priv *pcm512x = snd_soc_component_get_drvdata(component);
>> +
>> +	if (ratio > 256)
>> +		return -EINVAL;
> 
> ratio == 0 should also generate -EINVAL.

Sorry, I forgot to mention in the notes, that I allowed setting a
zero ratio on purpose, in order to allow "unsetting" the bclk
ratio (since it only takes effect if it is positive).  I'm not
sure if it will ever be necessary to do that in practice, but I
thought I'd allow it, since it has a valid effect.
