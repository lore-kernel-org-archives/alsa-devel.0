From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: Re: [v4 11/12] ASoC: Intel: mfld-pcm: add the fe & be
	dai ops
Date: Mon, 18 Aug 2014 10:21:12 +0530
Message-ID: <19287.5203946189$1408338817@news.gmane.org>
References: <1407145563-1303-1-git-send-email-subhransu.s.prusty@intel.com>
 <1407145563-1303-12-git-send-email-subhransu.s.prusty@intel.com>
 <20140813201657.GT17528@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id F044E265379
 for <alsa-devel@alsa-project.org>; Mon, 18 Aug 2014 07:12:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20140813201657.GT17528@sirena.org.uk>
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
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 13, 2014 at 09:16:57PM +0100, Mark Brown wrote:
> On Mon, Aug 04, 2014 at 03:16:02PM +0530, Subhransu S. Prusty wrote:
> > From: Vinod Koul <vinod.koul@intel.com>
> > 
> > Now that the DSP topology is added, add the FE and BE dai ops for controls DSP as
> > well mute/unmute of FE through ASoC
> 
> It really seems like patch 1 should be part of this change, it'd be much
> more obvious what's going on then (though the concerns about breaking
> machine drivers still stand).
> 
> Please also try to keep your changelogs comfortably below 80 columns
> (this is over 80 columns).

Will squash the patches.

-- 
