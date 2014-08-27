From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH 1/2] regmap: cache: Fix regcache_sync_block
 for	non-autoincrementing devices
Date: Wed, 27 Aug 2014 08:52:16 +0300
Message-ID: <53FD7210.606@linux.intel.com>
References: <1409061793-10495-1-git-send-email-jarkko.nikula@linux.intel.com>	<1409061793-10495-2-git-send-email-jarkko.nikula@linux.intel.com> <s5hk35vpc18.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hk35vpc18.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 08/26/2014 05:21 PM, Takashi Iwai wrote:
> At Tue, 26 Aug 2014 17:03:12 +0300,
> Jarkko Nikula wrote:
>> Commit 75a5f89f635c ("regmap: cache: Write consecutive registers in a single
>> block write") expected that autoincrementing writes are supported if
>> hardware has a register format which can support raw writes.
>>
>> This is not necessarily true and thus for instance rbtree sync can fail when
>> there is need to sync multiple consecutive registers but block write to
>> device fails due not supported autoincrementing writes.
>>
>> Fix this by spliting raw block sync to series of single register writes for
>> devices that don't support autoincrementing writes.
> Wouldn't it suffice to correct regmap_can_raw_write() to return false
> if map->use_single_rw is set?
>
I don't know. I was thinking that also but was unsure about it since 
regcache_sync_block_raw() and regcache_sync_block_single() code paths 
use different regmap write functions. regcache_sync_block_raw() ends up 
calling _regmap_raw_write() which takes care of page select operation 
when needed and regcache_sync_block_single() uses _regmap_write() which 
doesn't.

Which makes me thinking should the regcache_sync_block_single() also use 
_regmap_raw_write() in order to take care of page selects?

-- 
Jarkko
