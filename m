From: "Nallasellan, Singaravelan" <singaravelan.nallasellan@intel.com>
Subject: Re: [PATCH 5/6] compress: add the core file
Date: Fri, 2 Dec 2011 15:47:58 +0530
Message-ID: <3CA6C6D9F70D314CA34352990B57DA1507CCA82ACC@bgsmsx502.gar.corp.intel.com>
References: <1314943585-11670-1-git-send-email-vinod.koul@linux.intel.com>
	<1321951920-4363-6-git-send-email-vinod.koul@linux.intel.com>
	<s5hbos2g4af.wl%tiwai@suse.de>
	<000f01ccae13$78fe38c0$6afaaa40$@bossart@linux.intel.com>
	<3CA6C6D9F70D314CA34352990B57DA1507CCA82213@bgsmsx502.gar.corp.intel.com>
	<1322808274.1516.1002.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 0399B246C1
	for <alsa-devel@alsa-project.org>; Fri,  2 Dec 2011 11:18:06 +0100 (CET)
In-Reply-To: <1322808274.1516.1002.camel@vkoul-udesk3>
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
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: 'Takashi@alsa-project.org, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Iwai' <tiwai@suse.de>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, "lrg@ti.com" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org



> > >
> > There was a requirement to add the timestamp at the beginning of each
> > block or frame if the encoded data is in RAW format. If the encoder
> > does add the timestamp or marker, then we don't need the write option.
> Who needs this information, or where is this requirement coming from.
> If you already get raw encoded data on frame basis, apps can take that data
> with current timestamp...

This was requested for encoded capture for one of the voice codecs couple of years back.
> 
> --
> ~Vinod
