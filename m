From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] ASoC: cs4270: Check that we can enable
 regulators on resume
Date: Mon, 19 Mar 2012 13:38:20 -0500
Message-ID: <4F677D1C.1040901@freescale.com>
References: <1332173777-9786-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<4F6770F0.70002@freescale.com>
	<20120319183713.GD12384@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
	by alsa0.perex.cz (Postfix) with ESMTP id 4B27E24154
	for <alsa-devel@alsa-project.org>; Mon, 19 Mar 2012 19:38:32 +0100 (CET)
In-Reply-To: <20120319183713.GD12384@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
>> > When I add 'int ret;', it compiles and works.  Note, however, that I have
>> > no regular support on this board, so I don't know what I'm really testing.

> I'll assume that's an ack for the fixed version, BTW...

Yes.

-- 
Timur Tabi
Linux kernel developer at Freescale
