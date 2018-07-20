From: Vinod <vkoul@kernel.org>
Subject: Re: [PATCH v6 07/10] soundwire: keep track of Masters
 in a stream
Date: Fri, 20 Jul 2018 10:13:17 +0530
Message-ID: <20180720044317.GP3219@vkoul-mobl>
References: <20180716184713.13356-1-sanyog.r.kale@intel.com>
 <20180716184713.13356-8-sanyog.r.kale@intel.com>
 <4a8e46a4-4010-aa70-a3d4-5c5d3faf5245@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by alsa0.perex.cz (Postfix) with ESMTP id E6E9C26733D
 for <alsa-devel@alsa-project.org>; Fri, 20 Jul 2018 06:43:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4a8e46a4-4010-aa70-a3d4-5c5d3faf5245@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: patches.audio@intel.com, gregkh@linuxfoundation.org, Sanyog Kale <sanyog.r.kale@intel.com>, alsa-devel@alsa-project.org, shreyas.nc@intel.com
List-Id: alsa-devel@alsa-project.org

On 19-07-18, 10:06, Pierre-Louis Bossart wrote:
> On 7/16/18 1:47 PM, Sanyog Kale wrote:
> > From: Shreyas NC <shreyas.nc@intel.com>
> > 
> > A multi link bankswitch can be done if the hardware supports and
> > the stream is handled by multiple Master(s).
> > 
> > This preparatory patch adds support to track m_rt in a stream.
> 
> The order of the patches seems off, you are adding the definition of
> m_rt_count in patch 7 but using it in patch 6, that'll break git bisect.
> What am i missing?
> 
> It'd also make more sense to have the reference counts in the same patch,
> it's hard to track otherwise, so maybe one patch to add the definitions and
> inits and the second to increase/decrease+use the value as needed.

Also it would help to have fixes first, so they go in and the bigger
changes later. That is how a series should be built typically.

-- 
~Vinod
