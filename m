Return-Path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id DD0F126537D
 for <alsa-devel@alsa-project.org>; Mon, 18 Aug 2014 07:27:33 +0200 (CEST)
Date: Mon, 18 Aug 2014 10:35:47 +0530
From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Message-ID: <20140818050547.GC14041@vinod.koul@linux.intel.com>
References: <1407145563-1303-1-git-send-email-subhransu.s.prusty@intel.com>
 <1407145563-1303-7-git-send-email-subhransu.s.prusty@intel.com>
 <20140813200339.GP17528@sirena.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140813200339.GP17528@sirena.org.uk>
Subject: Re: [alsa-devel] [v4 06/12] ASoC: Intel: mrfld: add the gain
	controls
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, lgirdwood@gmail.com
List-ID: <alsa-devel@alsa-project.org>

On Wed, Aug 13, 2014 at 09:03:39PM +0100, Mark Brown wrote:
> On Mon, Aug 04, 2014 at 03:15:57PM +0530, Subhransu S. Prusty wrote:
> 
> > +static const struct snd_kcontrol_new sst_gain_controls[] = {
> > +	SST_GAIN("media0_in", SST_PATH_INDEX_MEDIA0_IN, SST_TASK_MMX, 0, &sst_gains[0]),
> 
> Media0 Capture Volume - all the controls here look like they should have
> standard ALSA style names.

Ok

-- 
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
