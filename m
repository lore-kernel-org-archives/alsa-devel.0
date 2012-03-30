From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] ASoC: fsl: enable ssi clock in probe
	function
Date: Fri, 30 Mar 2012 08:19:44 -0500
Message-ID: <4F75B2F0.6090104@freescale.com>
References: <1332989621-5211-1-git-send-email-shawn.guo@linaro.org>
	<20120329112949.GM3668@opensource.wolfsonmicro.com>
	<4F748751.3020300@freescale.com>
	<20120329160916.GG19506@S2101-09.ap.freescale.net>
	<4F748C8E.1010702@freescale.com>
	<20120330055543.GH19506@S2101-09.ap.freescale.net>
	<4F75AF20.6080009@freescale.com>
	<CAAQ0ZWR5ws7od92bOcLn-kDdbSPAVRDQwdVu-90tRfDSH_49KA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tx2outboundpool.messaging.microsoft.com
	(tx2ehsobe001.messaging.microsoft.com [65.55.88.11])
	by alsa0.perex.cz (Postfix) with ESMTP id 18A3C104492
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Mar 2012 15:19:52 +0200 (CEST)
In-Reply-To: <CAAQ0ZWR5ws7od92bOcLn-kDdbSPAVRDQwdVu-90tRfDSH_49KA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Shawn Guo wrote:
>> > You'll need to get Kumar Gala's ACK on that one, but if only the 8610 is
>> > broken, then I don't think he'll like it.
>> >
> It's only about building in arch/powerpc/kernel/clock.c, which is a
> pretty dummy clk API and does not take much cost.

Like I said, it needs Kumar's review.  You should ping him on it.  He may
just want the 8610 fixed.

-- 
Timur Tabi
Linux kernel developer at Freescale
