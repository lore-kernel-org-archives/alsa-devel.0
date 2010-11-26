From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/4] ASoC: Convert WM8994 to use
 soc-cache.c cache functions
Date: Fri, 26 Nov 2010 18:01:10 +0000
Message-ID: <1290794470.3298.65.camel@odin>
References: <1290792224-21758-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 646E924422
	for <alsa-devel@alsa-project.org>; Fri, 26 Nov 2010 19:01:14 +0100 (CET)
Received: by wyi11 with SMTP id 11so2211596wyi.38
	for <alsa-devel@alsa-project.org>; Fri, 26 Nov 2010 10:01:14 -0800 (PST)
In-Reply-To: <1290792224-21758-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On Fri, 2010-11-26 at 17:23 +0000, Mark Brown wrote:
> In the process we convert the driver to read registers one at a time
> when initialising the cache. This has the effect of working around
> limitations in the sizes of I2C transactions which can be done by some
> CPUs. Due to the sparseness of the register map the overhead from this
> should be minimual unless I2C transactions are very expensive to start.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

All

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
