From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] gpio: add GPIOF_ values regardless on
	kconfig settings
Date: Fri, 3 Jun 2011 11:04:52 -0600
Message-ID: <BANLkTin-KSVcG2cQfRM3Ys0_g_uJVruDMw@mail.gmail.com>
References: <20110523134815.fb87933a.randy.dunlap@oracle.com>
	<20110523224659.GB19533@opensource.wolfsonmicro.com>
	<20110523155343.2e68c265.randy.dunlap@oracle.com>
	<20110524000837.GA30515@opensource.wolfsonmicro.com>
	<4DDB082F.3010107@oracle.com>
	<20110524014959.GA27710@opensource.wolfsonmicro.com>
	<4DDB3AFF.9030006@oracle.com>
	<20110524075248.GB19734@sirena.org.uk>
	<20110527074552.GA907@ponder.secretlab.ca>
	<4DDFE391.2030507@oracle.com>
	<20110527201201.GA6645@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51]) by alsa0.perex.cz (Postfix) with ESMTP id 78FA624464
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Jun 2011 19:05:15 +0200 (CEST)
Received: by pzk26 with SMTP id 26so915973pzk.38
	for <alsa-devel@alsa-project.org>; Fri, 03 Jun 2011 10:05:12 -0700 (PDT)
In-Reply-To: <20110527201201.GA6645@ponder.secretlab.ca>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, alsa-devel@alsa-project.org, x86@kernel.org, Dmitry Artamonow <mad_soft@inbox.ru>, Mark Brown <broonie@opensource.wolfsonmicro.com>, LKML <linux-kernel@vger.kernel.org>, linux-next@vger.kernel.org, Harald Welte <laforge@gnufiish.org>
List-Id: alsa-devel@alsa-project.org

On Fri, May 27, 2011 at 2:12 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Fri, May 27, 2011 at 10:46:57AM -0700, Randy Dunlap wrote:
>> From: Randy Dunlap <randy.dunlap@oracle.com>
>>
>> Make GPIOF_ defined values available even when GPIOLIB nor GENERIC_GPIO
>> is enabled by moving them to <linux/gpio.h>.
>>
>> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
>
> Applied, thanks.

Hi Randy,

I ended up not pushing this one to Linus.  Turns out it causes other
breakage on other platforms that don't include include/linux/gpio.h.
Since I don't have confidence that I'll be able to find all the
offenders, I'm dropping it.  I recommend making any drivers that are
breaking on these symbols depend on GPIOLIB.  Platforms not using
gpiolib are strongly discouraged now anyways, and there only a handful
of files in drivers/ that reference GPIOF_*.

g.
