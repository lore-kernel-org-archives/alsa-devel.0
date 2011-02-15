From: ylin@mail.com
Subject: Re: Channel swapping issue on TI OMAP3/TWL4030
Date: Tue, 15 Feb 2011 11:28:16 -0500
Message-ID: <8CD9B447BF02D2F-DE8-B4B6@web-mmc-d01.sysops.aol.com>
References: <8CD98E75F0E83E2-63C-14642@web-mmc-m05.sysops.aol.com><CF32F28EDF8D20468EEDCBE4975DA0274A46DB@008-AM1MPN1-027.mgdnok.nokia.com><8CD9A87EF4FB765-1218-647@web-mmc-m03.sysops.aol.com>
	<20110215102833.0727ef53.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from imr-da01.mx.aol.com (imr-da01.mx.aol.com [205.188.105.143])
	by alsa0.perex.cz (Postfix) with ESMTP id C7594103803
	for <alsa-devel@alsa-project.org>; Tue, 15 Feb 2011 17:28:39 +0100 (CET)
Received: from imo-ma03.mx.aol.com (imo-ma03.mx.aol.com [64.12.78.138])
	by imr-da01.mx.aol.com (8.14.1/8.14.1) with ESMTP id p1FGSU2e023258
	for <alsa-devel@alsa-project.org>; Tue, 15 Feb 2011 11:28:30 -0500
Received: from ylin@mail.com
	by imo-ma03.mx.aol.com  (mail_out_v42.9.) id 5.bb8.7f367bb4 (44671)
	for <alsa-devel@alsa-project.org>; Tue, 15 Feb 2011 11:28:28 -0500 (EST)
In-Reply-To: <20110215102833.0727ef53.jhnikula@gmail.com>
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


> >
> > We are using 2.6.32.  The source of the recording is using Analog 
Mic.
> > The Left Main mic is always on, and Right Sub mic can be either on 
or
> > off when this occurs.  We are not using AUX or digimic.
> >
> I was thinking is this 2.6.32 derived completely from Vanilla version 
or
> only partially? I think I've seen some case where the kernel was 
forked
> earlier and got upgraded to the upstream version only partially.
>
> Even Peter told that those channel switching patches in 2.6.32 should
> fix the playback case only, worth to check just in case are those 
fixes
> in your kernel tree.

Those fixes are not in our kernel, I will apply them and re-test.

Thanks,
Ying
