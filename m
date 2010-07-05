From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Use bool rather than 1 bit bitfield
 in multi-component
Date: Mon, 05 Jul 2010 22:10:05 +0100
Message-ID: <1278364205.3258.210.camel@odin>
References: <1277407467.3100.579.camel@odin>
	<1278014134-19158-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 895E4103805
	for <alsa-devel@alsa-project.org>;
	Mon,  5 Jul 2010 23:10:05 +0200 (CEST)
Received: by fxm15 with SMTP id 15so4084739fxm.38
	for <alsa-devel@alsa-project.org>; Mon, 05 Jul 2010 14:10:05 -0700 (PDT)
In-Reply-To: <1278014134-19158-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On Thu, 2010-07-01 at 20:55 +0100, Mark Brown wrote:
> This fixes sparse complaints about the bitfield being signed but
> only 1 bit wide (so not enough space to store the sign bit).
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Applied.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
