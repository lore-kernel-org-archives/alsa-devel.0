From: Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [PATCH v6 07/10] soundwire: keep track of Masters
 in a stream
Date: Mon, 23 Jul 2018 09:30:42 +0530
Message-ID: <20180723040042.GB20770@buildpc-HP-Z230>
References: <20180716184713.13356-1-sanyog.r.kale@intel.com>
 <20180716184713.13356-8-sanyog.r.kale@intel.com>
 <4a8e46a4-4010-aa70-a3d4-5c5d3faf5245@linux.intel.com>
 <20180720044317.GP3219@vkoul-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 808F126763C
 for <alsa-devel@alsa-project.org>; Mon, 23 Jul 2018 05:59:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20180720044317.GP3219@vkoul-mobl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod <vkoul@kernel.org>
Cc: patches.audio@intel.com, gregkh@linuxfoundation.org, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, shreyas.nc@intel.com
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 20, 2018 at 10:13:17AM +0530, Vinod wrote:
> On 19-07-18, 10:06, Pierre-Louis Bossart wrote:
> > On 7/16/18 1:47 PM, Sanyog Kale wrote:
> > > From: Shreyas NC <shreyas.nc@intel.com>
> > > 
> > > A multi link bankswitch can be done if the hardware supports and
> > > the stream is handled by multiple Master(s).
> > > 
> > > This preparatory patch adds support to track m_rt in a stream.
> > 
> > The order of the patches seems off, you are adding the definition of
> > m_rt_count in patch 7 but using it in patch 6, that'll break git bisect.
> > What am i missing?
> > 
> > It'd also make more sense to have the reference counts in the same patch,
> > it's hard to track otherwise, so maybe one patch to add the definitions and
> > inits and the second to increase/decrease+use the value as needed.
> 
> Also it would help to have fixes first, so they go in and the bigger
> changes later. That is how a series should be built typically.
>

Ok. Will take care in next update.

> -- 
> ~Vinod
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
