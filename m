From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH 5/6] compress: add the core file
Date: Tue, 06 Dec 2011 11:33:00 +0530
Message-ID: <1323151380.1641.7.camel@vkoul-udesk3>
References: <1314943585-11670-1-git-send-email-vinod.koul@linux.intel.com>
	<1321951920-4363-6-git-send-email-vinod.koul@linux.intel.com>
	<3CA6C6D9F70D314CA34352990B57DA1507CCA82D4B@bgsmsx502.gar.corp.intel.com>
	<1322973076.30390.14.camel@vkoul-udesk3>
	<3CA6C6D9F70D314CA34352990B57DA1507CCAD7954@bgsmsx502.gar.corp.intel.com>
	<001501ccb361$3af49990$b0ddccb0$@bossart@linux.intel.com>
	<3CA6C6D9F70D314CA34352990B57DA1507CCAD7DAC@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 6E49C10390D
	for <alsa-devel@alsa-project.org>; Tue,  6 Dec 2011 07:04:39 +0100 (CET)
In-Reply-To: <3CA6C6D9F70D314CA34352990B57DA1507CCAD7DAC@bgsmsx502.gar.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Nallasellan, Singaravelan" <singaravelan.nallasellan@intel.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, "lrg@ti.com" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2011-12-06 at 08:30 +0530, Nallasellan, Singaravelan wrote:
> > 
> > The notion of a START threshold isn't self-explanatory for compressed data. The
> > decoder may or may not have enough data available for specific values of the
> > threshold, and the behavior would be decoder/implementation specific.
> > Besides, this was never implemented in the proprietary Intel API we've been using for
> > 2+ years and no one complained...
> 
> Even the thread which actually writes the data to ring buffer may not have the idea of frames
> So the start threshold does not require to be on frame boundaries. It is just to avoid START 
> when the buffer is written with the data. If the write gives more data than the ring buffer, 
> write will not unblock and the user space application may not be able to call START. 
> This will be an issue if you go for non-blocking implementation. Otherwise, START should
> be called in another thread than the thread which writes the data.
You are confusing kernel API to user space stuff. Please stick to kernel
API discussion here. Nevertheless above has nothing to do with threshold
question!

At the peril of repeating myself again
- You have information of "exactly" how much data is there, so why do we
need a threshold.
- START threshold as explained above doesn't fly for compressed data

In PCM we would need to know what is the least amount of data which is
available in ring buffer for lower level driver to start. In compressed
data, you know to how much data is available for you to decode at any
point of time, use that information.

-- 
~Vinod
