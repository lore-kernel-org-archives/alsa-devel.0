From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: MPC5200: replace of_device with
 platform_device
Date: Wed, 24 Aug 2011 10:17:16 +0100
Message-ID: <20110824091645.GD26317@sirena.org.uk>
References: <1314136106-26127-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 4DB54103914
	for <alsa-devel@alsa-project.org>;
	Wed, 24 Aug 2011 11:30:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1314136106-26127-1-git-send-email-timur@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 23, 2011 at 04:48:26PM -0500, Timur Tabi wrote:
> 'struct of_device' no longer exists, and its functionality has been merged
> into platform_device.  Update the MPC5200 audio DMA driver (mpc5200_dma)
> accordingly.  This fixes a build break.

Which version does this build issue apply to - 3.1 or 3.2?
