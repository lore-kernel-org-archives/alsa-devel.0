From: Liam Girdwood <liam.r.girdwood@intel.com>
Subject: Re: Audio Miniconference 2013 schedule - Edinburgh
	21st October
Date: Fri, 04 Oct 2013 11:32:23 +0100
Message-ID: <1380882743.2682.8.camel@loki>
References: <20131003181754.GE27287@sirena.org.uk> <524E92C5.3080903@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 9852C26109C
 for <alsa-devel@alsa-project.org>; Fri,  4 Oct 2013 12:32:29 +0200 (CEST)
In-Reply-To: <524E92C5.3080903@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: Colin Guthrie <colin@guthr.ie>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Arun Raghavan <arun.raghavan@collabora.co.uk>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>, Tanu Kaskinen <tanuk@iki.fi>, David Henningsson <david.henningsson@canonical.com>, "Bossart,
 Pierre-louis" <pierre-louis.bossart@intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2013-10-04 at 12:04 +0200, Daniel Mack wrote:
> On 03.10.2013 20:17, Mark Brown wrote:
> > The audio mini-summit in Edinburgh is now less than a month away so
> > it seems like a good time to start pulling together a schedule.
> > Looking at the topics people mentioned when filling out the
> > registration form there were three major topics that people wanted
> > to cover:
> > 
> > - Compressed audio review: tinycompress, integration into
> > userspace, driver upstreaming.
> > 
> > - UCM and other use case management status & review.
> > 
> > - Effects offload to DSPs with dynamically instantiatable
> > algorithms, and general dynamic DSP firmware handling.
> 
> - The status of DPCM and where we want to go with it. I think that's a
> very interesting and important yet fairly undocumented feature that
> not even the original authors seem to fully understand anymore ;)

Fwiw, I've posted some recent patches to ASoC docs that include DPCM
amongst other updates :) I'll also bring along some DPCM slides for
Edinburgh too.

DSP FW handling and effects are important topics for me this year. I do
have some patches for FW handling that have mostly been updated from the
initial alsa-devel patch review (sadly from last December when I was at
TI) and I plan to send for review V2 when HSW DSP driver is upstream.

Liam



---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
