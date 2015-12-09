From: Mengdong Lin <mengdong.lin@linux.intel.com>
Subject: Re: [PATCH 5/5] ASoC: The soc card can have auxiliary
 components
Date: Wed, 9 Dec 2015 17:09:31 +0800
Message-ID: <5667EFCB.3010402@linux.intel.com>
References: <cover.1449036307.git.mengdong.lin@linux.intel.com>
 <bb343fe20b14af90f695939d8faae50fae1ba97a.1449036307.git.mengdong.lin@linux.intel.com>
 <20151208185817.GX5727@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 392D326065A
 for <alsa-devel@alsa-project.org>; Wed,  9 Dec 2015 09:53:22 +0100 (CET)
In-Reply-To: <20151208185817.GX5727@sirena.org.uk>
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


On 12/09/2015 02:58 AM, Mark Brown wrote:
> On Wed, Dec 02, 2015 at 02:11:56PM +0800, mengdong.lin@linux.intel.com wrote:
>> From: Mengdong Lin <mengdong.lin@linux.intel.com>
>>
>> Machine drivers can set the name of one or more auxiliary components.
>> And the ASoC core will find and probe the auxiliary components.
>>
>> Machine drivers can use this to specify the components with topology.
>> Then when the components are probed, topology info will be loaded to
>> the core.
>
> This makes sense as a replacement for the existing aux_devs but this
> doesn't feel terribly strongly related to the rest of the series and
> we're not actually doing the transition yet.  What's the relationship
> with dynamic links and what's the plan for transition?  There's CODECs
> that could be transitioned relatively straightforwardly since they have
> no DAIs and can only be used as aux_devs, it's them I'm mainly thinking
> of here - the rest will need to wait I fear.
>

Thanks for your comments!

I have no intention to replace the existing aux_devs with 
aux_components. The aux_components is not for codecs and has no rtd like 
aux_dev.

The purpose to introduce aux_components here is to let a soc card to 
load topology info easier:

E.g. The machine driver may not define any FE DAI links explicitly but 
specify an aux component. And the platform driver can implement the aux 
component and let its probe ops to load the topology info. When the ASoC 
core is instantiating the soc card, it must to find the aux component 
and probe it (the platform component). Thus the topology info for the 
platform is loaded and topology core will create 
widgets/controls/routes/DAIs/DAI links. So after probing the aux 
components, the ASoC need to check if any new links are created, bind 
them and create pcm runtimes for them.

Regards
Mengdong
