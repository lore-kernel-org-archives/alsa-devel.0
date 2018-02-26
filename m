From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v1 8/9] ASoC: hdac_hda: add asoc extension
 for legacy HDA codec drivers
Date: Mon, 26 Feb 2018 12:26:29 -0700
Message-ID: <dbfd0e9e-b8fc-040d-5e2c-de1fe3839ea2@linux.intel.com>
References: <1519373550-2545-1-git-send-email-rakesh.a.ughreja@intel.com>
 <1519373550-2545-9-git-send-email-rakesh.a.ughreja@intel.com>
 <c000a722-0ad0-2c52-fd00-f4134ca47858@linux.intel.com>
 <85DFEED57DC57344B2483EF7BF8CB60579B29B12@BGSMSX104.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 42A6A26766D
 for <alsa-devel@alsa-project.org>; Tue, 27 Feb 2018 02:49:20 +0100 (CET)
In-Reply-To: <85DFEED57DC57344B2483EF7BF8CB60579B29B12@BGSMSX104.gar.corp.intel.com>
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
To: "Ughreja, Rakesh A" <rakesh.a.ughreja@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, "tiwai@suse.de" <tiwai@suse.de>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>
Cc: "Koul, Vinod" <vinod.koul@intel.com>, Patches Audio <patches.audio@intel.com>
List-Id: alsa-devel@alsa-project.org

On 2/26/18 1:44 AM, Ughreja, Rakesh A wrote:
> 
> 
>> -----Original Message-----
>> From: Pierre-Louis Bossart [mailto:pierre-louis.bossart@linux.intel.com]
>> Sent: Friday, February 23, 2018 10:25 PM
>> To: Ughreja, Rakesh A <rakesh.a.ughreja@intel.com>; alsa-devel@alsa-
>> project.org; broonie@kernel.org; tiwai@suse.de;
>> liam.r.girdwood@linux.intel.com
>> Cc: Koul, Vinod <vinod.koul@intel.com>; Patches Audio
>> <patches.audio@intel.com>
>> Subject: Re: [PATCH v1 8/9] ASoC: hdac_hda: add asoc extension for legacy HDA
>> codec drivers
>>
>> On 2/23/18 2:12 AM, Rakesh Ughreja wrote:
>>> This patch adds a kernel module which is used by the legacy HDA
>>> codec drivers as library. This implements hdac_ext_bus_ops to enable
>>> the reuse of legacy HDA codec drivers with ASoC platform drivers.
>>>
>>> Signed-off-by: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
>>> ---
>>>    sound/pci/hda/hda_bind.c    |   6 +
>>>    sound/soc/codecs/Kconfig    |   5 +
>>>    sound/soc/codecs/Makefile   |   2 +
>>>    sound/soc/codecs/hdac_hda.c | 448
>> ++++++++++++++++++++++++++++++++++++++++++++
>>>    sound/soc/codecs/hdac_hda.h |  23 +++
>>>    5 files changed, 484 insertions(+)
>>>    create mode 100644 sound/soc/codecs/hdac_hda.c
>>>    create mode 100644 sound/soc/codecs/hdac_hda.h
>>
>> so now we have both hdac_hdmi and hdac_hda?
>> Not sure I get it.
> 
> hdac_hdmi is the ASoC HDMI driver which exists today. All the
> intel ASoC driver which are primarily used for I2S codecs uses it.
> I am not deleting or removing the support for that.
> 
> hdac_hda is the ASoC wrapper around the legacy HDA drivers.
> 
> Now with this patch series, we have two choices for HDMI/iDisp
> codec driver. Either to use the legacy HDMI codec driver by using
> the ASoC wrapper or use the existing ASoC hdac_hdmi driver.
> 
> Since Intel ASoC platform driver is already proven and tested
> with ASoC hdac_hdmi driver, I am using that in this patch series.

I get your point, but I will assert that the legacy HDMI codec has been 
tested a lot more than the ASoC one (only for Chromebooks) so I wonder 
if we shouldn't deprecate hdac_hdmi moving forward. Having two codec 
implementations which both talk to the i915 driver makes no sense for 
long term support. We don't need to do this now but it should be on the 
TODO list along with topology support in machine drivers.
