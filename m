From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 4/8] firmware: Sigma: Mark firmware strutcs packed
Date: Fri, 25 Nov 2011 11:48:20 +0100
Message-ID: <4ECF7274.2020502@metafoo.de>
References: <1322138908-32127-1-git-send-email-lars@metafoo.de> <1322138908-32127-4-git-send-email-lars@metafoo.de> <201111241219.37220.vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201111241219.37220.vapier@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, drivers@analog.com, stable@kernel.org
List-Id: alsa-devel@alsa-project.org

On 11/24/2011 06:19 PM, Mike Frysinger wrote:
> On Thursday 24 November 2011 07:48:23 Lars-Peter Clausen wrote:
>> Mark structs which are embedded into the firmware as packed to avoid
>> alignment issues.
> 
> while in general this makes sense, i designed the struct layout specifically to 
> work on any sane system.  that means 8bits align on 8bits, 16bits align on 
> 16bits, and 32bits align on 32bits.
> 
> do you see any place where this is not the case ?  otherwise, using __packed 
> by itself doesn't make much sense unless you also change all the loads from 
> the struct to the get_unaligned variety which would add useless overhead to 
> many embedded parts.
> 
> all in all, i'd omit the __packed markings since they're unnecessary.
> -mike

While you are right I think it's generally a good idea to mark anything as
packed, where we don't have direct influence on the alignment, to avoid
unpleasant suppresses. The compiler will usually take of performing proper
unaligned reads. I've though about adding a __aligned__(2) to the struct,
but since the majority of the data is 8bit data the overhead should be
negligible.

- Lars
