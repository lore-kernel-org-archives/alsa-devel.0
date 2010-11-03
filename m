From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Convert soc-jack code to use
 request_any_context_irq()
Date: Wed, 03 Nov 2010 13:50:53 +0000
Message-ID: <1288792253.3277.48.camel@odin>
References: <1288791368-22772-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 6AA9024366
	for <alsa-devel@alsa-project.org>; Wed,  3 Nov 2010 14:50:58 +0100 (CET)
Received: by eyg24 with SMTP id 24so230038eyg.38
	for <alsa-devel@alsa-project.org>; Wed, 03 Nov 2010 06:50:58 -0700 (PDT)
In-Reply-To: <1288791368-22772-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-11-03 at 09:36 -0400, Mark Brown wrote:
> Allow the standard soc-jack GPIO based jack handling to handle the use of
> GPIOs which may sleep (such as those on GPIO expanders) by converting the
> code to use request_any_context_irq().
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Both 

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
