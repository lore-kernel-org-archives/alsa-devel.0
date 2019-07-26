From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v3 2/5] ALSA: hda: move parts of NHLT code
 to new module
Date: Fri, 26 Jul 2019 10:41:34 -0500
Message-ID: <7a46f2df-54e8-fdf8-8ce9-934aa84295b9@linux.intel.com>
References: <20190722134410.9602-1-pierre-louis.bossart@linux.intel.com>
 <20190722134410.9602-3-pierre-louis.bossart@linux.intel.com>
 <b302a687-36a8-c3b4-32a9-27c47d3fb9cd@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 27E22F801A4
 for <alsa-devel@alsa-project.org>; Fri, 26 Jul 2019 17:41:37 +0200 (CEST)
In-Reply-To: <b302a687-36a8-c3b4-32a9-27c47d3fb9cd@intel.com>
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
To: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, Daniel Drake <drake@endlessm.com>, Hui Wang <hui.wang@canonical.com>, Curtis Malainey <cujomalainey@google.com>, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org



On 7/26/19 7:10 AM, Cezary Rojewski wrote:
> On 2019-07-22 15:44, Pierre-Louis Bossart wrote:
>> Move parts of the code outside of the Skylake driver to help detect
>> the presence of DMICs (which are not supported by the HDaudio legacy
>> driver).
>>
>> No functionality change (except for the removal of useless OR
>> operations), only indentation and checkpatch fixes, and making sure
>> that the code compiles without ACPI
>>
>> Signed-off-by: Pierre-Louis Bossart 
>> <pierre-louis.bossart@linux.intel.com>
> 
> I didn't really see response to previous review apart from CONFIG_ thingy.

I just realize I missed your other comments, will look at them later today.

> - By the way, thanks Takashi for in-depth explanation!
> 
> https://mailman.alsa-project.org/pipermail/alsa-devel/2019-July/152407.html
> 
> Especially the ACPI leak part, though I'd hoped you would jump on my 
> shift-left train too :s
> Although, maybe those changes should be separated from relocation patch 
> and ignored for current series..
> 
> Czarek
