From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 5/6] compress: add the core file
Date: Wed, 30 Nov 2011 10:30:29 +0000
Message-ID: <20111130103028.GF2791@opensource.wolfsonmicro.com>
References: <1314943585-11670-1-git-send-email-vinod.koul@linux.intel.com>
	<1321951920-4363-6-git-send-email-vinod.koul@linux.intel.com>
	<s5hbos2g4af.wl%tiwai@suse.de>
	<1322106354.1516.951.camel@vkoul-udesk3>
	<s5hfwhd29a5.wl%tiwai@suse.de>
	<1322127157.1516.973.camel@vkoul-udesk3>
	<s5h1usrxujv.wl%tiwai@suse.de>
	<003001ccaedb$f4e30010$dea90030$@bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 084F51039A7
	for <alsa-devel@alsa-project.org>; Wed, 30 Nov 2011 11:30:33 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <003001ccaedb$f4e30010$dea90030$@bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: 'Takashi Iwai' <tiwai@suse.de>, dp@opensource.wolfsonmicro.com, 'Vinod Koul' <vinod.koul@linux.intel.com>, alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 29, 2011 at 03:15:01PM -0600, Pierre-Louis Bossart wrote:

> > But is this restriction guaranteed to be applicable to all possible
> > hardwares in future?  What happens if you'll get a hardware that
> > doesn't support the byte-unit push for the playback?
> > That said, I see no obvious reason to give a restriction coupled with
> > the stream direction.

> Power consumption will be more optimized if we push bytes without looking
> for block boundaries on the host. But if your hardware requires parsing on
> the host, there's no impact on the API. You'd just write block-by-block and
> specify the block length instead of fixed-size value.

We've got a block based driver in development for this API - it's not
had a problem interoperating thus far.  So long as we can report how
much data we've actually consumed I'd not anticipate any problems.
