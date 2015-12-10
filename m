From: Mengdong Lin <mengdong.lin@linux.intel.com>
Subject: Re: [PATCH 5/5] ASoC: The soc card can have auxiliary
 components
Date: Thu, 10 Dec 2015 18:05:30 +0800
Message-ID: <56694E6A.4090402@linux.intel.com>
References: <cover.1449036307.git.mengdong.lin@linux.intel.com>
 <bb343fe20b14af90f695939d8faae50fae1ba97a.1449036307.git.mengdong.lin@linux.intel.com>
 <20151208185817.GX5727@sirena.org.uk> <5667EFCB.3010402@linux.intel.com>
 <20151209203836.GI5727@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id C0004261B25
 for <alsa-devel@alsa-project.org>; Thu, 10 Dec 2015 10:49:08 +0100 (CET)
In-Reply-To: <20151209203836.GI5727@sirena.org.uk>
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



On 12/10/2015 04:38 AM, Mark Brown wrote:
> On Wed, Dec 09, 2015 at 05:09:31PM +0800, Mengdong Lin wrote:
>
>> I have no intention to replace the existing aux_devs with aux_components.
>> The aux_components is not for codecs and has no rtd like aux_dev.
>
> OK, but I do think that's something we *should* be doing as part of the
> overall move of CODECs to components and it's something that having this
> change implies we should be doing as an immediate thing since it's the
> more obvious direct use of the code (as Lars said in reply to the early
> draft you posted IIRC).

My early draft didn't use the aux components, so I'm not sure where to 
find Lars's comments on this idea.

Please check if my understanding is right?

I guess you want me to replace the "aux_dev" array from the struct 
snd_soc_card, by an "aux_components" array. And we may
replace soc_bind_aux_dev() by soc_find_components(),
replace soc_probe/remove_aux_dev() by soc_probe/remove_components.
Probably soc_find/prove/remove_components need some adjustment for the 
the aux devices (DAIless codecs).

And device driver of the these aux_dev need to use 
snd_soc_register_component() to make it as a component.

>> The purpose to introduce aux_components here is to let a soc card to load
>> topology info easier:
>
>> E.g. The machine driver may not define any FE DAI links explicitly but
>> specify an aux component. And the platform driver can implement the aux
>> component and let its probe ops to load the topology info. When the ASoC
>> core is instantiating the soc card, it must to find the aux component and
>> probe it (the platform component). Thus the topology info for the platform
>> is loaded and topology core will create widgets/controls/routes/DAIs/DAI
>> links. So after probing the aux components, the ASoC need to check if any
>> new links are created, bind them and create pcm runtimes for them.
>
> I think I'd need to see the code you're proposing here to really comment
> but I think it sounds like it comes back to the same thing as the above
> case where we're overall trying to move everything towards uniformly
> being components.


In my test cases, the Broadwell machine driver 
(sound/soc/intel/boards/broadwell.c) specifies the name an aux component 
for the soc card:


+static struct snd_soc_aux_component broadwell_topology_components[] = {
+       /* Platform topology component */
+       {
+               .name = "haswell-pcm-audio",
+       },
+};

  /* broadwell audio machine driver for WPT + RT286S */
  static struct snd_soc_card broadwell_rt286 = {
         .name = "broadwell-rt286",
         .owner = THIS_MODULE,
+       .aux_components = broadwell_topology_components,
+       .num_aux_components = ARRAY_SIZE(broadwell_topology_components),
         .dai_link = broadwell_rt286_dais,
         .num_links = ARRAY_SIZE(broadwell_rt286_dais),
         .controls = broadwell_controls,


Actually, the component "haswell-pcm-audio" is the component name for 
the platform (sound/soc/intel/haswell/sst-haswell-pcm.c).

When the ASoC core instantiates the soc card, it will find the aux 
component at first, which is available only after the platform is 
registered. Then the ASoC will probe the aux component which triggers 
the platform probe ops and this ops loads the topology info.

Thanks
Mengdong














>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
