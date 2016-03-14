Return-Path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id EF95B260673
 for <alsa-devel@alsa-project.org>; Mon, 14 Mar 2016 11:21:10 +0100 (CET)
Date: Mon, 14 Mar 2016 23:27:42 +0530
From: Jeeja KP <jeeja.kp@intel.com>
Message-ID: <20160314175741.GA5556@jeeja.kp@intel.com>
References: <20160216161747.GA18103@jeeja.kp@intel.com>
 <20160302020215.GN18327@sirena.org.uk>
 <20160310205703.GA26632@jeeja.kp@intel.com>
 <20160311035927.GQ3898@sirena.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160311035927.GQ3898@sirena.org.uk>
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

On Fri, Mar 11, 2016 at 10:59:27AM +0700, Mark Brown wrote:
> On Fri, Mar 11, 2016 at 02:27:03AM +0530, Jeeja KP wrote:
> > On Wed, Mar 02, 2016 at 11:02:15AM +0900, Mark Brown wrote:
> > > On Tue, Feb 16, 2016 at 09:47:47PM +0530, Jeeja KP wrote:
> 
> > > Like I keep saying if you're thinking about this in terms of DPCM you're
> > > solving the wrong problem - we already support supplying parameters for
> > > device<->device links, we already have systems that need to configure
> > > things for device<->device links so we can already see that if we're
> > > doing something that only works for things that are on SoC and can use
> > > DPCM then we're not solving the problem.
> 
> > No this is not exactly about DPCM. It is about the device<->device links that
> > assume you can have only codecs as hostless and thus change the direction
> > for the link. Since we are rendering from SoC we don't need direction change.
> 
> You're routing them via DSP though?

Yes, but this would have been the same issue for things like internal
sinks and sources. For example we have a tone generator which is dapm
source and connects to codec. This hostless connection is triggered from
DAPM but we don't have hw_params, so tried to provide hardware params
for DAIs and not overloaded .params field in this approach

> > > This is clearly confused, if we can't figure out what the two devices we
> > > are connecting are based on just looking at the devices then that's
> > > really not a good sign that our interfaces are sensible and easy to work
> > > with.
> 
> > Right now dai_link assumes device<->device links based on params so we
> > cannot specify params for anything where we dont want direction change and would
> > like to treat as normal direction dai_link. So we propose this to move to
> > codec_link flag and use params only for creating controls based on params
> > provided.
> 
> What I'm telling you is that you shouldn't be writing hacks like this to
> bodge things but coming up with scalable and maintainable solutions.  I
> already discussed this with Vinod several times, we've discussed the
> idea that if you're having trouble with the asymmetries in the
> definitions of DAI links you should make the DAI links symmetric so
> things like this just work.  We need clear, comprehensible abstractions
> which work robustly not some mess of special case handling.

At least this one is not really DPCM based as we have the same problem
with DAPM based approach when we consider internal sinks and sources.

We discussed this and yes we are looking at ways to solve this longer
term with DAPM but today DAPM doesn't help us in managing DMAs for our
controller. I believe Vinod did discuss this limitation during ELC.
We are starting this discussion internally and will try to solve
this part.

Now for us to mange the internal sinks and source how should we go about
modelling them in DAPM and provide hw_params for the configuration?

Thanks
-- 
Jeeja
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
