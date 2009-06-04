From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Palm interrupt driven touchscreen driver
Date: Thu, 4 Jun 2009 11:38:07 +0100
Message-ID: <20090604103807.GG6983@rakim.wolfsonmicro.main>
References: <200906032341.03266.marek.vasut@gmail.com>
	<f17812d70906031835u5a650772wedcab94fd6f2ae2d@mail.gmail.com>
	<20090604085407.GB6983@rakim.wolfsonmicro.main>
	<alpine.LNX.2.00.0906041104080.4067@eeebox2.perex-int.cz>
	<20090604093737.GF6983@rakim.wolfsonmicro.main>
	<s5hiqjcqqo9.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0B58724464
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Jun 2009 12:38:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hiqjcqqo9.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>, Eric Miao <eric.y.miao@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 04, 2009 at 11:44:22AM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > There was a very strong pushback against the idea of adding a void *
> > to the structure, which is what I'd be looking for.

> Yes, I was against the void pointer because there is no guarantee
> of the data-type correctness between the data and the user.
> The normal drvdata is fine because the creator and the user are the
> same.  But, the proposal of private_driver_data (of the last one, at
> least) is no such a scenario.

Do you have a pointer to this proposal?  I don't remember it and my
google-fu is weak today.
