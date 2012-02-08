From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: concept of substream...
Date: Wed, 08 Feb 2012 14:56:02 +0530
Message-ID: <1328693162.26182.170.camel@vkoul-udesk3>
References: <1328691900.26182.149.camel@vkoul-udesk3>
	<4F323D87.2020503@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id DF0BF103D92
	for <alsa-devel@alsa-project.org>; Wed,  8 Feb 2012 10:23:45 +0100 (CET)
In-Reply-To: <4F323D87.2020503@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2012-02-08 at 10:16 +0100, Clemens Ladisch wrote:
> Vinod Koul wrote:
> > I was trying to understand the concept of substream. So can we have a
> > device which can have support say 5 substreams and these are controlled
> > (start/stop) independent of each other.
> 
> Yes.
> 
> > At any instance we can have any number of substreams active and runtime
> > we should be able to activate/deactivate a particular substream.
> 
> If by "active" you mean opened or running, yes.
> 
> 
> Please note that when opening a device without specifying a substream
> number, ALSA will open the first free one.  This implies that all
> substreams should go the same output (i.e., be mixed together).
Mixed in alsa or should be mixed by device?


-- 
