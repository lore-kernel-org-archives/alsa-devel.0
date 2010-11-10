From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/2] ASoC: Add trace events for ASoC
 register read/write
Date: Wed, 10 Nov 2010 21:04:34 +0000
Message-ID: <1289423074.3284.51.camel@odin>
References: <1289407146-20250-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id C9C0E1038AC
	for <alsa-devel@alsa-project.org>; Wed, 10 Nov 2010 22:04:38 +0100 (CET)
Received: by wye20 with SMTP id 20so240471wye.38
	for <alsa-devel@alsa-project.org>; Wed, 10 Nov 2010 13:04:38 -0800 (PST)
In-Reply-To: <1289407146-20250-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On Wed, 2010-11-10 at 16:39 +0000, Mark Brown wrote:
> The trace subsystem provides a convenient way of instrumenting the kernel
> which can be left on all the time with extremely low impact on the system
> unlike prints to the kernel log which can be very spammy. Begin adding
> support for instrumenting ASoC via this interface by adding trace for the
> register access primitives.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Both

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
