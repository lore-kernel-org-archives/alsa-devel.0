From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: cs4270: fix dynamic initialization
 of register cache
Date: Thu, 6 Jan 2011 22:31:41 +0000
Message-ID: <20110106223141.GH8408@opensource.wolfsonmicro.com>
References: <1294339968-420-1-git-send-email-timur@freescale.com>
	<20110106201511.GA8018@opensource.wolfsonmicro.com>
	<4D262B29.3010606@freescale.com>
	<20110106213139.GG8018@opensource.wolfsonmicro.com>
	<4D2635BC.1080108@freescale.com>
	<20110106220406.GI8018@opensource.wolfsonmicro.com>
	<4D263D1B.7040506@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E943E103909
	for <alsa-devel@alsa-project.org>; Thu,  6 Jan 2011 23:31:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4D263D1B.7040506@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: dp@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 06, 2011 at 04:07:23PM -0600, Timur Tabi wrote:

> My code *was* idiomatic the last time I touched it, which was early 2009.

Well, the OF stuff was pretty hairy prior to multi-component...  :)
