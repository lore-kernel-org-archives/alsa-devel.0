From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [RFC] compress: add support for gapless playback
Date: Wed, 6 Feb 2013 06:00:12 -0800
Message-ID: <20130206140012.GH3143@intel.com>
References: <1360074085-562-1-git-send-email-vinod.koul@intel.com>
 <5111C39A.6020805@linux.intel.com>
 <20130206075419.GF3143@intel.com>
 <20130206133253.GM4720@opensource.wolfsonmicro.com>
 <511261DC.2060302@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by alsa0.perex.cz (Postfix) with ESMTP id C9C3326509C
 for <alsa-devel@alsa-project.org>; Wed,  6 Feb 2013 15:25:01 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <511261DC.2060302@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, Mark Brown <broonie@opensource.wolfsonmicro.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.jf.intel.com>, liam.r.girdwood@intel.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 06, 2013 at 07:59:56AM -0600, Pierre-Louis Bossart wrote:
> 
> >>>>+	if (!stream->ops->set_metadata)
> >>>>+		return -ENXIO;
> >
> >>>Is this really a fatal error? Or do we want to mandate that gapless
> >>>be supported by all implementations?
> >
> >>Fatal err? if DSP doesnt support metadata callback then we are reporting error
> >>ENXIO to userpsace. No we shouldnt mandate, its upto DSP folks to see what they
> >>should and can support.
> >
> >Well, up to userspace to see how it handles the error anyway.  For
> >example an application may want to fall back to PCM playback with
> >gapless done on the CPU if the driver doesn't do it.  But then given
> >that there's more than one piece of metadata in the struct perhaps we
> >need some way for the application to figure out what's supported?
> 
> Maybe we should expose what's supported as part of the decoder query
> process, i.e. expose support for metadata as part of the decoder
> capabilities rather than as part of the set_metadata part? Error
> checks after inits are painful. we could have a "metadata_support"
> bit-field that the application could check.
Well I agree that would be a smarter way to handle. Make one of the reserved
fields in decoder caps for metadata support.

--
~Vinod
