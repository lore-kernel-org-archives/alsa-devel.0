From: Selma Bensaid <selma.bensaid@intel.com>
Subject: Re: [PATCH] ASOC: utils: Update dummy codec DAI
 settings to allow stream creation
Date: Fri, 08 Jun 2012 10:02:38 +0200
Message-ID: <4FD1B19E.1030808@intel.com>
References: <1339058158.1927.15.camel@vkoul-udesk3>
	<1339063721-15193-1-git-send-email-selma.bensaid@intel.com>
	<20120607213057.GA19485@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 2B76E10B9F6
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Jun 2012 10:03:03 +0200 (CEST)
In-Reply-To: <20120607213057.GA19485@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: vinod.koul@intel.com, sylvain.centelles@intel.com, alsa-devel@alsa-project.org, louis.le.gall@intel.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On 06/07/2012 11:30 PM, Mark Brown wrote:
>
> I still don't understand what this is actually supposed to fix - why are
> we trying to set up a stream to something that isn't there?  Though it
> looks like this was added for dynamic PCM which has no mainline users so
> perhaps there's a sensible use for this...
I'm trying to use the dummy codec for BT and Modem device where the 
coded is handled
@ AP side.
Without updating the dummy codec, I fails when opening my devices due to 
the check
performed in soc_pcm_open: No matching rates, No matching formats and No 
matching
channels Errors.
>
> The other question is how we decide that these are sensible values to
> set for the dummy CODEC.
For formats the dummy codec support all formats so it does not impact 
the runtime->hw.formats = codec_dai_drv->playback.formats & 
cpu_dai_drv->playback.formats;

For rates, I 'll submit a new version of the patch since the 
SNDRV_PCM_RATE_CONTINUOUS is not the right value to use.

For channels_min, the value 1 does not impact the 
runtime->hw.channels_min =  max(codec_dai_drv->capture.channels_min, 
cpu_dai_drv->capture.channels_min);

For channels_max, I 'll submit a new version of the patch to set it to 
MAX so does not impact the runtime->hw.channels_max = 
min(codec_dai_drv->playback.channels_max 
cpu_dai_drv->playback.channels_max);
---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, 
92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
