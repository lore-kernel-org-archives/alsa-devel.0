From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: omap: Remove needless prints from
 machine drivers
Date: Sun, 10 Oct 2010 11:37:41 +0100
Message-ID: <1286707061.3429.17.camel@odin>
References: <1286372846-10238-1-git-send-email-jhnikula@gmail.com>
	<20101006154334.GD2803@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f41.google.com (mail-ww0-f41.google.com [74.125.82.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 077B6103810
	for <alsa-devel@alsa-project.org>;
	Sun, 10 Oct 2010 12:39:04 +0200 (CEST)
Received: by wwd20 with SMTP id 20so1318818wwd.2
	for <alsa-devel@alsa-project.org>; Sun, 10 Oct 2010 03:39:04 -0700 (PDT)
In-Reply-To: <20101006154334.GD2803@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-10-06 at 08:43 -0700, Mark Brown wrote:
> On Wed, Oct 06, 2010 at 04:47:26PM +0300, Jarkko Nikula wrote:
> > It is currently completely normal to execute these machine drivers code on
> > different boards if the kernel includes support for multiple boards so no
> > error message should be printed if the machine_is_xxx does not match with
> > the machine driver.
> > 
> > Therefore remove these pr_err and pr_debug prints in those cases.
> > 
> > Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Applied.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
