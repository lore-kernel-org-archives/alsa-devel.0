From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Need help with failed driver initialization
Date: Tue, 11 Sep 2012 04:55:25 +0100
Message-ID: <20120911035525.GB22446@sirena.org.uk>
References: <504E0F91.4040907@freescale.com> <504E51FA.5020504@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 28773264F25
 for <Alsa-devel@alsa-project.org>; Tue, 11 Sep 2012 05:55:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <504E51FA.5020504@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 10, 2012 at 03:47:54PM -0500, Timur Tabi wrote:

> So it appears that platform_device_alloc("soc-audio", -1) no longer works
> for me.  When I replace that code with a call to snd_soc_register_card(),
> my driver works again.

> I noticed that a lot of drivers still use platform_device_alloc(), so I
> don't know if this problem specific to my drivers, or everyone else is
> broken but they don't know it yet.  Either way, I'll post a patch soon.

It's nothing to do with that - it'd break with any driver.  The problem
is that you're passing data into your driver using dev_set_drvdata()
instead of using platform data.  This has never been supported by the
driver core (driver data is exclusively for use by the bound driver) and
recently the driver core was changed to clear the driver data every time
a driver was unbound (like happens during a deferred probe).  Which
unfortunately soc-core relies on, but it should always have been using
platform data.

In any case, all drivers are supposed to be being converted to use
snd_soc_register_card() so converting is a good thing.
