From: "Nallasellan, Singaravelan" <singaravelan.nallasellan@intel.com>
Subject: Re: [PATCH 5/6] compress: add the core file
Date: Thu, 1 Dec 2011 18:58:26 +0530
Message-ID: <3CA6C6D9F70D314CA34352990B57DA1507CCA82213@bgsmsx502.gar.corp.intel.com>
References: <1314943585-11670-1-git-send-email-vinod.koul@linux.intel.com>
	<1321951920-4363-6-git-send-email-vinod.koul@linux.intel.com>
	<s5hbos2g4af.wl%tiwai@suse.de>
	<000f01ccae13$78fe38c0$6afaaa40$@bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 6EC141038E7
	for <alsa-devel@alsa-project.org>; Thu,  1 Dec 2011 14:28:32 +0100 (CET)
In-Reply-To: <000f01ccae13$78fe38c0$6afaaa40$@bossart@linux.intel.com>
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
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 'Takashi Iwai' <tiwai@suse.de>, 'Vinod Koul' <vinod.koul@linux.intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@ti.com" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

> 
> > A general note: it's not necessarily to split playback and capture
> > devices.  For example, rawmidi has a single device for full-duplex.
> > In the case of PCM, we had to split them because of mmap.  The mmap
> > for the capture was supposed not to be read-only, some apps may want
> > to add mark on the buffer.
> 
> Beats me why an app would want to write anything into the capture ring buffer.
> Do you have an example of this use case? Maybe there's a similar need for
> compressed data. Thanks!
> -Pierre
> 
There was a requirement to add the timestamp at the beginning of each block or frame 
if the encoded data is in RAW format. If the encoder does add the timestamp or marker, 
then we don't need the write option. 
