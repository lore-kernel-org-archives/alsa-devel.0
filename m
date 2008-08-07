From: Timur Tabi <timur@freescale.com>
Subject: Why is substream->pcm->dev == NULL?
Date: Thu, 07 Aug 2008 13:51:55 -0500
Message-ID: <489B444B.9010202@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	by alsa0.perex.cz (Postfix) with ESMTP id EE5B324957
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Aug 2008 20:52:01 +0200 (CEST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m77IpuNO014434
	for <alsa-devel@alsa-project.org>; Thu, 7 Aug 2008 11:51:56 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m77IptSr007432
	for <alsa-devel@alsa-project.org>; Thu, 7 Aug 2008 13:51:55 -0500 (CDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

In my _pointer callback function, I have this:

printk(KERN_INFO "%s:%u substream->pcm->dev=%p, substream->pcm->card->dev=%p\n",
__func__, __LINE__, substream->pcm->dev, substream->pcm->card->dev);

During playback, it displays this:

fsl_dma_pointer:698 substream->pcm->dev=00000000, substream->pcm->card->dev=dfa50a08

Why is substream->pcm->dev == NULL?  What's the point of having this field if
you're not going to use it?

-- 
Timur Tabi
Linux kernel developer at Freescale
