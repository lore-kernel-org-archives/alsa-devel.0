From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [alsa-devel] [PATCH v2 1/3] ASoC: topology: Improve backwards
 compatibility with v4 topology files
Date: Sun, 27 May 2018 23:38:20 -0700
Message-ID: <a5444567-2577-f65b-fc16-b234fa5486ec@roeck-us.net>
References: <1527191363-21021-1-git-send-email-linux@roeck-us.net>
 <20180525133323.GI3116@snc-desk> <20180528060347.GA5666@vkoul-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180528060347.GA5666@vkoul-mobl>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod <vkoul@kernel.org>, Shreyas NC <shreyas.nc@intel.com>
Cc: Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, linux-kernel@vger.kernel.org, Chintan Patel <chintan.m.patel@intel.com>, Guenter Roeck <groeck@chromium.org>
List-Id: alsa-devel@alsa-project.org

On 05/27/2018 11:03 PM, Vinod wrote:
[ ... ]
>>> diff --git a/sound/soc/intel/skylake/skl-tplg-interface.h b/sound/soc/intel/skylake/skl-tplg-interface.h
>>> index f8d1749a2e0c..b0e3d376594c 100644
>>> --- a/sound/soc/intel/skylake/skl-tplg-interface.h
>>> +++ b/sound/soc/intel/skylake/skl-tplg-interface.h
> 
> Don't we want to move these to upai/ as that is right place and use that in
> alsa-lib.
> 

I did that in patch 3 of the series [1].

Guenter
---
[1] https://patchwork.kernel.org/patch/10425387/
