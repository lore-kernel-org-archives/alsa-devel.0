From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH/RFC] gpio: add GPIOF_ values regardless
	on	kconfig settings
Date: Tue, 24 May 2011 08:52:48 +0100
Message-ID: <20110524075248.GB19734@sirena.org.uk>
References: <20110523154518.5e27cfb0.sfr@canb.auug.org.au>
	<20110523134815.fb87933a.randy.dunlap@oracle.com>
	<20110523224659.GB19533@opensource.wolfsonmicro.com>
	<20110523155343.2e68c265.randy.dunlap@oracle.com>
	<20110524000837.GA30515@opensource.wolfsonmicro.com>
	<4DDB082F.3010107@oracle.com>
	<20110524014959.GA27710@opensource.wolfsonmicro.com>
	<4DDB3AFF.9030006@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id DE95F103850
	for <alsa-devel@alsa-project.org>;
	Tue, 24 May 2011 09:52:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4DDB3AFF.9030006@oracle.com>
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, alsa-devel@alsa-project.org, Dmitry Artamonow <mad_soft@inbox.ru>, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, linux-next@vger.kernel.org, Harald Welte <laforge@gnufiish.org>
List-Id: alsa-devel@alsa-project.org

On Mon, May 23, 2011 at 09:58:39PM -0700, Randy Dunlap wrote:

> Below is a patch that makes the 2 reported drivers build when
> CONFIG_GPIOLIB is disabled and CONFIG_GENERIC_GPIO is disabled.
> What do you think of the patch?

Looks OK for me on a first scan, though probably the best approach is to
go through and just enable gpiolib on all the architectures that don't
have it already yet - that's the more generally useful approach as it
means that if plugin boards for the platform need to use gpiolib they
can.  I already did this for Alpha, I guess I'll try to look see what
other architectures could use it.
