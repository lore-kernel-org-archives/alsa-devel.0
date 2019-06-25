From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH v2 00/11] Fix driver reload issues
Date: Tue, 25 Jun 2019 08:02:10 -0500
Message-ID: <f50433de-279a-cbc8-d91f-4e3a04bae450@linux.intel.com>
References: <20190617113644.25621-1-amadeuszx.slawinski@linux.intel.com>
 <20190625120450.GR5316@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190625120450.GR5316@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= <amadeuszx.slawinski@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Jie Yang <yang.jie@linux.intel.com>, Cezary Rojewski <cezary.rojewski@intel.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 6/25/19 7:04 AM, Mark Brown wrote:
> On Mon, Jun 17, 2019 at 01:36:33PM +0200, Amadeusz Sławiński wrote:
>> Hi,
>>
>> This series of patches introduces fixes to various issues found while
>> trying to unload all snd* modules and then loading them again. This
>> allows for modules to be really _modules_ and be unloaded and loaded on
>> demand, making it easier to develop and test them without constant
>> system reboots.
> 
> Pierre?  You did comment on the general concept in one of the patches
> but not on any of the patches directly.

I did review the patches internally and the v1. For the v2 I could only 
do an airport lounge review and didn't see any blatant issues, so feel 
free to take the following tag for the series.

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
