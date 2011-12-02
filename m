From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH 5/6] compress: add the core file
Date: Fri, 02 Dec 2011 12:14:34 +0530
Message-ID: <1322808274.1516.1002.camel@vkoul-udesk3>
References: <1314943585-11670-1-git-send-email-vinod.koul@linux.intel.com>
	<1321951920-4363-6-git-send-email-vinod.koul@linux.intel.com>
	<s5hbos2g4af.wl%tiwai@suse.de>
	<000f01ccae13$78fe38c0$6afaaa40$@bossart@linux.intel.com>
	<3CA6C6D9F70D314CA34352990B57DA1507CCA82213@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id CCF4C103CDF
	for <alsa-devel@alsa-project.org>; Fri,  2 Dec 2011 07:46:47 +0100 (CET)
In-Reply-To: <3CA6C6D9F70D314CA34352990B57DA1507CCA82213@bgsmsx502.gar.corp.intel.com>
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
Cc: 'Takashi Iwai' <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, "lrg@ti.com" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2011-12-01 at 18:58 +0530, Nallasellan, Singaravelan wrote:
> > 
> > > A general note: it's not necessarily to split playback and capture
> > > devices.  For example, rawmidi has a single device for full-duplex.
> > > In the case of PCM, we had to split them because of mmap.  The mmap
> > > for the capture was supposed not to be read-only, some apps may want
> > > to add mark on the buffer.
> > 
> > Beats me why an app would want to write anything into the capture ring buffer.
> > Do you have an example of this use case? Maybe there's a similar need for
> > compressed data. Thanks!
> > -Pierre
> > 
> There was a requirement to add the timestamp at the beginning of each block or frame 
> if the encoded data is in RAW format. If the encoder does add the timestamp or marker, 
> then we don't need the write option. 
Who needs this information, or where is this requirement coming from.
If you already get raw encoded data on frame basis, apps can take that
data with current timestamp...

-- 
~Vinod
