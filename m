From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Put WM8962 GPIO2/3 into GPIO mode
 when configuring platform data too
Date: Sat, 02 Oct 2010 12:20:16 +0100
Message-ID: <1286018416.3125.7.camel@odin>
References: <1285980699-27382-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 26A76103A67
	for <alsa-devel@alsa-project.org>;
	Sat,  2 Oct 2010 13:20:18 +0200 (CEST)
Received: by wyb42 with SMTP id 42so3733553wyb.38
	for <alsa-devel@alsa-project.org>; Sat, 02 Oct 2010 04:20:17 -0700 (PDT)
In-Reply-To: <1285980699-27382-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On Fri, 2010-10-01 at 17:51 -0700, Mark Brown wrote:
> GPIO2 and GPIO3 on the WM8962 are MFPs and need to be put into GPIO mode
> before the GPIO block can be used to control them. We're already doing
> this when used via gpiolib, factor out the code for use when setting static
> configurations via platform data as well.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
