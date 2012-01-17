From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: Allow drivers to specify how
 many bits are significant on a DAI
Date: Tue, 17 Jan 2012 18:59:53 +0000
Message-ID: <20120117185953.GN2944@opensource.wolfsonmicro.com>
References: <20120117113848.GE2944@opensource.wolfsonmicro.com>
	<4F157264.5020102@ti.com>
	<20120117131950.GF2944@opensource.wolfsonmicro.com>
	<4F15833B.2000808@ti.com>
	<20120117145646.GG2944@opensource.wolfsonmicro.com>
	<4F159CE2.4090306@ti.com>
	<20120117164452.GJ2944@opensource.wolfsonmicro.com>
	<4F15B611.2080808@ti.com>
	<20120117181709.GM2944@opensource.wolfsonmicro.com>
	<4F15C331.1020701@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AE727103A71
	for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2012 19:59:56 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4F15C331.1020701@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 17, 2012 at 07:51:29PM +0100, Peter Ujfalusi wrote:

> >> Yeah, but it is not correct. If it does not know this we have 8bit
> >> 'latency' in gain control. Pulse can change the gain which will have no
> >> effect.

> > Which will have the same overall effect as if it doesn't do anything
> > based on knowing the resolution.

> But we still 'loose' 8bits. It might be not a big loss at the end when
> PA for example applies the gain, but for sure we will loose resolution
> (8bit worth).

Whereas if you do the gain to the lower resolution you'll discard the
same amount of information...

> My only problem is to say this to application: "out of 8/16bit you
> should use 24msb". AFAIK this is the meaning of the constraint. This
> constraint makes sense for 32bit samples: "out of 32bit you should use
> 24msb".

Well, like I say I don't see this as a problem and have no intention of
writing any code to handle that myself.
