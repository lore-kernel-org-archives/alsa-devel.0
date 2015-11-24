From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 2/3] ASoC: core: add a dapm sink widget
Date: Tue, 24 Nov 2015 10:48:42 +0100
Message-ID: <5654327A.5080406@metafoo.de>
References: <1448293951-32071-1-git-send-email-vinod.koul@intel.com>
 <1448293951-32071-3-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-188.synserver.de (smtp-out-194.synserver.de
 [212.40.185.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 165212614A7
 for <alsa-devel@alsa-project.org>; Tue, 24 Nov 2015 10:48:44 +0100 (CET)
In-Reply-To: <1448293951-32071-3-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On 11/23/2015 04:52 PM, Vinod Koul wrote:
> DAPM models various widgets but lacks a sink widget.
> DSPs can have modules which take audio data, process it and are
> capable of generating events thus acting as a sink of data.
> 
> To make the dapm graph complete for such paths we need a dapm
> sink widget for these modules, so add a SND_SOC_DAPM_SINK to
> declare such a widget.
> This widget will be treated as SND_SOC_DAPM_EP_SINK endpoint in
> the dapm graph

Except for the strange formating of the commit message this looks good.

Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>
