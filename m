From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH v3] ASoC: dapm: Add new widget type
 snd_soc_dapm_dsp_component
Date: Fri, 16 Jun 2017 13:26:24 +0100
Message-ID: <1497615984.2561.25.camel@loki>
References: <1497555964-4862-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <20170616110953.waxwojvnrgrnlc26@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id AD66D267526
 for <alsa-devel@alsa-project.org>; Fri, 16 Jun 2017 14:26:27 +0200 (CEST)
In-Reply-To: <20170616110953.waxwojvnrgrnlc26@sirena.org.uk>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2017-06-16 at 12:09 +0100, Mark Brown wrote:
> On Thu, Jun 15, 2017 at 08:46:04PM +0100, Liam Girdwood wrote:
> > Add a new widget type to represent internal DSP components and allow DSP
> > drivers and firmware to define topologies using this widget type.
> 
> Hrm, this is replacing the previous ones with buffer, effect, and the
> SRCs?  I actually thought most of the types could be useful there - I
> can see from a sequencing point of view we might want to start buffers
> first, and the SRC and encoder/decoder widgets are going to be useful
> when we're tracking more than just simple routing with DAPM. 

I'm not sure if they would be useful for sequencing by the DAPM core
since the widgets will really be internal to the DSP and there would be
an increased latency cost of sequencing outside of the DSP.

The main use that I can see is in defining topologies (and probably
exporting topology) and this is where the current DAPM widget list has
some missing types wrt to DSPs. 

I can either :-

1) Use a specific buffer, src, asrc, etc widget types for each component

or

2) Use a generic widget and append private data with type.

Preference is 1 as it simplifies driver code.

>  The only
> bit I was really concerned about was the overlap between pipeline and
> effect.

I know, but you made me think about whether the core really does care
about DSP specific types. :)

Ok, I can redo and use specific types, but there still is a problem of
how do we configure a pipeline (a collection of widgets, where several
pipelines can make a path from PCM to DAI). This configuration data is
not hw/sw params type data, but more DSP scheduling type data. My
original thought was the pipeline widget, as there is nothing else that
cleanly fits into the ABI and that the pipeline scheduling data is DAPM
widget/graph related anyway.

Another alternative is extending the topology ABI and introduce a
pipeline object that would be ignore by the core and just used by
certain drivers and firmwares ?

Liam
