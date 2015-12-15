From: Mengdong Lin <mengdong.lin@linux.intel.com>
Subject: Re: [PATCH 5/5] ASoC: The soc card can have auxiliary
 components
Date: Tue, 15 Dec 2015 16:06:14 +0800
Message-ID: <566FC9F6.8050107@linux.intel.com>
References: <cover.1449036307.git.mengdong.lin@linux.intel.com>
 <bb343fe20b14af90f695939d8faae50fae1ba97a.1449036307.git.mengdong.lin@linux.intel.com>
 <20151208185817.GX5727@sirena.org.uk> <5667EFCB.3010402@linux.intel.com>
 <20151209203836.GI5727@sirena.org.uk> <56694E6A.4090402@linux.intel.com>
 <20151211202208.GS5727@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 5011E261622
 for <alsa-devel@alsa-project.org>; Tue, 15 Dec 2015 08:50:08 +0100 (CET)
In-Reply-To: <20151211202208.GS5727@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, mengdong.lin@intel.com, liam.r.girdwood@linux.intel.com, jeeja.kp@intel.com, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org



On 12/12/2015 04:22 AM, Mark Brown wrote:
> On Thu, Dec 10, 2015 at 06:05:30PM +0800, Mengdong Lin wrote:
>> On 12/10/2015 04:38 AM, Mark Brown wrote:
>
>>> OK, but I do think that's something we *should* be doing as part of the
>>> overall move of CODECs to components and it's something that having this
>>> change implies we should be doing as an immediate thing since it's the
>>> more obvious direct use of the code (as Lars said in reply to the early
>>> draft you posted IIRC).
>
>> My early draft didn't use the aux components, so I'm not sure where to find
>> Lars's comments on this idea.
>
> He replied to some thing you posted by mistake and immediately
> retracted.  Can't remember the subject, sorry.

Thanks, I found his comments.

>
>> Please check if my understanding is right?
>
>> I guess you want me to replace the "aux_dev" array from the struct
>> snd_soc_card, by an "aux_components" array. And we may
>> replace soc_bind_aux_dev() by soc_find_components(),
>> replace soc_probe/remove_aux_dev() by soc_probe/remove_components.
>> Probably soc_find/prove/remove_components need some adjustment for the the
>> aux devices (DAIless codecs).
>
>> And device driver of the these aux_dev need to use
>> snd_soc_register_component() to make it as a component.
>
> Yeah, pretty much.  I think we'll have a period where we support both
> though as any CODEC *could* be used in this way and we're not ready for
> that yet.
>
> Let me have a look at converting some of the drivers over the weekend.
>

I still have some basic questions:

1. What are the typical usages for aux_dev?
    For CODEC<->CODEC link or external headset detection chip?

    In samsung/neo1973_wm8753.c, the aux_dev "dfbmcs320" is to involve 
the BT sco codec. And this codec provides dai "bt-sco-pcm" for voice via 
BT. This seems to be the codec-codec link case, the CODEC can have DAIs.


    And this seems to be the external headset chip case (DAIless):
    In rockchip/rockchip_max98090.c, the aux_devs
static struct snd_soc_aux_dev rk_98090_headset_dev = {
	.name = "Headset Chip",
	.init = rk_98090_headset_init,
};
   But how can ASoC find the right component registered by 
codecs/ts3a227e.c? This aux device does not give a codec node or name.

   Any other typical usage cases?

2. Why we need the rtd array 'rtd_aux' for the aux_devs?
    If the codec has DAIs and used by a DAI link, the ASoC will create a 
rtd for the link.

Thanks
Mengdong










ts3a227e.c

Thanks
Mengdong
