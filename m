From: Andreas =?iso-8859-1?Q?Irest=E5l?= <andreas.irestal@axis.com>
Subject: Re: [PATCH 4/4] ASoC: simple-card: Support for
 selecting system clocks by ID
Date: Tue, 16 Feb 2016 13:46:16 +0100
Message-ID: <20160216124616.GB2137@lnxandire1.se.axis.com>
References: <1455545495-20292-1-git-send-email-peter.ujfalusi@ti.com>
 <1455545495-20292-5-git-send-email-peter.ujfalusi@ti.com>
 <20160215152635.GN18988@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B5692606FF
 for <alsa-devel@alsa-project.org>; Tue, 16 Feb 2016 13:46:20 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20160215152635.GN18988@sirena.org.uk>
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 15, 2016 at 03:26:35PM +0000, Mark Brown wrote:
> On Mon, Feb 15, 2016 at 04:11:35PM +0200, Peter Ujfalusi wrote:
> 
> > Most CPU and codec drivers can select their system clock from different
> > sources. They rely on snd_soc_dai_set_sysclk(x, sysclk_id, x, x) to do so.
> > Add support for selecting which clock need to be selected along with the
> > rate.
> 
> Rather than adding new bindings for the ASoC specific clocking APIs it
> seems better to use the standard clock API bindings and transition
> drivers to use that.  In the past the clock API didn't have DT bindings
> so wehad to do our own thing but I think now that's no longer the case?

I'm interested in this as well since I'm working on a set of similair 
patches implementing clocking and PLL related issues in the simple-card
driver. 

There would be some problems as the typical use-cases involving
setting a codecs clocks / PLLs to a multiple of the sample rate, data
width, etc. The clocking API should support this as well if that's the
way forward. However, since many of the clock settings are related to
codec internals, the gain from moving codec PLLs, clocks, etc to the
standard clock API would be rather limited. There is already support for
getting sysclk from this API, which makes sense. Shouldn't clock id be
seen more as a pin selection from the dai's point of view? 

I really like the idea of the simple-card driver. It seems most board
drivers really doesn't do much except setting up some clocks, which
should be done in DT anyway, given there are enough available bindings
to do so...

/Andreas
