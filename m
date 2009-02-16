From: York Sun <yorksun@freescale.com>
Subject: dma buffer format
Date: Mon, 16 Feb 2009 16:21:59 -0600
Message-ID: <1234822919.23239.20.camel@oslab-l1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id E6EFF10383D
	for <alsa-devel@alsa-project.org>; Mon, 16 Feb 2009 23:22:03 +0100 (CET)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n1GMM1Tm010430
	for <alsa-devel@alsa-project.org>; Mon, 16 Feb 2009 15:22:01 -0700 (MST)
Received: from az33exm22.fsl.freescale.net (az33exm22.am.freescale.net
	[10.64.32.10])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id n1GMM1Gb015684
	for <alsa-devel@alsa-project.org>; Mon, 16 Feb 2009 16:22:01 -0600 (CST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi,

I am now working on a surround sound driver for the first time. I am
confused by the packed format of dma buffer. If the channel number is 6,
is the buffer filled with data as

front left, front right, rear left, rear right, center, LFE

or

front left, rear left, center, front right, rear left, LFE?

Thanks,

York
