From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC][PATCH 20/26] alsa: ASoC: Add JZ4740 codec
	driver
Date: Fri, 4 Jun 2010 00:59:38 +0100
Message-ID: <BBE59890-DD9C-4B62-AB74-87764381D38E@opensource.wolfsonmicro.com>
References: <1275505397-16758-1-git-send-email-lars@metafoo.de>
	<1275505950-17334-4-git-send-email-lars@metafoo.de>
	<20100603174953.GH2762@rakim.wolfsonmicro.main>
	<4C084155.5010503@metafoo.de>
	(sfid-20100604_005758_018873_5A725743)
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8A00F2447A
	for <alsa-devel@alsa-project.org>;
	Fri,  4 Jun 2010 01:59:40 +0200 (CEST)
In-Reply-To: <4C084155.5010503@metafoo.de>
	(sfid-20100604_005758_018873_5A725743)
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
Cc: linux-mips@linux-mips.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 4 Jun 2010, at 00:57, Lars-Peter Clausen wrote:

> Mark Brown wrote:
> Uhm, actually this code path is taken when switching from _OFF to
> another state. If it is guaranteed that _OFF is always followed by a
> certain other state I could put the reset code in its part of the switch
> statement.

The only possible transitions are OFF <-> STANDBY <-> PREPARE <-> ON
