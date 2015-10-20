From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 4/4] ALSA: pcm_dmaengine: Properly synchronize DMA on
 shutdown
Date: Tue, 20 Oct 2015 15:01:27 +0200
Message-ID: <56263B27.9000106@metafoo.de>
References: <1445334391-12272-1-git-send-email-lars@metafoo.de>	<1445334391-12272-5-git-send-email-lars@metafoo.de> <s5h37x5g56w.wl-tiwai@suse.de> <56262810.3040201@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56262810.3040201@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Russell King <rmk+kernel@arm.linux.org.uk>, Shengjiu Wang <shengjiu.wang@freescale.com>, Dan Williams <dan.j.williams@intel.com>, Jonah Petri <jpetri@izotope.com>, Matt Campbell <mcampbell@izotope.com>, Qiao Zhou <zhouqiao@marvell.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

[...]
> I've tested this series with xrun injection and some modifications to the
> DMA driver to always trigger the race condition when the stream is stopped.
> And I've not seen any issues after the transfer re-started. (There is a
> dead-lock condition though but that does not seem to be related to this series)

Turns out that was a bug in the DMA driver that caused
snd_pcm_period_elapsed() to be called on the TRIGGER_START path. So the ALSA
side seems to be good.
