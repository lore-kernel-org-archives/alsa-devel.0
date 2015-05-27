From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 2/3] ASoC: topology: Add topology core
Date: Wed, 27 May 2015 21:23:03 +0200
Message-ID: <55661997.2050800@metafoo.de>
References: <1432574570-7436-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <1432574570-7436-2-git-send-email-liam.r.girdwood@linux.intel.com>
 <20150527190021.GO21577@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-206.synserver.de (smtp-out-206.synserver.de
 [212.40.185.206])
 by alsa0.perex.cz (Postfix) with ESMTP id BD347260410
 for <alsa-devel@alsa-project.org>; Wed, 27 May 2015 21:23:07 +0200 (CEST)
In-Reply-To: <20150527190021.GO21577@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 05/27/2015 09:00 PM, Mark Brown wrote:
> On Mon, May 25, 2015 at 06:22:49PM +0100, Liam Girdwood wrote:
>
> This looks really nice at a high level, obviously it's a lot of code so
> there might be detail problems but I expect we can fix those up later.
>
>> @@ -564,6 +565,7 @@ struct snd_soc_dapm_widget {
>>   	int num_kcontrols;
>>   	const struct snd_kcontrol_new *kcontrol_news;
>>   	struct snd_kcontrol **kcontrols;
>> +	struct snd_soc_dobj dobj;
>>
>>   	/* widget input and outputs */
>>   	struct list_head sources;
>
> This adds the dynamic object (which isn't enormous but isn't tiny) to
> every widget which could add up a bit.  I don't know if it's worth
> making it a pointer to a dobj and allocating that separately?  OTOH it's
> really routes rather than widgets that are the big cost, and it depends
> on allocators being friendly and not putting lots of padding round
> dobjs.  Definitely fixable incrementally if it is an issue though.

Ideally we'd turn the dependency chain the other way around and have a 
snd_soc_dobj_widget struct which inherits snd_soc_dapm_widget and 
snd_soc_dobj. In the dobj callbacks you can then still use container_of to 
get it. This comes at the expense that we have to add a free() callback to 
snd_soc_dapm_widget. But it opens up the possibility to have other 
specialized widgets sub-classes. snd_soc_dapm_widget is already rather large 
given how many instance we have of it and quite a few of the fields are only 
used by a particular type of widget. Another good candidate for example 
would be the DAI link widget with all its params fields.
