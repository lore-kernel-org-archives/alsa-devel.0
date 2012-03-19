From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] ASoC: cs4270: Check that we can enable
 regulators on resume
Date: Mon, 19 Mar 2012 12:46:24 -0500
Message-ID: <4F6770F0.70002@freescale.com>
References: <1332173777-9786-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
	by alsa0.perex.cz (Postfix) with ESMTP id 03139103AFD
	for <alsa-devel@alsa-project.org>; Mon, 19 Mar 2012 18:46:33 +0100 (CET)
In-Reply-To: <1332173777-9786-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
> It's possible that the regulator enable will fail and if it does we may
> as well just give up with trying to bring the rest of the device up and
> report the original error.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---

  CC      sound/soc/codecs/cs4270.o
/home/b04825/git/alsa.guts/sound/soc/codecs/cs4270.c: In function
'cs4270_soc_resume':
/home/b04825/git/alsa.guts/sound/soc/codecs/cs4270.c:605:2: error: 'ret'
undeclared (first use in this function)
/home/b04825/git/alsa.guts/sound/soc/codecs/cs4270.c:605:2: note: each
undeclared identifier is reported only once for each function it appears in

When I add 'int ret;', it compiles and works.  Note, however, that I have
no regular support on this board, so I don't know what I'm really testing.


On a side note, 'reg' should be an 'unsigned int', not an 'int'.

-- 
Timur Tabi
Linux kernel developer at Freescale
