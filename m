From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH 01/10] ASoC: tlv320aic32x4: Remove filename from header
 and switch to SPDX
Date: Wed, 13 Dec 2017 10:13:21 -0600
Message-ID: <1ec05e88-b605-7ab4-ee5d-b3b73c562a0c@ti.com>
References: <20171212224311.24045-1-afd@ti.com>
 <20171213122824.GI6416@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171213122824.GI6416@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 12/13/2017 06:28 AM, Mark Brown wrote:
> On Tue, Dec 12, 2017 at 04:43:02PM -0600, Andrew F. Davis wrote:
> 
>> @@ -1,21 +1,10 @@
>> +// SPDX-License-Identifier: GPL-2.0
>>  /*
>> - * linux/sound/soc/codecs/tlv320aic32x4-i2c.c
>> - *
>>   * Copyright 2011 NW Digital Radio
>>   *
> 
> Having the C++ comment next to a C comment is very ugly, if you're going
> to do this convert the entire comment block to C++ style.
> 

Any C++ comments in non-C99 code is ugly.. Or whatever C standard the
kernel claims to use these days.

My regex is a bit too rusty right now to handle searching for multi-line
examples, do you know of anyone else converting the whole block to C++
style?

Things will look a lot uglier if we do this inconsistently, if it is now
the law of the land we do this for the first line, then we should have
it be the only exception. Everywhere else remaining old style comments,
IMHO.
