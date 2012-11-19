From: Julian Wollrath <jwollrath@web.de>
Subject: Re: Hung task with trace after resume on kernel
 v3.7-rc6
Date: Mon, 19 Nov 2012 18:51:12 +0100
Message-ID: <20121119185112.33707654@ilfaris>
References: <20121118161803.58ca707c@ilfaris>
 <CAEUnVG7bFqrzfVDG5-2uL6OHGEJR-Jf35mx-OLiTx-K84P+dmA@mail.gmail.com>
 <s5h3906gcfe.wl%tiwai@suse.de> <20121119115632.0c41386f@ilfaris>
 <s5hmwydg7mq.wl%tiwai@suse.de> <20121119131504.71f3151b@ilfaris>
 <s5h8v9xaha1.wl%tiwai@suse.de> <20121119145645.30c681e5@ilfaris>
 <20121119151845.1886ed58@ilfaris> <s5ha9ud7j5j.wl%tiwai@suse.de>
 <20121119160020.78c84910@ilfaris> <20121119170900.7093ca40@ilfaris>
 <s5h1ufp7ejj.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by alsa0.perex.cz (Postfix) with ESMTP id E000B261742
 for <alsa-devel@alsa-project.org>; Mon, 19 Nov 2012 18:51:23 +0100 (CET)
In-Reply-To: <s5h1ufp7ejj.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> > So, with CONFIG_PM_RUNTIME=n I get no spurious response messages.
> 
> OK, it's a good sign.  What happens if you enable CONFIG_PM_RUNTIME
> again but set the option power_save_controller=0 for snd-hda-intel
> module?
> 
> Or, try the patch below.
With the patch there are no spurious response messages anymore.


With best regards,
Julian
