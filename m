From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [bug report] ASoC: dapm: Implement and instantiate
 DAI widgets
Date: Thu, 19 Jan 2017 13:25:57 +0100
Message-ID: <9a00a406-c3b1-39c1-5aea-7ea5b2735dbb@metafoo.de>
References: <20170119073826.GA28899@mwanda> <20170119092046.GK3573@localhost>
 <20170119103017.GE4398@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 05E08266CC1
 for <alsa-devel@alsa-project.org>; Thu, 19 Jan 2017 13:26:03 +0100 (CET)
In-Reply-To: <20170119103017.GE4398@mwanda>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>, Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org

On 01/19/2017 11:30 AM, Dan Carpenter wrote:
> On Thu, Jan 19, 2017 at 02:50:46PM +0530, Vinod Koul wrote:
>> On Thu, Jan 19, 2017 at 10:38:26AM +0300, Dan Carpenter wrote:
>>> Hello Mark Brown,
>>
>> Dan you need to update Mark's email in your address book, its been a while
>> since he moved away from wolfson..
>>
> 
> Oh crap!  This warning is from 2012...  I really need to update my
> scripts so I stop sending really ancient warnings.

The warning is correct. It's just the wrong commit. The issue was introduced
with commit 37e1df8c95e2 ("ASoC: dapm: handle probe deferrals"). The commit
introduces ERR_PTR() as a possible return value for the function, but does
not update all callers.

- Lars
