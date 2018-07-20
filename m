From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH 01/11] ASoC: SOF: Add Sound Open
	Firmware	driver core
Date: Fri, 20 Jul 2018 12:05:33 +0100
Message-ID: <961ff20aa21bc1a66f24877ad330acebc4500837.camel@linux.intel.com>
References: <20180719185335.30912-1-liam.r.girdwood@linux.intel.com>
 <s5ho9f33vdw.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id F1396267715
 for <alsa-devel@alsa-project.org>; Fri, 20 Jul 2018 13:05:38 +0200 (CEST)
In-Reply-To: <s5ho9f33vdw.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 2018-07-19 at 20:58 +0200, Takashi Iwai wrote:
> On Thu, 19 Jul 2018 20:53:25 +0200,
> Liam Girdwood wrote:
> > 
> > The Sound Open Firmware driver core is a generic architecture
> > independent layer that allows SOF to be used on many different different
> > architectures and platforms. It abstracts DSP operations and IO methods
> > so that the target DSP can be an internal memory mapped or external SPI
> > or I2C based device. This abstraction also allows SOF to be run on
> > many different VMs on the same physical HW.
> > 
> > SOF also requires some data in ASoC PCM runtime data for looking up
> > SOF data during ASoC PCM operations.
> > 
> > Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
> 
> Could you give a cover letter?  It'd be helpful for digestion of such
> series.
> 

Sure, will follow shortly.

Thanks

Liam
