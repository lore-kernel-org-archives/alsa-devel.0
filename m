Return-Path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 2AF462614AF
 for <alsa-devel@alsa-project.org>; Thu, 10 Mar 2016 14:20:33 +0100 (CET)
Date: Fri, 11 Mar 2016 02:27:03 +0530
From: Jeeja KP <jeeja.kp@intel.com>
Message-ID: <20160310205703.GA26632@jeeja.kp@intel.com>
References: <20160216161747.GA18103@jeeja.kp@intel.com>
 <20160302020215.GN18327@sirena.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160302020215.GN18327@sirena.org.uk>
Subject: Re: [alsa-devel] [RFD] Add hw_params support for hostless stream BE
	DAIs
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
Cc: tiwai@suse.de, vinod.koul@intel.com, alsa-devel@alsa-project.org, liam.r.girdwood@intel.com, patches.audio@intel.com
List-ID: <alsa-devel@alsa-project.org>

On Wed, Mar 02, 2016 at 11:02:15AM +0900, Mark Brown wrote:
> On Tue, Feb 16, 2016 at 09:47:47PM +0530, Jeeja KP wrote:
> > We have no mechanism to configure hw_params for DAIs which are hostless.
> > Like a loop or DAIs connected to internal sinks/sources.
> 
> Please propose patches, don't send enormous design documents.  They're
> big, take a long time to read and don't really get us anywhere unless
> they're extremely clear.

Ok. I have the patches ready, will post it.

> 
> > Approach:
> > 	1. Allow params to be defined for other BE dai link also. this
> > 	currently applicable only for codec_codec link.
> 
> Like I keep saying if you're thinking about this in terms of DPCM you're
> solving the wrong problem - we already support supplying parameters for
> device<->device links, we already have systems that need to configure
> things for device<->device links so we can already see that if we're
> doing something that only works for things that are on SoC and can use
> DPCM then we're not solving the problem.

No this is not exactly about DPCM. It is about the device<->device links that
assume you can have only codecs as hostless and thus change the direction
for the link. Since we are rendering from SoC we don't need direction change.

> 
> DPCM works pretty well for small, simple DSPs that are mostly in line
> in the middle of a standard DAI but it does have limitations which
> you're now running into.  Your systems don't fit well with what DPCM
> supports naturally.
> 
> > struct snd_soc_dai_link {
> >         const struct snd_soc_pcm_stream *params;
> >         unsigned int num_params;
> > 
> > +       /* flag to create codec codec based on the flag*/
> > +       unsigned int codec_link:1;
> > +
> 
> This is clearly confused, if we can't figure out what the two devices we
> are connecting are based on just looking at the devices then that's
> really not a good sign that our interfaces are sensible and easy to work
> with.

Right now dai_link assumes device<->device links based on params so we
cannot specify params for anything where we dont want direction change and would
like to treat as normal direction dai_link. So we propose this to move to
codec_link flag and use params only for creating controls based on params
provided.


-- 
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
