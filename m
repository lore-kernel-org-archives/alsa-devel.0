From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: multi-component - JZ4740: Fix issues
 of the i2s driver in the multi-component branch
Date: Thu, 01 Jul 2010 07:46:27 +0100
Message-ID: <1277966787.12813.83.camel@vega>
References: <1277639534-5104-16-git-send-email-lrg@slimlogic.co.uk>
	<1277667237-15541-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 850DB103820
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Jul 2010 08:46:32 +0200 (CEST)
Received: by mail-fx0-f51.google.com with SMTP id 15so941714fxm.38
	for <alsa-devel@alsa-project.org>; Wed, 30 Jun 2010 23:46:32 -0700 (PDT)
In-Reply-To: <1277667237-15541-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, 2010-06-27 at 21:33 +0200, Lars-Peter Clausen wrote:
> There were two dai probe callbacks of which only one was used. This patch
> merges them.
> The dai remove callback was not hooked up to the dai_driver struct.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks, will apply soon.

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
