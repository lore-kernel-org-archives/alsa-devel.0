From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Fix mic bias handling in TI
	tlv320aic32x codec.
Date: Thu, 5 Jan 2012 15:56:07 +0000
Message-ID: <20120105155605.GA17659@opensource.wolfsonmicro.com>
References: <1325775904-22177-1-git-send-email-javier.martin@vista-silicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 48025243D0
	for <alsa-devel@alsa-project.org>; Thu,  5 Jan 2012 16:56:10 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1325775904-22177-1-git-send-email-javier.martin@vista-silicon.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Javier Martin <javier.martin@vista-silicon.com>
Cc: alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 05, 2012 at 04:05:04PM +0100, Javier Martin wrote:

> For this reason it's not possible to add this as
> a DAPM event since we lack the possibility to associate
> it to a DAPM route. So we use platform data totell the
> device whether we are connecting a microphone or not.

No, this change would be a regression - if this were a problem we'd not
have microphones working at all in ASoC.  The routing of the microphone
bias is done by the machine driver, not the CODEC driver.
