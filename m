From: Koro Chen <koro.chen@mediatek.com>
Subject: Re: [RFC PATCH (alsa-lib)] pcm: Modify check condition
 in snd_pcm_sw_params_set_avail_min
Date: Fri, 4 Sep 2015 10:49:35 +0800
Message-ID: <1441334975.32609.30.camel@mtksdaap41>
References: <1441250454-38271-1-git-send-email-koro.chen@mediatek.com>
 <s5hfv2wvv35.wl-tiwai@suse.de> <1441266346.32609.18.camel@mtksdaap41>
 <20150903093810.GE5313@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw01.mediatek.com (unknown [210.61.82.183])
 by alsa0.perex.cz (Postfix) with ESMTP id B79A12606E0
 for <alsa-devel@alsa-project.org>; Fri,  4 Sep 2015 04:49:39 +0200 (CEST)
In-Reply-To: <20150903093810.GE5313@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org, lgirdwood@gmail.com, srv_heupstream@mediatek.com
List-Id: alsa-devel@alsa-project.org

On Thu, 2015-09-03 at 10:38 +0100, Mark Brown wrote:
> On Thu, Sep 03, 2015 at 03:45:46PM +0800, Koro Chen wrote:
> > On Thu, 2015-09-03 at 09:08 +0200, Takashi Iwai wrote:
> 
> > > How this happens?  The period size is the size where irq (or wakeup)
> > > wakes up for read/write.  Why the driver wakes up even if there is no
> > > enough data?
> 
> > Yes it is odd to what we would normally expect. Due to our HW design,
> > when irq comes, audio HW actually has collected a full period of data,
> > but there is a buffer between the audio HW and memory, so at that moment
> > some samples are still in the buffer, not on the memory. Add a small
> > delay between triggering capture HW and enabling IRQ can also fix this,
> > although I think changing the avail_min should be better. 
> 
> This does sound like something that should be handled in the kernel -
> one thing we should be doing is providing a uniform interface to
> userspace.
Hmm, I thought those param settings are used to handle different HW
behavior like my case, but maybe I am wrong. It is more important to let
a single driver to be used under many different cases. I will find
solution in my driver, thank you!
