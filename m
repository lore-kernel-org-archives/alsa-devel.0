From: Dong Aisheng-B29396 <B29396@freescale.com>
Subject: Re: How to configure SGTL5000 ASoC as master?
Date: Tue, 10 Jan 2012 06:43:35 +0000
Message-ID: <7FE21149F4667147B645348EC605788508AA69@039-SN2MPN1-013.039d.mgd.msft.net>
References: <4F0BD878.40508@bluegiga.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from TX2EHSOBE009.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) by alsa0.perex.cz (Postfix) with ESMTP id 361E21038AD
	for <alsa-devel@alsa-project.org>; Tue, 10 Jan 2012 07:43:42 +0100 (CET)
In-Reply-To: <4F0BD878.40508@bluegiga.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lauri Hintsala <lauri.hintsala@bluegiga.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Lauri Hintsala [mailto:lauri.hintsala@bluegiga.com]
> Sent: Tuesday, January 10, 2012 2:20 PM
> To: Dong Aisheng-B29396
> Cc: alsa-devel@alsa-project.org; linux-arm-kernel@lists.infradead.org
> Subject: MXS: How to configure SGTL5000 ASoC as master?
> Importance: High
> 
> Hi,
> 
> SGTL5000 ASoC is hard coded to be slave in sound/soc/mxs/mxs-sgtl5000.c.
Yes, Saif TX can only work on master mode so we simply only support master mode
for both saif rx/tx.

> In our HW design mclk of ASoC is sourced from external oscillator.
> Because of our design ASoC should be configured as master. In that case master
IIRC using external mclk does not mean sgtl5000 has to be master.
And as I said above, saif tx can only be master, that's a hw limitation.

> clock of SAIF should be disabled.
> 
You can leave it there without using it.

> Is there any plan to have configuration for mxs-sgtl5000 driver? What is
> preferred way to solve this issue?
> 
We can extend the mxs-sgtl5000 driver to support external mclk.
(but sgtl5000 as master mode is not supported).
I did not have time to do it recently, also I did not have such board.
If somebody wants to do it I will be happy to review.

> BR,
> Lauri Hintsala
> 
> p.s. I resent this mail because I wasn't subscriber of alsa-devel mailing list.

Regards
Dong Aisheng
