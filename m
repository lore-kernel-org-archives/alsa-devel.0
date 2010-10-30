From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Remove volatility from WM8900 POWER1
	register
Date: Sat, 30 Oct 2010 17:28:11 +0100
Message-ID: <1288456091.3286.48.camel@odin>
References: <1288393716-19903-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id D1AF81037F8
	for <alsa-devel@alsa-project.org>;
	Sat, 30 Oct 2010 18:28:19 +0200 (CEST)
Received: by wye20 with SMTP id 20so4224189wye.38
	for <alsa-devel@alsa-project.org>; Sat, 30 Oct 2010 09:28:19 -0700 (PDT)
In-Reply-To: <1288393716-19903-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On Fri, 2010-10-29 at 16:08 -0700, Mark Brown wrote:
> Not all bits can be read back from POWER1 so avoid corruption when using
> a read/modify/write cycle by marking it non-volatile - the only thing we
> read back from it is the chip revision which has diagnostic value only.
> We can re-add later but that's a more invasive change than is suitable
> for a bugfix.
> 
> Change-Id: I846ac8bba474275dcbda5ff82fc006554a06d21e
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
