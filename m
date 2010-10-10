From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/2] ASoC: Shrink code size for WM8962
 register defaults table
Date: Sun, 10 Oct 2010 11:29:49 +0100
Message-ID: <1286706589.3429.14.camel@odin>
References: <1286509801-7985-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id CB9BE103801
	for <alsa-devel@alsa-project.org>;
	Sun, 10 Oct 2010 12:29:54 +0200 (CEST)
Received: by wyb32 with SMTP id 32so1115044wyb.38
	for <alsa-devel@alsa-project.org>; Sun, 10 Oct 2010 03:29:54 -0700 (PDT)
In-Reply-To: <1286509801-7985-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On Thu, 2010-10-07 at 20:50 -0700, Mark Brown wrote:
> Dramatically reduce the code size for the WM8962 register defaults
> table
> by switching to explicitly initialise only defined registers, relying
> on
> static defaulting to zero for the overwelming bulk of the register
> map.
> 
> Similar treatement for the register access table will come later and
> will
> produce a similarly dramatic code size shrink.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Both

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
