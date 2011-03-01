From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH v2 2/4] ASoC: Fix burstsize and DSP_B
 format problems in imx-ssi.
Date: Tue, 01 Mar 2011 20:59:14 +0000
Message-ID: <1299013154.3345.84.camel@odin>
References: <1298988128-11520-1-git-send-email-javier.martin@vista-silicon.com>
	<1298988128-11520-3-git-send-email-javier.martin@vista-silicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id A6EFB24378
	for <alsa-devel@alsa-project.org>; Tue,  1 Mar 2011 21:59:17 +0100 (CET)
Received: by mail-wy0-f179.google.com with SMTP id 28so5042858wyb.38
	for <alsa-devel@alsa-project.org>; Tue, 01 Mar 2011 12:59:17 -0800 (PST)
In-Reply-To: <1298988128-11520-3-git-send-email-javier.martin@vista-silicon.com>
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
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org, b32542@freescale.com
List-Id: alsa-devel@alsa-project.org

On Tue, 2011-03-01 at 15:02 +0100, Javier Martin wrote:
> When choosing IMX_DMA flag, burtsizes are set to its default
> value (0) which leads to driver malfunction. Change them to 4.
> 
> DSP_B interface needs additional flag to match DSP_B formats
> as described in several codecs as wm8741 and aic3205.
> 
> Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>

Please CC both Mark and I on all ASoC patches otherwise I may not see
them.

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
