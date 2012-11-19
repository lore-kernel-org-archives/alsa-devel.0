From: Julian Wollrath <jwollrath@web.de>
Subject: Re: Hung task with trace after resume on kernel
 v3.7-rc6
Date: Mon, 19 Nov 2012 16:00:20 +0100
Message-ID: <20121119160020.78c84910@ilfaris>
References: <20121118161803.58ca707c@ilfaris>
 <CAEUnVG7bFqrzfVDG5-2uL6OHGEJR-Jf35mx-OLiTx-K84P+dmA@mail.gmail.com>
 <s5h3906gcfe.wl%tiwai@suse.de> <20121119115632.0c41386f@ilfaris>
 <s5hmwydg7mq.wl%tiwai@suse.de> <20121119131504.71f3151b@ilfaris>
 <s5h8v9xaha1.wl%tiwai@suse.de> <20121119145645.30c681e5@ilfaris>
 <20121119151845.1886ed58@ilfaris> <s5ha9ud7j5j.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by alsa0.perex.cz (Postfix) with ESMTP id CD987265162
 for <alsa-devel@alsa-project.org>; Mon, 19 Nov 2012 16:00:33 +0100 (CET)
Received: from ilfaris ([134.76.63.1]) by smtp.web.de (mrweb102) with ESMTPSA
 (Nemesis) id 0MgwdY-1TwPZP3WKG-00MESu for
 <alsa-devel@alsa-project.org>; Mon, 19 Nov 2012 16:00:23 +0100
In-Reply-To: <s5ha9ud7j5j.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> Do you have CONFIG_PM_RUNTIME=y?  If yes, any difference when turn it
> off?
I have CONFIG_PM_RUNTIME=y, I will try it without it.

> Also, apply the patch below so that we can see which device is
> actually stalling.
The stalling device is the following:
[   86.442978] hda-intel: 0000:00:14.2: spurious response 0x0:0x0, last
cmd=0x1970700

00:14.2 Audio device [0403]: Advanced Micro Devices [AMD] nee ATI SBx00
Azalia (Intel HDA) [1002:4383] (rev 40)


With best regards,
Julian
