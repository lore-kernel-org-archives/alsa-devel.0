From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [bug report] ASoC: dapm: Implement and instantiate
 DAI widgets
Date: Fri, 20 Jan 2017 10:52:31 +0100
Message-ID: <CACRpkdaYeHay2YFTNVEJo3y04dpA9XiSwZmMJ=go3TLt3O5qwQ@mail.gmail.com>
References: <20170119073826.GA28899@mwanda> <20170119092046.GK3573@localhost>
 <20170119103017.GE4398@mwanda>
 <9a00a406-c3b1-39c1-5aea-7ea5b2735dbb@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f169.google.com (mail-io0-f169.google.com
 [209.85.223.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 504282666F1
 for <alsa-devel@alsa-project.org>; Fri, 20 Jan 2017 10:52:32 +0100 (CET)
Received: by mail-io0-f169.google.com with SMTP id j18so58880076ioe.2
 for <alsa-devel@alsa-project.org>; Fri, 20 Jan 2017 01:52:32 -0800 (PST)
In-Reply-To: <9a00a406-c3b1-39c1-5aea-7ea5b2735dbb@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Vinod Koul <vinod.koul@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 19, 2017 at 1:25 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 01/19/2017 11:30 AM, Dan Carpenter wrote:
>> On Thu, Jan 19, 2017 at 02:50:46PM +0530, Vinod Koul wrote:
>>> On Thu, Jan 19, 2017 at 10:38:26AM +0300, Dan Carpenter wrote:
>>>> Hello Mark Brown,
>>>
>>> Dan you need to update Mark's email in your address book, its been a while
>>> since he moved away from wolfson..
>>>
>>
>> Oh crap!  This warning is from 2012...  I really need to update my
>> scripts so I stop sending really ancient warnings.
>
> The warning is correct. It's just the wrong commit. The issue was introduced
> with commit 37e1df8c95e2 ("ASoC: dapm: handle probe deferrals"). The commit
> introduces ERR_PTR() as a possible return value for the function, but does
> not update all callers.

Yeah so the DAPM code was violating the regulator and clock
APIs by ignoring potential error pointers (just doing NULL checks), so I
made it aware of this, but oops it created a downstream problem that everyone
using DAPM gets the cascaded error pointer.

I just have to bit the bullet and make a patch updating all DAPM
consumers, it's just work, I'll keep you in CC.

Yours,
Linus Walleij
