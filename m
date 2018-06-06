From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH v2 1/3] ASoC: topology: Improve backwards
 compatibility with v4 topology files
Date: Wed, 6 Jun 2018 15:29:24 -0500
Message-ID: <6fc091cf-bf63-9dae-40cd-8603c980cf95@linux.intel.com>
References: <1527191363-21021-1-git-send-email-linux@roeck-us.net>
 <20180601102506.GB8677@sirena.org.uk>
 <0015aace-fe32-9707-d3c9-0dea6f5fc48c@roeck-us.net>
 <8452aca6-0ae4-9fe1-c8cd-9f84e34f509f@linux.intel.com>
 <20180601170847.GC8677@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180601170847.GC8677@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Chintan Patel <chintan.m.patel@intel.com>, Guenter Roeck <groeck@chromium.org>, Guenter Roeck <linux@roeck-us.net>
List-Id: alsa-devel@alsa-project.org



On 06/01/2018 12:08 PM, Mark Brown wrote:
> On Fri, Jun 01, 2018 at 10:19:58AM -0500, Pierre-Louis Bossart wrote:
>
>> I wanted to ack this patch but the Intel validation folks asked for a couple
>> of days to finish their tests on a variety of Chromebooks (e.g. Lars) and
>> double-check which models used the v4 topology. There is an internal thread
>> on all this which remains active. I don't think the feedback will be delayed
>> beyond early next week.
> OK, I'm expecting the merge window to open over the weekend so I think
> I'm just going to apply now so we it's in -next when that happens.
quick follow-up note: Intel folks successfully tested this patchset on 
chell, sentry, lars, glados, asuka platforms. There is an unrelated 
issue on chell with playback not working, but at least the topology 
parsing is handled correctly with Guenter's contribution.
