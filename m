From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: concept of substream...
Date: Wed, 08 Feb 2012 15:03:47 +0530
Message-ID: <1328693627.21099.2.camel@vkoul-udesk3>
References: <1328691900.26182.149.camel@vkoul-udesk3>
	<4F323D87.2020503@ladisch.de> <1328693162.26182.170.camel@vkoul-udesk3>
	<s5hty31llrm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 5005E103DBA
	for <alsa-devel@alsa-project.org>; Wed,  8 Feb 2012 10:31:32 +0100 (CET)
In-Reply-To: <s5hty31llrm.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Wed, 2012-02-08 at 10:25 +0100, Takashi Iwai wrote:
> > > Please note that when opening a device without specifying a
> substream
> > > number, ALSA will open the first free one.  This implies that all
> > > substreams should go the same output (i.e., be mixed together).
> > Mixed in alsa or should be mixed by device?
> 
> It's pretty much depending on the hardware and the driver
> implementation. 
okay does it means its fair assumption that in driver I will get 5
opens/5 buffers. And driver is tasked with routing them to respective
output?

-- 
~Vinod
