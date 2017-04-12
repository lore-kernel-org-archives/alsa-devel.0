From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH 2/2] ASoC: fsl ssi doc: Move
 playback/capture dma properties to the optional section
Date: Wed, 12 Apr 2017 08:22:12 -0500
Message-ID: <d7851663-7dd9-3ab0-cda6-9bd58918866e@tabi.org>
References: <1492003236-29690-1-git-send-email-fabio.estevam@nxp.com>
 <1492003236-29690-2-git-send-email-fabio.estevam@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by alsa0.perex.cz (Postfix) with ESMTP id BAAB8266F3E
 for <alsa-devel@alsa-project.org>; Wed, 12 Apr 2017 15:22:14 +0200 (CEST)
In-Reply-To: <1492003236-29690-2-git-send-email-fabio.estevam@nxp.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@nxp.com>, broonie@kernel.org
Cc: nicoleotsuka@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Fabio Estevam wrote:
> +- fsl,playback-dma: Phandle to a node for the DMA channel to use for
> +                    playback of audio.  This is typically dictated by SOC
> +                    design.  See the notes below.
> +		    Only used on Power Architecture.

Looks like you have an indentation problem.

Also, I think you should combine these two patches into one.
