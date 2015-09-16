From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH BAT V1 0/7] BAT: Add Basic Audio Tester
 command line tool
Date: Wed, 16 Sep 2015 17:57:00 +0100
Message-ID: <1442422620.10528.133.camel@loki>
References: <cover.1442298607.git.han.lu@intel.com>
 <20150916163758.GJ12027@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id B670526172C
 for <alsa-devel@alsa-project.org>; Wed, 16 Sep 2015 18:57:08 +0200 (CEST)
In-Reply-To: <20150916163758.GJ12027@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: han.lu@intel.com, alsa-devel@alsa-project.org, tiwai@suse.com, bernard.gautier@intel.com
List-Id: alsa-devel@alsa-project.org

On Wed, 2015-09-16 at 17:37 +0100, Mark Brown wrote:
> On Tue, Sep 15, 2015 at 03:00:16PM +0800, han.lu@intel.com wrote:
> 
> > BAT works by playing an audio stream and capturing the same stream
> > in either a digital or analog loopback. It then compares the captured
> > stream to the original to determine if the testcase passes or fails.
> 
> This is really cool, sounds like there's some overlap with the tool
> David wrote to verify TLV information?  Actually in that vein one thing
> I started looking at but parked until this got posted is something that
> goes through and tries to stress test control value settings (trying to
> set out of bounds values, make sure all valid settings can be used and
> so on).  That's probably better kept as a separate tool I think given
> that it doesn't really overlap with audio streaming.

I didn't think of bounds testing the controls :) Especially useful for
DSPs where we could overflow or crash FW if certain combinations of
enumerated controls are used.

We were looking at testing the gains too, to make sure that a 6dB
control gain really does mean a 6dB gain in signal. It's in the TODO
list. Most of the code is already there to do this, but we were looking
to upstream first and then incrementally add features. I think Han plans
to upstream the tinyalsa support after the initial code is upstream
though.

Liam
