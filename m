From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 2/2] imx-ssi: increase minimum periods to 4
Date: Tue, 13 Apr 2010 16:36:35 +0100
Message-ID: <1271172995.3235.57.camel@odin>
References: <1271169489-339-1-git-send-email-s.hauer@pengutronix.de>
	<1271169489-339-3-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f178.google.com (mail-pz0-f178.google.com
	[209.85.222.178])
	by alsa0.perex.cz (Postfix) with ESMTP id 49B96103858
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Apr 2010 17:36:43 +0200 (CEST)
Received: by pzk8 with SMTP id 8so121713pzk.16
	for <alsa-devel@alsa-project.org>; Tue, 13 Apr 2010 08:36:42 -0700 (PDT)
In-Reply-To: <1271169489-339-3-git-send-email-s.hauer@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Valentin Longchamp <valentin.longchamp@epfl.ch>
List-Id: alsa-devel@alsa-project.org

On Tue, 2010-04-13 at 16:38 +0200, Sascha Hauer wrote:
> Currently the notification of elapsed periods is not very exact.
> Increase minimum periods to 4.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  sound/soc/imx/imx-pcm-fiq.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
