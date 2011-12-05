From: "Pierre-Louis Bossart" <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 5/6] compress: add the core file
Date: Mon, 5 Dec 2011 09:19:05 -0600
Message-ID: <3220.94414518705$1323098361@news.gmane.org>
References: <1314943585-11670-1-git-send-email-vinod.koul@linux.intel.com>	
	<1321951920-4363-6-git-send-email-vinod.koul@linux.intel.com>	
	<3CA6C6D9F70D314CA34352990B57DA1507CCA82D4B@bgsmsx502.gar.corp.intel.com>
	<1322973076.30390.14.camel@vkoul-udesk3>
	<3CA6C6D9F70D314CA34352990B57DA1507CCAD7954@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 31536103A77
	for <alsa-devel@alsa-project.org>; Mon,  5 Dec 2011 16:19:07 +0100 (CET)
In-Reply-To: <3CA6C6D9F70D314CA34352990B57DA1507CCAD7954@bgsmsx502.gar.corp.intel.com>
Content-Language: en-us
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Nallasellan, Singaravelan" <singaravelan.nallasellan@intel.com>, 'Vinod Koul' <vinod.koul@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

> > > > +	if (stream->runtime->state == SNDRV_PCM_STATE_SETUP) {
> > > > +		stream->runtime->state = SNDRV_PCM_STATE_PREPARED;
> > > Can we implement kind of start threshold similar to PCM path here
> to
> > > initiate the playback?
> > You already know how much is copied into buffer
> You expect the user space to explicitly invoke START. Is it right?
> If threshold is implemented, the user space does not require to track
> the
> bytes_written/read.

The notion of a START threshold isn't self-explanatory for compressed data. The decoder may or may not have enough data available for specific values of the threshold, and the behavior would be decoder/implementation specific.
Besides, this was never implemented in the proprietary Intel API we've been using for 2+ years and no one complained...
-Pierre
