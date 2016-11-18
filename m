From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] crec: Correct name of output binary to crec
Date: Fri, 18 Nov 2016 10:13:10 +0000
Message-ID: <1479463990.18450.31.camel@rf-debian.wolfsonmicro.main>
References: <1479294405-17471-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <20161116130241.GY3000@localhost>
 <1479302061.18450.24.camel@rf-debian.wolfsonmicro.main>
 <20161118035603.GH2698@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id AF1FA266B17
 for <alsa-devel@alsa-project.org>; Fri, 18 Nov 2016 11:13:13 +0100 (CET)
In-Reply-To: <20161118035603.GH2698@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Fri, 2016-11-18 at 09:26 +0530, Vinod Koul wrote:
> On Wed, Nov 16, 2016 at 01:14:21PM +0000, Richard Fitzgerald wrote:
> > On Wed, 2016-11-16 at 18:32 +0530, Vinod Koul wrote:
> > > On Wed, Nov 16, 2016 at 11:06:45AM +0000, Richard Fitzgerald wrote:
> > > > For some reason when the build system was converted to
> > > > automake by this patch
> > > > 
> > > >     "Convert the build system to autotools"
> > > > 
> > > > the name of the output binary for crec was changed
> > > > from 'crec' to 'crecord'.
> > > > 
> > > > This patch corrects it back to 'crec'
> > > 
> > > That implies crecord is incorrect, I do not think so.
> > > 
> > > Can you explain why you would want to rename this back.
> > > 
> > > The motivation for this was to make it proper like cplay. Also similar to
> > > aplay and arecord.
> > > 
> > 
> > I don't really see a need for that, or why "crec" is wrong.
> > 
> > In any case if you did want to change that name 
> > 
> > a) it should be an explicit patch, not sneaked in as an undocumented and
> > unexpected side-effect of some other patch
> 
> This part I agree. Unfortunately this was not done transparently...
> 
> > b) the source file should have been renamed to match, if the name "crec"
> > is a massive problem then it should also be a problem that
> > "cplay.c->cplay" but "crec.c->crecord". If it's ok to have the source
> > file called crec.c what's wrong with the binary it builds being called
> > crec?
> 
> I dont mind renaming source as well..
> 
> I think bigger question is should we continue crec or crecord, my preference
> is latter.
> 
> > c) it's a nuisance to have to change existing test systems and apps that
> > launch "crec", or to create symlinks from crec->crecord.
> 
> Yeah agree, lets decide on one and stick to that, forever hopefully :)
> 

Ok let's change to crecord for consistency with arecord, and I'll do a
patch to rename the source to match.
