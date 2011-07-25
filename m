From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: core - make IO calls return a valid
 errno on failure.
Date: Mon, 25 Jul 2011 22:22:14 +0100
Message-ID: <20110725212213.GD6086@opensource.wolfsonmicro.com>
References: <1311588959-3512-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C82EB2417E
	for <alsa-devel@alsa-project.org>;
	Mon, 25 Jul 2011 23:22:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1311588959-3512-1-git-send-email-lrg@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 25, 2011 at 11:15:59AM +0100, Liam Girdwood wrote:
> IO call failures should return an errno instead of -1

Yeah, it really should but it's kind of tricky for the reads as we're
returning errors in band and we could have 32 bit registers (I'm
guessing the platform versions already do) so we lose.  :/  Not sure
what the best thing to do there is, changing to return the errors out of
band for reads is more painful than I care to contemplate.
