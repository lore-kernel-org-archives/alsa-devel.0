From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC PATCH 0/6] ALSA/HDA: abort probe when DMICs
 are detected
Date: Fri, 24 May 2019 13:38:04 -0500
Message-ID: <d399bbcb-c094-d0b9-5ae3-8267ee613d6f@linux.intel.com>
References: <20190523233951.31122-1-pierre-louis.bossart@linux.intel.com>
 <s5hk1ege12p.wl-tiwai@suse.de>
 <284f78d4-ec5a-0ff1-2b67-2977b3634692@linux.intel.com>
 <CAD8Lp47qCbPh+aZjr0pjzZAcBXqRbMU+5Y_HPy7jrJhUgsD3Tg@mail.gmail.com>
 <72729168-214a-264d-c704-f718d7cfde4b@linux.intel.com>
 <CAD8Lp47Yc5CwkM-y=eqXdPDZ7+1=qa6m1sCELhBsidsYYSzfQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 573D3F8962F
 for <alsa-devel@alsa-project.org>; Fri, 24 May 2019 20:38:07 +0200 (CEST)
In-Reply-To: <CAD8Lp47Yc5CwkM-y=eqXdPDZ7+1=qa6m1sCELhBsidsYYSzfQQ@mail.gmail.com>
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



On 5/24/19 12:34 PM, Daniel Drake wrote:
> Still not quite clear about the default behaviour here.
> 
> On Fri, May 24, 2019 at 10:12 AM Pierre-Louis Bossart
> <pierre-louis.bossart@linux.intel.com> wrote:
>> b) the decision to abort the HDaudio legacy driver probe should not be
>> the default, since it depends on BIOS information that may be wrong and
>> on which I have *zero* control.
>> [...]
>> 1. DMICs attached to PCH and BIOS/NHLT reports DMICS -> abort HDaudio
>> legacy probe
> 
> In the case of DMICs attached to PCH and BIOS/NHLT reports DMIC, is
> the HDaudio legacy probe aborted by default or not?

no.
