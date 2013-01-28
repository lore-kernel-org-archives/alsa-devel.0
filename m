From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: soc-compress: Add support for not
 memory mapped DSPs
Date: Sun, 27 Jan 2013 22:09:14 -0800
Message-ID: <20130128060914.GM26562@intel.com>
References: <1359104400-18527-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20130128040416.GJ26562@intel.com>
 <20130128045609.GA5683@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F3CE2650CE
 for <alsa-devel@alsa-project.org>; Mon, 28 Jan 2013 07:34:16 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20130128045609.GA5683@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, patches@opensource.wolfsonmicro.com, liam.r.girdwood@intel.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, vinod.koul@linux.jf.intel.com
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 28, 2013 at 12:56:13PM +0800, Mark Brown wrote:
> On Sun, Jan 27, 2013 at 08:04:16PM -0800, Vinod Koul wrote:
> 
> > How about:
> > 	compr->ops = &soc_compr_ops;
> > 	if (platform->driver->compr_ops && !platform->driver->compr_ops->copy)
> > 		compr->ops->copy = NULL;
> 
> > That way you set it to null for those who doent implement this and would called
> > for drivers who implement this.
> 
> We'd need to take a copy of it in case we have a system with a mix of
> both styles.
For the same device?

Shouldnt you have two different device nodes and then use copy method on one
which supports and memory-mapped for the one which doesn't?

--
~Vinod
