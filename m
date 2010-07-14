From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Handle read failures in codec_reg
Date: Wed, 14 Jul 2010 16:25:34 +0100
Message-ID: <1279121134.3080.148.camel@odin>
References: <1279120513-29226-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id B5925103882
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Jul 2010 17:25:37 +0200 (CEST)
Received: by wwb13 with SMTP id 13so1406891wwb.20
	for <alsa-devel@alsa-project.org>; Wed, 14 Jul 2010 08:25:37 -0700 (PDT)
In-Reply-To: <1279120513-29226-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On Wed, 2010-07-14 at 16:15 +0100, Mark Brown wrote:
> When a device is powered down volatile registers can't be read so
> attempts to display codec_reg will show error values, and obviously
> it is also possible for there to be hardware errors too. Check for
> errors from reads and display them more clearly when formatting
> codec_reg.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
