From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: arizona: Make logging of FLL calculations clearer
Date: Wed, 24 Feb 2016 17:39:32 +0000
Message-ID: <56CDEAD4.1050405@opensource.wolfsonmicro.com>
References: <1456236992-32028-1-git-send-email-rf@opensource.wolfsonmicro.com> <20160224040832.GQ18327@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160224040832.GQ18327@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: lgirdwood@gmail.com, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 24/02/16 04:08, Mark Brown wrote:
> On Tue, Feb 23, 2016 at 02:16:32PM +0000, Richard Fitzgerald wrote:
>> The debug logging of FLL calculations was confusing. Values were
>> printed in hex without indicating this by a leading 0x, and
>> despite these normally being required in decimal. Also where the
>> register value isn't the actual value (it s a power-of-two or
>> 0 means 1, 1 means 2, ...)  it was unclear whether the actual or
>> register value was shown.
> I think that stuff was originally based on the way the datasheets quote
> things:
>
>> -	arizona_fll_dbg(fll, "FRATIO=%x(%d) OUTDIV=%x REFCLK_DIV=%x\n",
> the hex(decimal) but there is certainly very familiar from some of
> those.
Indeed, and it was fine on the first codec. Now we've got various 
revisions of the FLL with some fields having different meanings, human 
error started to creep into interpreting the debug.
