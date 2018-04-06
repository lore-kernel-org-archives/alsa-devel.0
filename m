From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 04/13] soundwire: Add Master and Slave
	port programming
Date: Fri, 6 Apr 2018 10:31:19 +0530
Message-ID: <20180406050118.GG6014@localhost>
References: <1522946904-2089-1-git-send-email-vinod.koul@intel.com>
 <1522946904-2089-5-git-send-email-vinod.koul@intel.com>
 <f32e8e5c-5341-87c6-6f81-35cfc2827d80@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 8B12B266BBC
 for <alsa-devel@alsa-project.org>; Fri,  6 Apr 2018 06:56:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <f32e8e5c-5341-87c6-6f81-35cfc2827d80@linux.intel.com>
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
Cc: ALSA <alsa-devel@alsa-project.org>, tiwai@suse.de, Greg KH <gregkh@linuxfoundation.org>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 05, 2018 at 06:14:58PM -0500, Pierre-Louis Bossart wrote:
> On 4/5/18 11:48 AM, Vinod Koul wrote:

> >+	/* Program DPN_SampleCtrl2 register */
> >+	wbuf = ((t_params->sample_interval - 1) &
> >+			SDW_DPN_SAMPLECTRL_HIGH) >>
> >+			SDW_REG_SHIFT(SDW_DPN_SAMPLECTRL_HIGH);
> 
> 	wbuf = t_params->sample_interval - 1;
> 	wbuf &= SDW_DPN_SAMPLECTRL_HIGH);
> 	wbuf >>= SDW_REG_SHIFT(SDW_DPN_SAMPLECTRL_HIGH);
> 
> same lines of code, simpler to read?

ok will fix both of these

-- 
~Vinod
