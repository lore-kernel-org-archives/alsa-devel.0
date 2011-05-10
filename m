From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [Device-drivers-devel] [PATCH] ASoC: Fix NULL vs.
	0 warning in SSM2602
Date: Tue, 10 May 2011 18:48:58 -0400
Message-ID: <BANLkTi=btxtcGeSZAQVAcPxS6VKTAeEqWg@mail.gmail.com>
References: <1305064982-26328-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yi0-f51.google.com (mail-yi0-f51.google.com
	[209.85.218.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 1F12E103810
	for <alsa-devel@alsa-project.org>;
	Wed, 11 May 2011 00:49:21 +0200 (CEST)
Received: by yib2 with SMTP id 2so2674260yib.38
	for <alsa-devel@alsa-project.org>; Tue, 10 May 2011 15:49:18 -0700 (PDT)
In-Reply-To: <1305064982-26328-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, patches@opensource.wolfsonmicro.com, device-drivers-devel@blackfin.uclinux.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, May 10, 2011 at 18:03, Mark Brown wrote:
> sparse complains if 0 is used as a NULL pointer constant.

Acked-by: Mike Frysinger <vapier@gentoo.org>
-mike
