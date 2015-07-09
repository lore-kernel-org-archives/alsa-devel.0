From: Koro Chen <koro.chen@mediatek.com>
Subject: Re: [PATCH 1/2] ASoC: rt5645: Fix missing free_irq
Date: Thu, 9 Jul 2015 09:48:13 +0800
Message-ID: <1436406493.15417.4.camel@mtksdaap41>
References: <1436343951-3482-1-git-send-email-koro.chen@mediatek.com>
 <20150708111437.GQ11162@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by alsa0.perex.cz (Postfix) with ESMTP id 7E23D265B54
 for <alsa-devel@alsa-project.org>; Thu,  9 Jul 2015 03:48:29 +0200 (CEST)
In-Reply-To: <20150708111437.GQ11162@sirena.org.uk>
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, srv_heupstream@mediatek.com, tiwai@suse.de, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, bardliao@realtek.com
List-Id: alsa-devel@alsa-project.org

On Wed, 2015-07-08 at 12:14 +0100, Mark Brown wrote:
> On Wed, Jul 08, 2015 at 04:25:50PM +0800, Koro Chen wrote:
> 
> > The driver does not free irq if snd_soc_register_codec fails.
> > It does not return error when request irq failed, either.
> > Fix this by using devm_request_threaded_irq(), and returns when error.
> 
> Unfortunately this isn't safe...
> 
> > -	if (i2c->irq)
> > -		free_irq(i2c->irq, rt5645);
> > -
> >  	cancel_delayed_work_sync(&rt5645->jack_detect_work);
> 
> This work item is queued up by the interrupt handler so we need to
> unregister the interrupt before we cancel any pending work otherwise
> it's possible that the interrupt may fire after we cancelled the work.
Thank you for seeing this, I didn't notice the delayed work.
Do you think I should use devm_request_threaded_irq(), and change
free_irq to devm_free_irq in remove? Or I should keep the original
request_thread_irq(), and just add a free_irq() during probe failed?
 
