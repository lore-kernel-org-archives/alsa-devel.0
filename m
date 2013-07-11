From: timur@tabi.org
Subject: Re: [PATCH] ASoC: fsl: Disable SSI in trigger() if
 RE/TE are both cleared
Date: Thu, 11 Jul 2013 12:14:56 -0500
Message-ID: <51DEE810.3090304@tabi.org>
References: <1373453034-21618-1-git-send-email-b42378@freescale.com>
 <20130711165401.GU24508@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by alsa0.perex.cz (Postfix) with ESMTP id 0CEFF26588B
 for <alsa-devel@alsa-project.org>; Thu, 11 Jul 2013 19:14:54 +0200 (CEST)
In-Reply-To: <20130711165401.GU24508@sirena.org.uk>
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
Cc: fabio.estevam@freescale.com, alsa-devel@alsa-project.org, shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On 07/11/2013 11:54 AM, Mark Brown wrote:
>> > The code enabled SSIEN when triggered by SNDRV_PCM_TRIGGER_START,
>> > so move the disable code to SNDRV_PCM_TRIGGER_STOP for symmetric.
> Applied, thanks.

Don't you need an ACK from the maintainer of the driver before applying
it?  I haven't had a chance to test it yet.

-- 
Timur Tabi
