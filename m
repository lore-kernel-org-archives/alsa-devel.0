From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: [PATCH -next] soc: fix wm0010.c printk format warning
Date: Wed, 05 Sep 2012 17:11:08 -0700
Message-ID: <5047EA1C.7080608@xenotime.net>
References: <20120905161230.3bab1de6d4c8c8e466c3b0df@canb.auug.org.au> <5047DF49.6070502@xenotime.net> <20120906000612.GO10580@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20120906000612.GO10580@opensource.wolfsonmicro.com>
Sender: linux-next-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 09/05/2012 05:06 PM, Mark Brown wrote:

> On Wed, Sep 05, 2012 at 04:24:57PM -0700, Randy Dunlap wrote:
>> From: Randy Dunlap <rdunlap@xenotime.net>
>>
>> Fix printk format warning:
> 
> Somone already sent this.  As ever please try to use subject lines
> appropriate for the subsystem.  Please also consider who you're CCing -


Unfortunately the MAINTAINERS file does not tell me what to include
in the $subject line for the subsystem.
What would you like to see there, please?  Maybe ASoC?

> there's no need to copy -next on things like this which aren't


I have always done a reply-to-all for linux-next patches, so after
a few years someone days Don't Do That (IYO).

> integration issues for example, if we start doing that then it'd get
> drowned in noise from all the development.


Agreed, many of us are already drowning from 1000+ emails per day.
(seriously)

-- 
~Randy
