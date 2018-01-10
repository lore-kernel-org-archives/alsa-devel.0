From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 0/2] ASoC: Remove mfld dead code
Date: Wed, 10 Jan 2018 23:04:58 +0530
Message-ID: <20180110173458.GA18649@localhost>
References: <1515580175-27016-1-git-send-email-vinod.koul@intel.com>
 <1515588112.7000.835.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id AB4F6266A74
 for <alsa-devel@alsa-project.org>; Wed, 10 Jan 2018 18:30:46 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1515588112.7000.835.camel@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: alsa-devel@alsa-project.org, patches.audio@intel.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam <liam.r.girdwood@linux.intel.com>, Mark <broonie@kernel.org>, Alan Cox <alan@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 10, 2018 at 02:41:52PM +0200, Andy Shevchenko wrote:
> On Wed, 2018-01-10 at 15:59 +0530, Vinod Koul wrote:
> > Medfield machine was not compiling for long on mainline. Since no one
> > complained, lets remove the dead code and associated codec.
> 
> While this change seems okay per se, please keep in mind that Intel
> Merrifield would be still in use (yes, we have no confirmation right now
> about the status of the driver in vanilla kernel, I hope in the future
> with SOF it could be much easier to get into working solution on Intel
> Edison platform).

This is the mfld machine and codec, mrfld machine is separate and platform
is supported by the mfld pcm driver (which also supports byt, bsw, cht and
so on) that is not removed so wont impact tng core work.

-- 
~Vinod
