From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Relax restrictions on WM8962 BCLK
	configuration
Date: Sat, 02 Oct 2010 12:03:37 +0100
Message-ID: <1286017417.3125.2.camel@odin>
References: <1285882000-17669-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id CDAC2103858
	for <alsa-devel@alsa-project.org>;
	Sat,  2 Oct 2010 13:03:39 +0200 (CEST)
Received: by mail-wy0-f179.google.com with SMTP id 42so3727492wyb.38
	for <alsa-devel@alsa-project.org>; Sat, 02 Oct 2010 04:03:39 -0700 (PDT)
In-Reply-To: <1285882000-17669-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On Thu, 2010-09-30 at 14:26 -0700, Mark Brown wrote:
> The restrictions on configuring BCLK are overly cautious, other constraints
> in the system should ensure that reconfiguration is not possible when the
> device is sufficiently active to be unable to support reclocking.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
