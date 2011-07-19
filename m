From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/3] make the sgtl5000-codec work
Date: Tue, 19 Jul 2011 16:09:03 +0100
Message-ID: <20110719150903.GF9652@opensource.wolfsonmicro.com>
References: <1311004385-14554-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2D0D324552
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Jul 2011 17:09:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1311004385-14554-1-git-send-email-w.sang@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Dong Aisheng <b29396@freescale.com>, Zeng Zhaoming <b32542@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 18, 2011 at 05:53:02PM +0200, Wolfram Sang wrote:
> These are three patches I developed while trying to make the sgtl5000 work on
> an mx28evk with the mxs-support provided by Dong Aisheng. The chip used to
> lock up before, because a wrong value was written to the power control.

> The first patch removes code duplication
> The second one is for user-comfort
> The third one makes the device work

Shouldn't we be restructuring this series so that the last change goes
in as a critical bugfix for stable and the other two code cleanups then
go on top of it?
