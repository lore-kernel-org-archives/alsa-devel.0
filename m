From: Koro Chen <koro.chen@mediatek.com>
Subject: Re: [PATCH 1/2] ASoC: rt5645: Fix missing free_irq
Date: Fri, 10 Jul 2015 22:43:21 +0800
Message-ID: <1436539401.6170.2.camel@mtksdaap41>
References: <1436343951-3482-1-git-send-email-koro.chen@mediatek.com>
	 <20150708111437.GQ11162@sirena.org.uk>
	 <1436406493.15417.4.camel@mtksdaap41>
	 <20150709111010.GL11162@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150709111010.GL11162@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: perex@perex.cz, tiwai@suse.de, lgirdwood@gmail.com, srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, bardliao@realtek.com, oder_chiou@realtek.com
List-Id: alsa-devel@alsa-project.org

On Thu, 2015-07-09 at 12:10 +0100, Mark Brown wrote:
> On Thu, Jul 09, 2015 at 09:48:13AM +0800, Koro Chen wrote:
> 
> > Do you think I should use devm_request_threaded_irq(), and change
> > free_irq to devm_free_irq in remove? Or I should keep the original
> > request_thread_irq(), and just add a free_irq() during probe failed?
> 
> I'd just keep request_threaded_irq() and use free_irq().
OK, thanks, I will send a new patch.
And about the patch 2/2 regulator support, is there any problem I should
also fix?
 
