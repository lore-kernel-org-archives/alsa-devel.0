From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/4] regulator: arizona-ldo1: Do not
	control clocking	from regulator
Date: Wed, 11 Jun 2014 11:59:26 +0100
Message-ID: <20140611105926.GB12074@opensource.wolfsonmicro.com>
References: <20140609150013.GA5229@opensource.wolfsonmicro.com>
 <20140609150435.GE5229@opensource.wolfsonmicro.com>
 <20140609184314.GB5099@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 97BF3265278
 for <alsa-devel@alsa-project.org>; Wed, 11 Jun 2014 12:59:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20140609184314.GB5099@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, sameo@linux.intel.com, tiwai@suse.de, Richard Fitzgerald <rf@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, lee.jones@linaro.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 09, 2014 at 07:43:14PM +0100, Mark Brown wrote:
> On Mon, Jun 09, 2014 at 04:04:35PM +0100, Richard Fitzgerald wrote:
> > Using the driver for the internal regulator to also control
> > the clock frequency of blocks inside the codec is an
> > unexpected side-effect for a regulator, and also means that
> > the core clocks won't be changed as expected if an external
> > regulator is used to power the codec.
> 
> IIRC this was deliberately coded in this fashion on advice from the
> hardware engineers - there was more going on with that register than
> there might at first appear and some actual sync with the LDO.  I
> believe there was some different process to follow (possibly just
> setting this mode all the time) when using an external regulator, though
> it's also possible the hardware guys were just unsure at the time.

I have had a good chat with the hardware engineers here and they
are pretty adamant that the only constraint here is that we
should never enable SUBSYS without 1.8V being supplied to the
core.

They also believe that the external case should be handled the
same as the internal one, although admittedly I haven't tested
that personally.

This series needs a slight rebase and fixing up for my comment on
one of the patches, but otherwise I think should be good in my
opinion.

Thanks,
Charles
