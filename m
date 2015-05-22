From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: ASoC: How to mix multi input ?
Date: Fri, 22 May 2015 18:59:31 +0100
Message-ID: <1432317571.2772.40.camel@loki>
References: <87pp5v3jz9.wl%kuninori.morimoto.gx@renesas.com>
 <20150520181306.GP21577@sirena.org.uk>
 <87fv6qu6k5.wl%kuninori.morimoto.gx@renesas.com>
 <20150521110519.GX21577@sirena.org.uk>
 <87pp5t8otj.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D1C326041D
 for <alsa-devel@alsa-project.org>; Fri, 22 May 2015 19:59:35 +0200 (CEST)
In-Reply-To: <87pp5t8otj.wl%kuninori.morimoto.gx@renesas.com>
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

On Fri, 2015-05-22 at 00:01 +0000, Kuninori Morimoto wrote:
> Hi Mark
> 
> > > 	init          => working:
> > > 	start sound A => working: codec + A
> > > 	start sound B => working: codec + A/B (mixed)
> > > 	stop  sound A => working: codec + B
> > > 	start sound C => working: codec + B/C (mixed)
> > > 	stop  sound B => working: codec + C
> > > 	stop  sound C => working:
> > 
> > > I guess current DPCM doesn't support this ?
> > 
> > What you're describing is what I'd expect to happen - I'd say if that's
> > not working it's a bug and we should fix it.
> 
> Thank you. I didn't know this.
> I will check it

DPCM should work with all the above. It worked on OMAP4 ABE when I last
checked OMAP4 over 2 years ago.

Liam
