From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 2/3] ASoC: core: add a dapm sink widget
Date: Tue, 24 Nov 2015 15:49:07 +0530
Message-ID: <20151124101907.GC25173@localhost>
References: <1448293951-32071-1-git-send-email-vinod.koul@intel.com>
 <1448293951-32071-3-git-send-email-vinod.koul@intel.com>
 <5654327A.5080406@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id D6CBF26152C
 for <alsa-devel@alsa-project.org>; Tue, 24 Nov 2015 11:15:15 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <5654327A.5080406@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 24, 2015 at 10:48:42AM +0100, Lars-Peter Clausen wrote:
> On 11/23/2015 04:52 PM, Vinod Koul wrote:
> > DAPM models various widgets but lacks a sink widget.
> > DSPs can have modules which take audio data, process it and are
> > capable of generating events thus acting as a sink of data.
> > 
> > To make the dapm graph complete for such paths we need a dapm
> > sink widget for these modules, so add a SND_SOC_DAPM_SINK to
> > declare such a widget.
> > This widget will be treated as SND_SOC_DAPM_EP_SINK endpoint in
> > the dapm graph
> 
> Except for the strange formating of the commit message this looks good.

Checkpath now seems to warn if commit message > 65chars so have set it for
commit message

> Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks

-- 
~Vinod
