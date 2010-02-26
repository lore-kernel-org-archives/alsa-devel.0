From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Allow mulitple usage count of codec
 and cpu dai
Date: Fri, 26 Feb 2010 09:17:52 +0000
Message-ID: <1267175872.3212.7.camel@odin>
References: <1267143152-15861-1-git-send-email-jassi.brar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f220.google.com (mail-fx0-f220.google.com
	[209.85.220.220])
	by alsa0.perex.cz (Postfix) with ESMTP id 06D7A24413
	for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2010 10:17:57 +0100 (CET)
Received: by fxm20 with SMTP id 20so16724080fxm.32
	for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2010 01:17:55 -0800 (PST)
In-Reply-To: <1267143152-15861-1-git-send-email-jassi.brar@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassi.brar@samsung.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-02-26 at 09:12 +0900, Jassi Brar wrote:
> If we are to have a snd_soc_dai i.e, cpu_dai and codec_dai, shared among two
> or more dai_links we need to log the number of active users of the dai.
> For that, we change semantics of the snd_soc_dai.active flag from indicator
> to reference counter.
> 
> Signed-off-by: Jassi Brar <jassi.brar@samsung.com>

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
