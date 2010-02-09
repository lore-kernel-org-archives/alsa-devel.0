From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Add Phytec i.MX sound support for AC97
Date: Tue, 9 Feb 2010 11:37:45 +0000
Message-ID: <20100209113745.GA2485@rakim.wolfsonmicro.main>
References: <20100209101428.GG17643@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A489724382
	for <alsa-devel@alsa-project.org>; Tue,  9 Feb 2010 12:37:47 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20100209101428.GG17643@pengutronix.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 09, 2010 at 11:14:28AM +0100, Sascha Hauer wrote:

> Hi Marc et all,

Mar*k*.

> The following patch adds support for Phytec i.MX boards in AC97
> mode. With this patch only some board glue code is missing to
> enable sound for the first i.MX boards. I'll push the board code
> through my i.MX tree. Please consider including this patch for -next.
> 
> Sascha
> 
> 
> From 264b0916b712d6cbbcbd2f7b208b1c84b40a3f54 Mon Sep 17 00:00:00 2001
> From: Sascha Hauer <s.hauer@pengutronix.de>

Applied but please in future send don't send patches with patch headers
in the body and explanatory text before them like this since none of the
tools understand this format, the entire body of the e-mail gets read as
the commit messsage.
