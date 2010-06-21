From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: pandora: fix CLKX polarity
Date: Mon, 21 Jun 2010 17:59:08 +0100
Message-ID: <1277139548.3288.44.camel@odin>
References: <1276782328-3219-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id E6BE724395
	for <alsa-devel@alsa-project.org>;
	Mon, 21 Jun 2010 18:59:06 +0200 (CEST)
Received: by wyb40 with SMTP id 40so2497985wyb.38
	for <alsa-devel@alsa-project.org>; Mon, 21 Jun 2010 09:59:06 -0700 (PDT)
In-Reply-To: <1276782328-3219-1-git-send-email-notasas@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-06-17 at 16:45 +0300, Grazvydas Ignotas wrote:
> After mass production started it was found that several boards exhibit
> noise problems during sound playback. After some investigation it was
> determined that CLKX polarity is set incorrectly, and even if most boards
> can tolerate the wrong setting, there are some that don't.
> 
> Fix polarity setup in the board file. As the clock settings for input and
> output now match, merge in and out functions and structures to simplify
> code.
> 
> Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
> ---
>  sound/soc/omap/omap3pandora.c |   36 ++++++++----------------------------
>  1 files changed, 8 insertions(+), 28 deletions(-)
> 

Applied.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
