From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH 11/11] ASoC: wm8994: Mark expected switch fall-through
Date: Fri, 3 Aug 2018 11:56:12 -0500
Message-ID: <684a4fe9-6818-d19c-e7b7-fb8d592a0cee@embeddedor.com>
References: <cover.1533151956.git.gustavo@embeddedor.com>
 <8e3df79b1dca92d49fd9d5c97391d31814ab40f9.1533151956.git.gustavo@embeddedor.com>
 <30613.1533313609@turing-police.cc.vt.edu>
 <85d918a5-6a14-ead0-4d0e-d63b5e43ad81@embeddedor.com>
 <20180803164504.GF6591@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180803164504.GF6591@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: valdis.kletnieks@vt.edu, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, patches@opensource.cirrus.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org



On 08/03/2018 11:45 AM, Mark Brown wrote:
> On Fri, Aug 03, 2018 at 11:41:39AM -0500, Gustavo A. R. Silva wrote:
>> On 08/03/2018 11:26 AM, valdis.kletnieks@vt.edu wrote:
>>> On Wed, 01 Aug 2018 14:56:16 -0500, "Gustavo A. R. Silva" said:
> 
>>> Wait, what? This looks like the sort of bug -Wimplicit-fallthrough is supposed
>>> to catch.  Unless for 'case WM8994_SYSCLK_OPCLK:' we actually do want to do a
>>> whole bunch of snd_soc_component_update_bits() calls and then return -EINVAL
>>> whether or not that case succeeded?
> 
>> Yeah, it seems like a bug. Can someone confirm this?
> 
>> Notice that this code has been there since 2010.
> 
> Basically nobody ever uses OPCLK so I'd be susprised if anyone ever
> noticed.
> 

I see. I wonder what's the best approach in this case. Should that code be removed instead of 'fixed'?

Thanks
--
Gustavo
