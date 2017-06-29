From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH v2 1/4] ASoC: Intel: Skylake: Add debugfs
	support
Date: Thu, 29 Jun 2017 17:16:05 +0900
Message-ID: <4d9ce5ac-ae35-7c38-cace-e482b222e82a@sakamocchi.jp>
References: <20170629065604.30105-1-guneshwor.o.singh@intel.com>
 <20170629065604.30105-2-guneshwor.o.singh@intel.com>
 <e7607f1b-540b-fcda-a784-918ef9eafbeb@sakamocchi.jp>
 <20170629075649.GG19154@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id DEA86266EAB
 for <alsa-devel@alsa-project.org>; Thu, 29 Jun 2017 10:16:10 +0200 (CEST)
In-Reply-To: <20170629075649.GG19154@localhost>
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
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Guneshwor Singh <guneshwor.o.singh@intel.com>, liam.r.girdwood@linux.intel.com, Patches Audio <patches.audio@intel.com>, Mark Brown <broonie@kernel.org>, Vunny Sodhi <vunnyx.sodhi@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On Jun 29 2017 16:56, Vinod Koul wrote:
> On Thu, Jun 29, 2017 at 04:43:38PM +0900, Takashi Sakamoto wrote:
>> Hi,
> 
> Hi Takashi,
> 
>>> +struct skl_debug *skl_debugfs_init(struct skl *skl)
>>> +{
>>> +	struct skl_debug *d;
>>> +
>>> +	d = devm_kzalloc(&skl->pci->dev, sizeof(*d), GFP_KERNEL);
>>> +	if (!d)
>>> +		return NULL;
>>> +
>>> +	/* create the root dir first */
>>> +	d->fs = debugfs_create_dir(KBUILD_MODNAME, NULL);
>>
>> ALSA SoC part has a debugfs support. It adds "asoc" node into debugfs
>> mount point and export "snd_soc_debugfs_root" symbol as a root node. I
>> think it a better idea to collect relevant nodes into the place, rather
>> than dispersing them.
> 
> Yes we can use that, but then this is very driver specific info, does it
> make sense to keep under framework 'asoc' ?

It makes sense in a point that it's a part of drivers in ALSA SoC part.

> If we decide to use that, a more intuitive place might be "platform" rather
> than "asoc" which creates dependency on sound card creation which might happen
> much later.
>
> for debug, I would like to avoid complexity and go with simple device
> approach...

I have no objection to your opinion. I like an idea "keep it short and
simple". If no issues I had, I would select the same direction. However,
space on debugfs is one of shared resources on system. If being polite
to the other subsystems, it's better to avoid scattering it, in my opinion.

For naming scheme or directory structure inner the node, please have
enough discussion with the other developers for ALSA SoC part. But in
this timing, it would be acceptable to add your node just under "asoc"
node. The arrangement could be done later.


Regards

Takashi Sakamoto
