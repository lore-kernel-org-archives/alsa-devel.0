From: Julian Wollrath <jwollrath@web.de>
Subject: Re: Hung task with trace after resume on kernel
 v3.7-rc6
Date: Mon, 19 Nov 2012 14:56:45 +0100
Message-ID: <20121119145645.30c681e5@ilfaris>
References: <20121118161803.58ca707c@ilfaris>
 <CAEUnVG7bFqrzfVDG5-2uL6OHGEJR-Jf35mx-OLiTx-K84P+dmA@mail.gmail.com>
 <s5h3906gcfe.wl%tiwai@suse.de> <20121119115632.0c41386f@ilfaris>
 <s5hmwydg7mq.wl%tiwai@suse.de> <20121119131504.71f3151b@ilfaris>
 <s5h8v9xaha1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by alsa0.perex.cz (Postfix) with ESMTP id E024E2616D7
 for <alsa-devel@alsa-project.org>; Mon, 19 Nov 2012 14:56:52 +0100 (CET)
In-Reply-To: <s5h8v9xaha1.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Dylan Reid <dgreid@chromium.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> > > Could you try the patch below instead?
> > The patch did not apply against 3.7-rc6 but the patch below applied
> > and let the trace disappear.
> 
> OK, then at least it can be added as a workaround.
> 
> But the spurious response still appears, right?
Yes, the spurious response still appears.
 
> Hm, then something screwed up the communication...
> 
> At which moment do you see such a message?  In other words, how to
> trigger the bug?
I suspend my system to ram or to disk. Then I resume it, everthing
comes up again and then, aprrox 4s after the resume was initiated, the
spurious response messages hit the dmesg for approx. 0.07s as you can
see in my first message. Hopefully this answer the question.


With best regards,
Julian
