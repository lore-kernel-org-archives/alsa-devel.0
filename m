From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH v4] ASoC: ak4613: call dummy write for
 PW_MGMT1/3 when Playback
Date: Thu, 7 Dec 2017 10:42:24 +0900
Message-ID: <ecad1396-f702-4050-610c-caec7576d51e@sakamocchi.jp>
References: <87k1y73wwa.wl%kuninori.morimoto.gx@renesas.com>
 <14212e10-35eb-074a-956a-7f929ab842bb@sakamocchi.jp>
 <87a7yxvs6u.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 439EE2670F6
 for <alsa-devel@alsa-project.org>; Thu,  7 Dec 2017 02:42:26 +0100 (CET)
In-Reply-To: <87a7yxvs6u.wl%kuninori.morimoto.gx@renesas.com>
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
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, "Yokoyama (Renesas)" <hiroyuki.yokoyama.vx@renesas.com>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

On Dec 5 2017 11:21, Kuninori Morimoto wrote:
> 
> Hi Takashi, again
> 
>>> +static void ak4613_dummy_write(struct work_struct *work)
>>> +{
>>> +	struct ak4613_priv *priv = container_of(work,
>>> +						struct ak4613_priv,
>>> +						dummy_write_work);
>>> +	struct snd_soc_component *component = priv->component;
>>> +	unsigned int mgmt1;
>>> +	unsigned int mgmt3;
>>> +
>>> +	/* wait 5 LR clocks */
>>> +	udelay(5000000 / priv->rate);
>>> +
>>> +	snd_soc_component_read(component, PW_MGMT1, &mgmt1);
>>> +	snd_soc_component_read(component, PW_MGMT3, &mgmt3);
>>> +
>>> +	snd_soc_component_write(component, PW_MGMT1, mgmt1);
>>> +	snd_soc_component_write(component, PW_MGMT3, mgmt3);
>>> +}
>>
>> In my understanding, it's better to have care of kernel preemption in
>> this case because data transmission is already activated and these
>> should be executed as quick as possible to prevent much presentation
>> loss.
> 
> To avoid v6 patch, I want to know more clearly.
> Do you mean it needs spin lock ?
> If so lock in trigger, and unlock here ?
> Or lock/unlock on each ?

Hm.

Taking offload to scheduling tasks demands developers to have enough
knowledge about running process contexts on Operating System.
Apparently, you have little knowledge about it (and few interests in
it, in my opinion. I guess that you don't know Linux kernel adds
several kthreads for workqueues according to their priorities and
localities).

Please study about it, before proposing your insistences. Your
colleagues or offshore staffs might help your learning.


Regards

Takashi Sakamoto
