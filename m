From: "Nallasellan, Singaravelan" <singaravelan.nallasellan@intel.com>
Subject: Re: [PATCH 4/6] compress: add API header and driver
 header	files
Date: Tue, 6 Dec 2011 08:25:04 +0530
Message-ID: <3CA6C6D9F70D314CA34352990B57DA1507CCAD7DA9@bgsmsx502.gar.corp.intel.com>
References: <1314943585-11670-1-git-send-email-vinod.koul@linux.intel.com>
	<1321951920-4363-5-git-send-email-vinod.koul@linux.intel.com>
	<3CA6C6D9F70D314CA34352990B57DA1507CCA82D17@bgsmsx502.gar.corp.intel.com>
	<000301ccb124$72a53370$57ef9a50$@bossart@linux.intel.com>
	<3CA6C6D9F70D314CA34352990B57DA1507CCAD7952@bgsmsx502.gar.corp.intel.com>
	<000001ccb358$2b9e4b70$82dae250$@bossart@linux.intel.com>
	<20111205141905.GR11150@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 377EB103A25
	for <alsa-devel@alsa-project.org>; Tue,  6 Dec 2011 03:55:30 +0100 (CET)
In-Reply-To: <20111205141905.GR11150@opensource.wolfsonmicro.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, 'Vinod Koul' <vinod.koul@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@ti.com" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

> > The answer has already been provided. I agree with Mark there's no
> > reason why this API would need to provide resource management
> > capabilities, it'd need to be handled with a separate interface
> > addressing PCM and effects as well. In the mean time user-space can
> > put product-specific restrictions on concurrent decoding.
> 
> Or implement graceful fallback to the CPU if it can't set up an offloaded stream.

Yes, that is the plan.
