From: Tim Blechmann <tim@klingt.org>
Subject: Re: [PATCH 2/2] alsa: lx6464es - fix device
	communication	via command bus
Date: Tue, 22 Nov 2011 11:51:07 +0100
Message-ID: <2525718.rPtMENBDXu@moka>
References: <8a6917141177b8021a02eb0a9d0c9243cf61e779.1321956887.git.tim@klingt.org>
	<b07271b88a71db5a4949fff6a9372f9cd0850c17.1321956887.git.tim@klingt.org>
	<s5hmxboigzs.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from klingt.org (mail.klingt.org [86.59.21.178])
	by alsa0.perex.cz (Postfix) with ESMTP id C483E2460A
	for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2011 11:51:10 +0100 (CET)
In-Reply-To: <s5hmxboigzs.wl%tiwai@suse.de>
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

> > commit 6175ddf06b6172046a329e3abfd9c901a43efd2e optimized the mem*io
> > functions that have been used to send commands to the device. these
> > optimizations somehow corrupted the communication with the lx6464es,
> > that resulted the device to be unusable with kernels after 2.6.33.
> > 
> > this patch emulates the memcpy_*_io functions via a loop to avoid these
> > problems.
> > 
> > Signed-off-by: Tim Blechmann <tim@klingt.org>
> > LKML-Reference: <4ECB5257.4040600@ladisch.de>
> 
> This should be applied to stable kernel post 2.6.34, right?

yes please.

thanks, tim
