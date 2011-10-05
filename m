From: Axel Lin <axel.lin@gmail.com>
Subject: Re: [PATCH] ASoC: ak4535: Set codec->hw_write to i2c_master_send
Date: Thu, 6 Oct 2011 07:46:36 +0800
Message-ID: <CAF+7xWkCJG3r32m8rSVY3v+bCYzjNnW9RsthXPnjRQUxnBGUfg@mail.gmail.com>
References: <1317799677.21481.6.camel@phoenix> <20111005161620.GB11528@opensource.wolfsonmicro.com>
Reply-To: axel.lin@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111005161620.GB11528@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-kernel@vger.kernel.org, Richard Purdie <rpurdie@rpsys.net>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2011/10/6 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Wed, Oct 05, 2011 at 03:27:56PM +0800, Axel Lin wrote:
>> It was removed in commit f0fba2ad
>> "ASoC: multi-component - ASoC Multi-Component Support".
>>
>> Add it back, otherwise codec->hw_write points to NULL.
>
> It's better to fix the driver not to use hw_write any more, it's broken
> without anyway.
>
It's better convert to soc-cache.
But this one-line-fix may be ok for 3.1.
