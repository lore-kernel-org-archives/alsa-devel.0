From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 09/11] ASoC: Intel: Skylake: Fix DMA
 position reporting for capture stream
Date: Thu, 23 Mar 2017 10:31:30 -0500
Message-ID: <b73996bd-1a67-1f6a-e6da-04dd9c719451@linux.intel.com>
References: <1490275926-2270-1-git-send-email-jeeja.kp@intel.com>
 <1490275926-2270-10-git-send-email-jeeja.kp@intel.com>
 <8e50b63f-a9e7-537b-af1e-93e120d81ef9@linux.intel.com>
 <85DFEED57DC57344B2483EF7BF8CB60552D0BABB@BGSMSX104.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C995266AF5
 for <alsa-devel@alsa-project.org>; Thu, 23 Mar 2017 16:31:24 +0100 (CET)
In-Reply-To: <85DFEED57DC57344B2483EF7BF8CB60552D0BABB@BGSMSX104.gar.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Ughreja, Rakesh A" <rakesh.a.ughreja@intel.com>, "Kp, Jeeja" <jeeja.kp@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "R, Dharageswari" <dharageswari.r@intel.com>, "tiwai@suse.de" <tiwai@suse.de>, "Shah, Hardik T" <hardik.t.shah@intel.com>, Patches Audio <patches.audio@intel.com>, "broonie@kernel.org" <broonie@kernel.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org


>>>  	 * HAD space reflects the actual data that is transferred.
>>>  	 * Use the position buffer for capture, as DPIB write gets
>>>  	 * completed earlier than the actual data written to the DDR.
>>> +	 *
>>> +	 * For capture stream following workaround is required to fix the
>>> +	 * incorrect position reporting.
>>> +	 *
>>> +	 * 1. Wait for 20us before reading the DMA position in buffer once
>>> +	 * the interrupt is generated for stream completion.
>>
>> is this really 20us regardless of the sampling frequency/channel count?
>> 20us is one sample at 48kHz so wondering how generic this work-around is...
>
> Yes, this is independent of PCM parameters. Update happens on the
> HDA frame boundary i.e. 20.833uSec.

Makes sense. it's worth updating the comments though to make it 
self-explanatory.
