From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [PATCH 3/3] ASoC: pxa-ssp.c handle the I2S and
	LEFT_J cases.
Date: Wed, 17 Jun 2009 11:03:28 +0800
Message-ID: <4A385D00.4060601@gmail.com>
References: <1245113136.24109.562.camel@brutus>
	<20090616213635.GA26502@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.169])
	by alsa0.perex.cz (Postfix) with ESMTP id 22F4D24415
	for <alsa-devel@alsa-project.org>;
	Wed, 17 Jun 2009 05:03:48 +0200 (CEST)
Received: by wf-out-1314.google.com with SMTP id 24so22546wfg.23
	for <alsa-devel@alsa-project.org>; Tue, 16 Jun 2009 20:03:47 -0700 (PDT)
In-Reply-To: <20090616213635.GA26502@sirena.org.uk>
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
Cc: Paul Shen <boshen9@gmail.com>, alsa-devel <alsa-devel@alsa-project.org>, Philipp Zabel <philipp.zabel@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, Daniel Ribeiro <drwyrm@gmail.com>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Mon, Jun 15, 2009 at 09:45:35PM -0300, Daniel Ribeiro wrote:
> 
>>  arch/arm/mach-pxa/include/mach/regs-ssp.h |   14 ++--
> 
> Eric, are you happy for this change to go via ALSA?  It seems reasonable
> enough.
> 
> I'm happy with these changes from a code review point of view, though
> as well as Eric's ack I'll do some more testing before I apply them.
> Thanks a lot for doing this work.

OK, I'll take some time to verify that on PXA3xx.
