From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: soc_pcm_open: Add missing bailout tag
Date: Thu, 25 Feb 2010 09:50:44 +0000
Message-ID: <1267091444.4037.71.camel@odin>
References: <1267064693-1228-1-git-send-email-jassisinghbrar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f220.google.com (mail-fx0-f220.google.com
	[209.85.220.220])
	by alsa0.perex.cz (Postfix) with ESMTP id C17B31037FE
	for <alsa-devel@alsa-project.org>; Thu, 25 Feb 2010 10:50:48 +0100 (CET)
Received: by fxm20 with SMTP id 20so13618221fxm.32
	for <alsa-devel@alsa-project.org>; Thu, 25 Feb 2010 01:50:48 -0800 (PST)
In-Reply-To: <1267064693-1228-1-git-send-email-jassisinghbrar@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: jassisinghbrar@gmail.com
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, Jassi Brar <jassi.brar@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-02-25 at 11:24 +0900, jassisinghbrar@gmail.com wrote:
> From: Jassi Brar <jassi.brar@samsung.com>
> 
> The codec_dai needs to be shutdown should the machine startup fails.
> This patch adds another bailout tag for that case and rename the tag
> for configuration failures.
> 
> Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
> ---

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
