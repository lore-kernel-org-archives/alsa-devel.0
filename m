From: Daniel Mack <daniel@caiaq.org>
Subject: pxassp dma pointer not moving
Date: Sun, 22 Feb 2009 22:47:21 +0100
Message-ID: <20090222214721.GB5893@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id CFA3E24498
	for <alsa-devel@alsa-project.org>; Sun, 22 Feb 2009 22:47:23 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by buzzloop.caiaq.de (Postfix) with ESMTP id 9ECBE7F404F
	for <alsa-devel@alsa-project.org>; Sun, 22 Feb 2009 22:47:23 +0100 (CET)
Received: from buzzloop.caiaq.de ([127.0.0.1])
	by localhost (buzzloop.caiaq.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lbVA6VPOg0Aw for <alsa-devel@alsa-project.org>;
	Sun, 22 Feb 2009 22:47:21 +0100 (CET)
Content-Disposition: inline
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

I'm currently implementing support for a board based on a PXA300 with an
I2S codec (CS4270) next to it. Things do work in general, including the
setup of the SSP engine and clocks, and when using the OSS compat layer,
I can see data on the bus. With the native ALSA API, however, the DMA
pointer does not move forward but is stuck at position 8. ALSA's core
calls pxa2xx_pcm_pointer() a couple of times and eventually gives up on
it. Unfortunately, I don't have a Zylonite board for cross-check; could
anyone verify that things are not currently broken in a general way?

My code base is up-to-date to sound-2.6.git/for-2.6.30.

Thanks and best regards,
Daniel
