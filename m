From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: Intel: bytcht_es8316: fix cast warning
Date: Wed, 24 Apr 2019 16:13:34 -0700
Message-ID: <13969360-f863-e93e-9d48-d27c0034795a@linux.intel.com>
References: <20190424114114.27073-1-anders.roxell@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190424114114.27073-1-anders.roxell@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Anders Roxell <anders.roxell@linaro.org>, liam.r.girdwood@linux.intel.com, yang.jie@linux.intel.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 4/24/19 6:41 AM, Anders Roxell wrote:
> When building bytcht_es8316 the following warning shows up:
> 
> ../sound/soc/intel/boards/bytcht_es8316.c: In function ‘snd_byt_cht_es8316_mc_probe’:
> ../sound/soc/intel/boards/bytcht_es8316.c:508:11: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>     quirk = (int)dmi_id->driver_data;
>             ^
> 
> Rework to use uintptr_t instead of int.
> 
> Fixes: a8d218f4fe81 ("ASoC: Intel: bytcht_es8316: Add quirk for the Teclast X98+ II")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

I submitted an alternate fix last Friday to alsa-devel, along with 2 
additional patches to handle the quirk_override in the same way between 
machine drivers.
