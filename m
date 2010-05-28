From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC: Hooking a TI CODEC to a i.MX27 MCU
Date: Fri, 28 May 2010 12:08:07 +0100
Message-ID: <20100528110805.GA9917@sirena.org.uk>
References: <20100524074946.GC16346@www.longlandclan.yi.org>
	<1274698156.3064.93.camel@odin>
	<20100525004126.GA10968@www.longlandclan.yi.org>
	<20100525022646.GA18030@www.longlandclan.yi.org>
	<1274806007.4728.3.camel@gnutoo-desktop>
	<20100526132129.GA13644@www.longlandclan.yi.org>
	<20100527004702.GA22091@sirena.org.uk>
	<20100528020621.GA12531@www.longlandclan.yi.org>
	<4BFF5AC7.3060409@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id A342524350
	for <alsa-devel@alsa-project.org>;
	Fri, 28 May 2010 13:08:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4BFF5AC7.3060409@eukrea.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eric B??nard <eric@eukrea.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, May 28, 2010 at 07:55:19AM +0200, Eric B??nard wrote:
> Hi Stuart,

Don't drop CCs from mailing list postings, you should always maintain
CCs for kernel related lists.

> I'll try to find our I2C init sequence and send it to you as this was 
> the hardest part of the thing to get the codec running.

Under Linux you'd normally not be using just a hard coded sequence of
I2C writes...
