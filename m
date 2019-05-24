From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC PATCH 0/6] ALSA/HDA: abort probe when DMICs
 are detected
Date: Fri, 24 May 2019 11:12:34 -0500
Message-ID: <72729168-214a-264d-c704-f718d7cfde4b@linux.intel.com>
References: <20190523233951.31122-1-pierre-louis.bossart@linux.intel.com>
 <s5hk1ege12p.wl-tiwai@suse.de>
 <284f78d4-ec5a-0ff1-2b67-2977b3634692@linux.intel.com>
 <CAD8Lp47qCbPh+aZjr0pjzZAcBXqRbMU+5Y_HPy7jrJhUgsD3Tg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7D9EDF806F7
 for <alsa-devel@alsa-project.org>; Fri, 24 May 2019 18:12:38 +0200 (CEST)
In-Reply-To: <CAD8Lp47qCbPh+aZjr0pjzZAcBXqRbMU+5Y_HPy7jrJhUgsD3Tg@mail.gmail.com>
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
To: Daniel Drake <drake@endlessm.com>
Cc: Takashi Iwai <tiwai@suse.de>, Hui Wang <hui.wang@canonical.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Curtis Malainey <cujomalainey@google.com>
List-Id: alsa-devel@alsa-project.org



On 5/24/19 10:45 AM, Daniel Drake wrote:
> Thanks for the patches!
> 
> On Fri, May 24, 2019 at 7:26 AM Pierre-Louis Bossart
> <pierre-louis.bossart@linux.intel.com> wrote:
>> I am not sure if it's a good idea to enable this by default, the
>> experience of the first round showed it's risky to make assumptions on
>> what BIOS vendors implemented.
> 
> Can you clarify what you mean here, are you saying you don't want to
> enable this new DMIC hardware support by default?

No. What I am saying is that
a) the legacy HDaudio driver does not support DMICs
b) the decision to abort the HDaudio legacy driver probe should not be 
the default, since it depends on BIOS information that may be wrong and 
on which I have *zero* control.

There are 4 cases really:

1. DMICs attached to PCH and BIOS/NHLT reports DMICS -> abort HDaudio 
legacy probe
2. No DMICs attached to PCH and BIOS/NHLT does not report DMICs -> 
continue probe and use HDAudio legacy.
3. DMICs attached to PCH and BIOS/NHLT does not report DMICs -> broken 
config, we will need an option to abort the probe by force and ignore 
the BIOS if you care about audio capture.
4. no DMICs attached to PCH and BIOS/NHLT reports DMICs -> broken 
config, we need an option to ignore the BIOS and continue the probe.

Does this help?
