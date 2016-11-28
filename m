From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] crec: Add option to specify codec ID
Date: Mon, 28 Nov 2016 21:24:06 +0530
Message-ID: <20161128155406.GI6408@localhost>
References: <20161118035333.GG2698@localhost>
 <1479463868.18450.29.camel@rf-debian.wolfsonmicro.main>
 <20161118102903.GS2698@localhost>
 <fe7dcb27-fda9-47bc-7766-2896e1954218@linux.intel.com>
 <20161118161737.GB1575@localhost.localdomain>
 <20161123034103.GZ2698@localhost>
 <1479896518.4317.7.camel@rf-debian.wolfsonmicro.main>
 <20161123103820.GI2698@localhost>
 <106771ee-bc16-377a-c1c0-8499c554c165@linux.intel.com>
 <1480326439.4317.11.camel@rf-debian.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id F10DB266E65
 for <alsa-devel@alsa-project.org>; Mon, 28 Nov 2016 16:44:28 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1480326439.4317.11.camel@rf-debian.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 28, 2016 at 09:47:19AM +0000, Richard Fitzgerald wrote:
> On Sun, 2016-11-27 at 11:52 -0600, Pierre-Louis Bossart wrote:
> > > I am not Ok to add support for any other format apart from bespoke (file
> > > dump) and PCM wav header and save to file.
> > >
> > > I am okay to add support to dump data to stdio for any format, so that we
> > > dont bother to support those file formats.
> > 
> > it's not clear to me why you would make an exception for bespoke, just 
> > dump everything to stdio and use a file indirection if you want the raw 
> > data in all cases?
> > 
> 
> Yes, I think that's best. For one thing it's easier to explain in the -h
> help: PCM can go to wav file, everything can go to stdout, stdout is
> always raw.

Yeah lets do that :)

-- 
~Vinod
