From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: ASoc: Add regulator support to
 CS4270 codec driver
Date: Fri, 27 Nov 2009 13:32:25 +0000
Message-ID: <20091127133225.GB17711@rakim.wolfsonmicro.main>
References: <1259159787-21876-1-git-send-email-daniel@caiaq.de>
	<20091125150139.GC636@rakim.wolfsonmicro.main>
	<20091125152052.GM29442@buzzloop.caiaq.de>
	<20091125153804.GA12750@rakim.wolfsonmicro.main>
	<20091126154807.GI14091@buzzloop.caiaq.de>
	<20091126160351.GB10674@rakim.wolfsonmicro.main>
	<20091126174245.GJ14091@buzzloop.caiaq.de>
	<20091127112550.GA29821@rakim.wolfsonmicro.main>
	<20091127124139.GR14091@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7A93524367
	for <alsa-devel@alsa-project.org>; Fri, 27 Nov 2009 14:32:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20091127124139.GR14091@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>, Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 27, 2009 at 01:41:39PM +0100, Daniel Mack wrote:

> Ok, agreed. Next try below.

Looks good to me, though I suspect Timur will want error checking for
those enable calls - Timur?
