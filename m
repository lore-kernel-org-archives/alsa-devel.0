From: Timur Tabi <timur@freescale.com>
Subject: Re: Repeated calls to trigger and prepare in ALSA
	driver
Date: Mon, 7 Jul 2008 07:57:06 -0400
Message-ID: <E06DB28A-67DE-431E-BF5B-4F3C99AA5B9C@freescale.com>
References: <BLU123-W525F0D533D07797E6AAA77B29B0@phx.gbl>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 032F6245DC
	for <alsa-devel@alsa-project.org>;
	Mon,  7 Jul 2008 16:20:18 +0200 (CEST)
In-Reply-To: <BLU123-W525F0D533D07797E6AAA77B29B0@phx.gbl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: DSP Tech <dsptech@hotmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On Jul 4, 2008, at 7:12 AM, DSP Tech wrote:

> I ran a OSS test application. I find that trigger() and prepare()  
> calls are being called repeatedly.

Yes, this is normal.

> Consequently, the DMA tries to reset and start playback for every  
> buffer.

Then you need to redesign your driver so that either A) this doesn't  
happen, or B) it doesn't matter that it happens.
