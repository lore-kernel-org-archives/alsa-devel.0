From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH] ASoC: compress: Remove duplicated code
Date: Mon, 07 Aug 2017 16:59:14 +0100
Message-ID: <1502121554.4828.70.camel@loki>
References: <1502111504-7996-1-git-send-email-pengdonglin137@163.com>
 <CAErzpmsPRYKmu_CMPPXEohjB-dbuqux4v12t5r9-E6dV3sXnMg@mail.gmail.com>
 <20170807150714.e7aecqskfelp7h5z@sirena.org.uk>
 <9bebfae0-5fd2-bb44-18dd-d7c25f59f1b1@linux.intel.com>
 <20170807154253.sfmi6mmt4lj2d44k@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 28C852672A8
 for <alsa-devel@alsa-project.org>; Mon,  7 Aug 2017 17:59:22 +0200 (CEST)
In-Reply-To: <20170807154253.sfmi6mmt4lj2d44k@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Richard Fitzgerald <rf@opensource.wolfsonmicro.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Donglin Peng <dolinux.peng@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2017-08-07 at 16:42 +0100, Mark Brown wrote:
> On Mon, Aug 07, 2017 at 10:28:30AM -0500, Pierre-Louis Bossart wrote:
> > On 8/7/17 10:07 AM, Mark Brown wrote:
> 
> > > Are you sure that this is the assignment that should be deleted, and if
> > > so why?  Note that it's both conditionally and unconditionally assigned
> > > later on...  Some words in the commit log about why this copy is removed
> > > would be helpful.
> 
> > Thanks for the report. Yes, the logic escapes me as well, there were two
> > separate changes from Liam and Richard Fitzgerald and I can't figure out why
> > the reassignments of the variable new_name are required.
> 
> I've got a feeling it was people not working and testing against
> mainline independently trying to fix similar issues and ending up
> colliding when things went upstream.

Yeah, probably Richard and I working on something similar in the past. 

Liam
