From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 1/2] ASoC: wm_adsp: Add code_probe and
	codec_remove	stubs
Date: Tue, 9 Jun 2015 17:43:29 +0100
Message-ID: <20150609164329.GC27675@opensource.wolfsonmicro.com>
References: <1433863017-25349-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <20150609160043.GD14071@sirena.org.uk>
 <20150609161356.GB27675@opensource.wolfsonmicro.com>
 <20150609162045.GF14071@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 89A322606C2
 for <alsa-devel@alsa-project.org>; Tue,  9 Jun 2015 18:43:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20150609162045.GF14071@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 09, 2015 at 05:20:45PM +0100, Mark Brown wrote:
> On Tue, Jun 09, 2015 at 05:13:56PM +0100, Richard Fitzgerald wrote:
> > On Tue, Jun 09, 2015 at 05:00:43PM +0100, Mark Brown wrote:
> 
> > > I'm still not a big fan of the double registration that's being done -
> > > if nothing else the fact that it's not also factoring out the creation
> > > of the DSP controls seems wrong.
> 

We can certainly look at factoring out that control creation once we have
a probe function in wm_adsp to put them in. Which is what this patch creates.

> > I don't see the point of trying to fight against the design of ASoC with
> > the second probe. ASoC gives us what we need at the codec_probe stage
> > so why try to invent something different?
> 
> Well, you could've still hung things off the struct device - it's not
> like the ASoC level device is a requirement here - and like I say the

I'm doing it in the codec_probe because by that time ASoC has created its
codec: debugfs node and I can put the dsp debugfs nodes under that. If I
created the debugfs earlier before ASoC has probed the codec that node
won't exist so I'd have to create my own debugfs node, and it seems a bit
odd and untidy to have some codec debug info under the asoc node but some
stuff somewhere else.

> fact that it's not actually factoring out the initialisation that's
> already happening at the ASoC probe isn't good.
