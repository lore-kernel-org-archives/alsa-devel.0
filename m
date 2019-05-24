From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC PATCH 5/6] ALSA / hda: stop probe if DMICS
 are detected on Skylake+ platforms
Date: Fri, 24 May 2019 08:18:36 -0500
Message-ID: <3b8a3259-df2a-26b9-ae7e-b32bb036245a@linux.intel.com>
References: <20190523233951.31122-1-pierre-louis.bossart@linux.intel.com>
 <20190523233951.31122-6-pierre-louis.bossart@linux.intel.com>
 <s5hlfywe15c.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F111AF806F7
 for <alsa-devel@alsa-project.org>; Fri, 24 May 2019 15:18:39 +0200 (CEST)
In-Reply-To: <s5hlfywe15c.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: Hui Wang <hui.wang@canonical.com>, Curtis Malainey <cujomalainey@google.com>, alsa-devel@alsa-project.org, broonie@kernel.org, Daniel Drake <drake@endlessm.com>
List-Id: alsa-devel@alsa-project.org



On 5/24/19 2:56 AM, Takashi Iwai wrote:
> On Fri, 24 May 2019 01:39:50 +0200,
> Pierre-Louis Bossart wrote:
>>
>> The legacy HD-Audio driver cannot handle Skylake+ platforms with
>> digital microphones. For those platforms, the SOF driver needs to be
>> used.
>>
>> Use the common intel-nhlt module to stop the probe when the DSP is
>> enabled and DMICs are exposed in the NHTL tables.
>>
>> Note: This assumes that the BIOS information is correct, and
>> additional testing is required to see on which platforms the detection
>> is a false positive.
>>
>> FIXME: I need to find what is the mirror of azx_create() to free all
>> the resources on exit.
> 
> azx_free() does the whole, so just goto out_free should suffice.

ok, thanks for the feedback!
