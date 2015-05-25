From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: ASoC: How to mix multi input ?
Date: Mon, 25 May 2015 11:18:44 +0530
Message-ID: <20150525054844.GA3140@localhost>
References: <87pp5v3jz9.wl%kuninori.morimoto.gx@renesas.com>
 <20150520181306.GP21577@sirena.org.uk>
 <87fv6qu6k5.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F9592604AF
 for <alsa-devel@alsa-project.org>; Mon, 25 May 2015 07:47:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <87fv6qu6k5.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

On Thu, May 21, 2015 at 12:20:06AM +0000, Kuninori Morimoto wrote:
> 
> Hi Mark
> 
> Thank you for your reply
> 
> >> Here, sound A/B/C will be used randomly.
> >> Does ALSA SoC already has this kind of system ?
> >
> > I *think* at least the Intel systems do this already.
> 
> Thank you. I will check it.
> 
> > > I would like to ask you how to mix multi input in ASoC.
> > > Renesas sound device(s) can mix multi input to 1 output.
> > 
> > You mean in DPCM rather than a plain CODEC?  
> (snip)
> > > codec will be started if one of A/B/C are started,
> > > and it will be stopped if all of A/B/C are stopped.
> > 
> > If you connect multiple front ends to one back end this should work
> > (with DAPM routes and so on).  If it doesn't work then that's something
> > that should work.
> 
> I considered about DPCM, but *maybe* this is not goot match for us.
> If my understanding is correct, and if I used DPCM for this,
> all of sound A/B/C are start/stop:ed in same time ?
> 
> ex)
> 	start sound => start A/B/C and codec
> 	stop  sound => stop  A/B/C and codec
> 
> I guess it works if it has this connection
> 
> 	data -> [A] -> [B] -> [C] -> codec
> 
> We would like to do is like this
> 
> 	                +-+
> 	dataA -> [A] -> |M|
> 	dataB -> [B] -> |I| -> codec
> 	dataC -> [C] -> |X|
> 	                +-+
> 
> 	init          => working:
> 	start sound A => working: codec + A
> 	start sound B => working: codec + A/B (mixed)
> 	stop  sound A => working: codec + B
> 	start sound C => working: codec + B/C (mixed)
> 	stop  sound B => working: codec + C
> 	stop  sound C => working:
> 
> I guess current DPCM doesn't support this ?
it does, you have to declare A, B, C as FE then introduce a digital mixer
(real or virtual, depending on the system) and the a BE which is your HW DAI
here and connects to codec

This works very well and you can start/stop A, B, C independently. Codec
will be on as along as any of the inputs is On.

See the sound/soc/intel/atom for reference

-- 
~Vinod
