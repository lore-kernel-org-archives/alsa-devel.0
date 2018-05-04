From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 2/4] ASoC: compress: Clarify the intent of
 current compressed ops handling
Date: Fri, 4 May 2018 13:04:08 +0100
Message-ID: <20180504120408.GL20410@imbe.wolfsonmicro.main>
References: <20180426163007.5632-1-ckeepax@opensource.cirrus.com>
 <20180426163007.5632-2-ckeepax@opensource.cirrus.com>
 <20180503162714.GX6014@localhost>
 <20180504115922.GK20410@imbe.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 23D1D267235
 for <alsa-devel@alsa-project.org>; Fri,  4 May 2018 14:04:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20180504115922.GK20410@imbe.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com, patches@opensource.cirrus.com, lgirdwood@gmail.com, vkoul@kernel.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, May 04, 2018 at 12:59:22PM +0100, Charles Keepax wrote:
> On Thu, May 03, 2018 at 09:57:14PM +0530, Vinod Koul wrote:
> > On Thu, Apr 26, 2018 at 05:30:05PM +0100, Charles Keepax wrote:
> > > It is proposed that the model adopted for compressed component
> > > support currently should be that multiple components are supported
> > > on a compressed DAI but that they must provide a unified set of
> > > capabilities. So for example having multiple components involved in
> > > the decode is fine but the core will not presently attempt to make
> > > smart decisions like offloading MP3 to this component and AAC another.
> > 
> > Well this is supposed to be entirely a userspace call, we just present
> > devices with capabilities and the usespace decides... Btw capabilities are
> > supposed to be dynamic.
> 
> My intention was to not suggest otherwise. The only point I
> was really making is that if there are multiple components on
> the link the core won't make attempt to amalgamate output from
> those components, but we will inform all components of activity
> on the DAI.
> 
> > Looking at the code again now, I realized that we are treating compress like
> > PCM. It makes little sense to me to have multiple components for a
> > compressed device, does that model on your systems..?
> 
> So that was very much my initial reaction as well [1], and
> certainly for our devices it only really makes sense to have a
> single component handle the compressed ops. Hence why I initially
> started with basically just returning the first component with
> compressed ops.
> 
> That said however, thinking about it more I do think there are
> pretty reasonable systems that have multiple components on a
> compressed DAI. For example I could imagine a system where you
> have a DSP on both the AP and CODEC ends of the DAI link and
> they split the decode doing some work on each. In that case
> one would want calls like open and set_params to go to both
> components.
> 
> As you say separate decode engines probably belong on separate
> DAIs and that kinda is what led me to the current series. It
> should implement enough to enable basic multi-component use-cases
> but makes it more clear that we are not supporting multiplexing
> multiple offloads onto a single DAI at the moment.
> 
> Thanks,
> Charles
> 
> [1] https://patchwork.kernel.org/patch/10182603/

Just adding Vinod's kernel.org address.

Thanks,
Charles
