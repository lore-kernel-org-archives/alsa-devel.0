From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/4] Allow passing platform_data for
 pxa2xx-ac97
Date: Thu, 13 Aug 2009 21:40:34 +0100
Message-ID: <20090813204033.GA7519@sirena.org.uk>
References: <200907211633.14388.marek.vasut@gmail.com>
	<200907232039.37952.marek.vasut@gmail.com>
	<200907280728.21372.marek.vasut@gmail.com>
	<200907300255.01675.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 064F32462D
	for <alsa-devel@alsa-project.org>;
	Thu, 13 Aug 2009 22:40:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200907300255.01675.marek.vasut@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: alsa-devel@alsa-project.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Takashi Iwai <tiwai@suse.de>, dwmw2@infradead.org, cbou@mail.ru, Eric Miao <eric.y.miao@gmail.com>, avorontsov@ru.mvista.com, Robert Jarzmik <robert.jarzmik@free.fr>, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 30, 2009 at 02:55:01AM +0200, Marek Vasut wrote:

> From 207d54244768e94ce0144cba55acf4ae065e6ce0 Mon Sep 17 00:00:00 2001
> From: Marek Vasut <marek.vasut@gmail.com>
> Date: Tue, 21 Jul 2009 16:22:29 +0200
> Subject: [PATCH] Allow passing platform_data for pxa2xx-ac97
> 
> This patch adds support for passing platform data to ac97 bus devices
> from PXA2xx-AC97 driver..

I've applied this one too since it's ALSA only and it'll ease merge
issues next merge window - we can revisit if any of the other patches
get applied before.
