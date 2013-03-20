From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [TINYCOMPRESS] Remove local copies of kernel
 headers?
Date: Wed, 20 Mar 2013 09:16:43 +0530
Message-ID: <1363751203.2348.5.camel@vkoul-udesk3>
References: <20130308174912.GA12961@opensource.wolfsonmicro.com>
 <s5ha9qal2xu.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by alsa0.perex.cz (Postfix) with ESMTP id 559BA261640
 for <alsa-devel@alsa-project.org>; Wed, 20 Mar 2013 05:11:29 +0100 (CET)
In-Reply-To: <s5ha9qal2xu.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2013-03-11 at 10:07 +0100, Takashi Iwai wrote:
> At Fri, 8 Mar 2013 17:49:12 +0000,
> Richard Fitzgerald wrote:
> > 
> > I'm assuming that the local copies of compress_offload.h and compress_params.h were there as a 
> > convenience during early development
> > 
> > Can we remove these local copies now?
> 
> Keep the package self-contained.  Otherwise you'll get a mess
> depending on the build system.
Yes that was the reason to have local copies, also it helps to build and
test the package on it own without worrying about the environment. 
Plus it would be nice to build system without worrying about including
headers which are not legally allowed in that build system :)

-- 
~Vinod
