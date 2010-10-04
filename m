From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] sst: Intel SST audio driver
Date: Mon, 4 Oct 2010 16:49:24 -0700
Message-ID: <20101004234923.GA5340@opensource.wolfsonmicro.com>
References: <20100930162123.21348.86482.stgit@localhost.localdomain>
	<20101002230610.GA21181@sirena.org.uk>
	<20101003112244.488282fd@linux.intel.com>
	<20101003201943.GA31764@opensource.wolfsonmicro.com>
	<20101004100424.4e5cf40c@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 515C72432C
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Oct 2010 01:49:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20101004100424.4e5cf40c@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alan Cox <alan@linux.intel.com>
Cc: greg@kroah.com, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 04, 2010 at 10:04:24AM +0100, Alan Cox wrote:
> > IIRC at least one version had a split where the ALSA integration stuff
> > was separated out from the underlying DSP interface code - that was
> > pretty helpful since it helps focus on the ALSA specifics.

> Yes but that split is no longer there once the clean up patches sit on
> top because they weren't put together as separate bits. This is exactly
> the sort of reason I want to get it in staging.

Sure, though that's what rebase is there for.

> > We ought to be able to come up with something for the core streaming
> > stuff, though.  Like I say, it's just a nice to have though.

> I would have thought PCM at least was also going to have some kind of
> common structure.

ALSA provides that already, pretty much?  I guess PCM also falls out of
compressed CODEC support as a noop CODEC.

> > I do have some nervousness about the concept of staging for embedded
> > stuff since I worry that inclusion in staging can send the wrong
> > message to vendors but that's a completely separate issue to this
> > driver.

> Noted. But I'll point you at the SEP driver which did get bogged down
> for ages for reasons I can't really go into publically, and we
> therefore pulled out of staging.

It's not specifically about this driver, it's more of a general concern
about the whole concept and how vendors less used to Linux could easily
get the wrong end of the stick.
