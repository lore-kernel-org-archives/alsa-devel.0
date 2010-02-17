From: jassi brar <jassisinghbrar@gmail.com>
Subject: Separate dma driver for cpu_dais
Date: Wed, 17 Feb 2010 11:39:47 +0900
Message-ID: <1b68c6791002161839q705df04cmeda046736948c614@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 8E924103842
	for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2010 03:39:51 +0100 (CET)
Received: by vws18 with SMTP id 18so469815vws.38
	for <alsa-devel@alsa-project.org>; Tue, 16 Feb 2010 18:39:50 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,
  The query concerns ASOC.

Currently we have one platform per card.
What if my card has two dai_links with each cpu_dai fed data
with different mechanism(one with system dma controller and
the other with a dma dedicated to the Audio block). The cpu_dai's
are tightly coupled and I don't wanna have separate socdev's for them.

Presently, I define a dma_id flag in snd_soc_dai, make the snd_soc_card
point to a 'wrapper/muxed' platform driver that checks the dma_id flag and
calls the relevant platform's callbacks. Of course, each cpu_dai initializes
the dma_id to a unique value that corresponds to it's real dma mechanism.

What approach/changes would you suggest I take, so that someday I could
submit the implementation for mainline inclusion?

(For those curious to have a reference - I am talking about Samsung's SoCs
<http://dev.odroid.com/wiki/odroid/pds/HardwareInformation/S5PC100_UM_REV101.pdf
refer to figures on page-1635 & 1637>
that have I2S controllers with h/w mixing capability and where
'secondary fifo' can be
fed with I2S internal DMA controller with dedicated h/w ring buffer)

Thanks.
