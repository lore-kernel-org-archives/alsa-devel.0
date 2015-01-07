From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH 1/2] ASoC: fsl_dma: Remove 'path' field
 from dma_object struct
Date: Wed, 07 Jan 2015 11:23:38 -0600
Message-ID: <54AD6B9A.6010401@tabi.org>
References: <1420651312-21671-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by alsa0.perex.cz (Postfix) with ESMTP id A9B19265065
 for <alsa-devel@alsa-project.org>; Wed,  7 Jan 2015 18:23:41 +0100 (CET)
In-Reply-To: <1420651312-21671-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>, broonie@kernel.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Fabio Estevam wrote:
> From: Fabio Estevam<fabio.estevam@freescale.com>
>
> The 'path' field has not a real purpose, so let's get rid of it.

I'm pretty sure that it *did* have a real purpose, but it's not needed 
any more.  Let me try to figure out what happened, so you can specify 
that in the changelog.
