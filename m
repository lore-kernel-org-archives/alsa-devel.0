From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: linux-next: Tree for May 23 (sound/soc/codecs)
Date: Mon, 23 May 2011 18:21:51 -0700
Message-ID: <4DDB082F.3010107@oracle.com>
References: <20110523154518.5e27cfb0.sfr@canb.auug.org.au>
	<20110523134815.fb87933a.randy.dunlap@oracle.com>
	<20110523224659.GB19533@opensource.wolfsonmicro.com>
	<20110523155343.2e68c265.randy.dunlap@oracle.com>
	<20110524000837.GA30515@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rcsinet10.oracle.com (rcsinet10.oracle.com [148.87.113.121])
	by alsa0.perex.cz (Postfix) with ESMTP id AB0E12433F
	for <alsa-devel@alsa-project.org>;
	Tue, 24 May 2011 03:22:09 +0200 (CEST)
In-Reply-To: <20110524000837.GA30515@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, alsa-devel@alsa-project.org, Dmitry Artamonow <mad_soft@inbox.ru>, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-next@vger.kernel.org, Harald Welte <laforge@gnufiish.org>
List-Id: alsa-devel@alsa-project.org

On 05/23/11 17:08, Mark Brown wrote:
> On Mon, May 23, 2011 at 03:53:43PM -0700, Randy Dunlap wrote:
>> On Tue, 24 May 2011 06:47:28 +0800 Mark Brown wrote:
> 
>>> case, please talk to the architecture maintainers about this - it's an
>>> issue in the architecture GPIO support (or lack thereof) rather than a
>>> driver problem.
> 
>> except that a driver should not assume that defines like
>> GPIOF_OUT_INIT_LOW are always available.
> 
> No, really we should.  The GPIO APIs are stubbed out when not in use for
> a very good reason, think about the usability here.  The goal here isn't
> to litter the code with ifdefs - if architectures aren't able to keep up
> with API changes they should convert to using gpiolib so this stuff
> happens automatically (indeed, I can't think of any good reason for an
> architecture to not be using gpiolib at this point).

No, I would say that there are a lot of drivers in sound/soc/codecs/
that are missing some GPIO pieces in the Kconfig file.

>>> Also adding Dmitry who submitted the driver - Randy, please try to
>>> remember to CC relevant people.
> 
>> Which driver did Dmitry submit?  how would I know that?
>> I don't download every linux-next git tree -- just linux-next tarballs.
> 
> I *strongly* suggest looking at git if you want to find relevant people
> to mail; the internal documentation in the code really isn't a terribly
> useful guide, the authors listed in the code often bear no relation to
> who's actually working on it at the current time.
> 
>> and wm8915.c says:
>> MODULE_AUTHOR("Mark Brown <broonie@opensource.wolfsonmicro.com>");
> 
> You've clearly not looked at MAINTAINERS for this one.

It's not listed in the MAINTAINERS file.
But maybe you mean scripts/get_maintainer.pl, which I did try.
I found that using git log <that source file name> was better info
than using scripts/get_maintainer.pl.


-- 
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
