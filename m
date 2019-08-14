From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [BUG] bdw-rt5650 DSP boot timeout
Date: Wed, 14 Aug 2019 15:51:15 -0500
Message-ID: <d80c2f4d-b5f4-5bbe-9529-36b9859ab8be@linux.intel.com>
References: <CACJJ=pxPm7dRUE534hDWy2tN3dGYDyrgU8JKqett=wOQx+nWCQ@mail.gmail.com>
 <39533fe5-c060-7a07-c910-74b83eee53c4@linux.intel.com>
 <ac7bcb42e40ac12d9924fd65c3e2c68b9b11b093.camel@linux.intel.com>
 <37ede7ea-e760-eac9-a1d5-0eb8e3bff3cb@linux.intel.com>
 <CACJJ=pyb==xWqKMB-gAzW7-FCFgEU7Rm+b-CL-ANO-eorDKy=A@mail.gmail.com>
 <356b3f4eacb43f23c40c4cd8e3c54ae9514a34c6.camel@linux.intel.com>
 <7e08e45d-7cec-9fdd-36c5-5e82632968f8@linux.intel.com>
 <CACJJ=pzcMCaOvHMVhmYKKL2Z45-XdrBB9FT8VjSzX_obVtKzyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1A940F801DF
 for <alsa-devel@alsa-project.org>; Wed, 14 Aug 2019 22:51:19 +0200 (CEST)
In-Reply-To: <CACJJ=pzcMCaOvHMVhmYKKL2Z45-XdrBB9FT8VjSzX_obVtKzyw@mail.gmail.com>
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
To: Jon Flatley <jflat@chromium.org>, yang.jie@intel.com
Cc: benzh@chromium.org, alsa-devel@alsa-project.org, Jie Yang <yang.jie@linux.intel.com>, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, cujomalainey@chromium.org
List-Id: alsa-devel@alsa-project.org


> There seems to be an issue when suspending the ALC5650. I think the
> nondeterministic behavior I was seeing just had to do with whether or
> not the DSP had yet suspended.
> 
> I reverted commit 0d2135ecadb0 ("ASoC: Intel: Work around to fix HW D3
> potential crash issue") and things started working, including
> suspend/resume of the DSP. Any ideas for why this may be? I would like
> to resolve this so I can finish upstreaming the bdw-rt5650 machine
> driver.

Copying Keyon in case he remembers the context.

Reverting a 5yr-old commit with all sorts of clock/power-related fixes 
looks brave, and it's not clear why this would work with the rt5677 and 
not with 5650.

Are you using the latest upstream firmware btw? Or the one which shipped 
with the initial device (which could be an issue if the protocol changed).
