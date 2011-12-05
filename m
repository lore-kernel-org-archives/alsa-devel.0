From: "Pierre-Louis Bossart" <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 4/6] compress: add API header and driver
	header	files
Date: Mon, 5 Dec 2011 08:14:13 -0600
Message-ID: <12243.3726945475$1323094473@news.gmane.org>
References: <1314943585-11670-1-git-send-email-vinod.koul@linux.intel.com>
	<1321951920-4363-5-git-send-email-vinod.koul@linux.intel.com>
	<3CA6C6D9F70D314CA34352990B57DA1507CCA82D17@bgsmsx502.gar.corp.intel.com>
	<000301ccb124$72a53370$57ef9a50$@bossart@linux.intel.com>
	<3CA6C6D9F70D314CA34352990B57DA1507CCAD7952@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 402E2103A6F
	for <alsa-devel@alsa-project.org>; Mon,  5 Dec 2011 15:14:16 +0100 (CET)
In-Reply-To: <3CA6C6D9F70D314CA34352990B57DA1507CCAD7952@bgsmsx502.gar.corp.intel.com>
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
To: "Nallasellan, Singaravelan" <singaravelan.nallasellan@intel.com>, 'Vinod Koul' <vinod.koul@linux.intel.com>, alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@opensource.wolfsonmicro.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

> > > Can we add number of compress streams supported in DSP?
> >
> > You are confusing number of formats supported with number of streams
> supported.
> > The latter is exposed through the actual devices supported.
> 
> No, DSP may be able to support only so many simultaneous streams at any
> point of time.
> Yet, DSP can support any number of formats. Though the device entry may
> be created for
> each compressed stream, how will the user space programs get the number
> of compressed streams supported?

The answer has already been provided. I agree with Mark there's no reason
why this API would need to provide resource management capabilities, it'd
need to be handled with a separate interface addressing PCM and effects as
well. In the mean time user-space can put product-specific restrictions on
concurrent decoding.
