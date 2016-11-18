From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] crec: Correct name of output binary to crec
Date: Fri, 18 Nov 2016 15:55:51 +0530
Message-ID: <20161118102551.GR2698@localhost>
References: <1479294405-17471-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <20161116130241.GY3000@localhost>
 <1479302061.18450.24.camel@rf-debian.wolfsonmicro.main>
 <20161118035603.GH2698@localhost>
 <1479463990.18450.31.camel@rf-debian.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 1AAC02666AC
 for <alsa-devel@alsa-project.org>; Fri, 18 Nov 2016 11:16:25 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1479463990.18450.31.camel@rf-debian.wolfsonmicro.main>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 18, 2016 at 10:13:10AM +0000, Richard Fitzgerald wrote:
> > This part I agree. Unfortunately this was not done transparently...
> > 
> > > b) the source file should have been renamed to match, if the name "crec"
> > > is a massive problem then it should also be a problem that
> > > "cplay.c->cplay" but "crec.c->crecord". If it's ok to have the source
> > > file called crec.c what's wrong with the binary it builds being called
> > > crec?
> > 
> > I dont mind renaming source as well..
> > 
> > I think bigger question is should we continue crec or crecord, my preference
> > is latter.
> > 
> > > c) it's a nuisance to have to change existing test systems and apps that
> > > launch "crec", or to create symlinks from crec->crecord.
> > 
> > Yeah agree, lets decide on one and stick to that, forever hopefully :)
> > 
> 
> Ok let's change to crecord for consistency with arecord, and I'll do a
> patch to rename the source to match.

Sounds good :)

-- 
~Vinod
