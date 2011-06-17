From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [PATCH 2/3 v2] ASoC: Blackfin: Add bf5xx-adau1701
	machine driver
Date: Fri, 17 Jun 2011 04:22:42 -0400
Message-ID: <BANLkTikVL=DP8jL-J9SoZY6HzX6CQ+X0XA@mail.gmail.com>
References: <1307971582-13532-1-git-send-email-lars@metafoo.de>
	<1307971582-13532-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 453CA24467
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Jun 2011 10:23:02 +0200 (CEST)
Received: by fxm5 with SMTP id 5so894099fxm.38
	for <alsa-devel@alsa-project.org>; Fri, 17 Jun 2011 01:23:02 -0700 (PDT)
In-Reply-To: <1307971582-13532-2-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, device-drivers-devel@blackfin.uclinux.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 13, 2011 at 09:26, Lars-Peter Clausen wrote:
> +static int bfin_eval_adau1701_probe(struct platform_device *pdev)

__devinit

seems all of the Blackfin machine drivers could use this fix ...
-mike
