From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH v2 4/6] ARM: S5P: Add EPLL rate change warning
Date: Wed, 13 Oct 2010 17:21:48 +0900
Message-ID: <002801cb6aaf$b19368c0$14ba3a40$%kim@samsung.com>
References: <1286882399-27595-1-git-send-email-sw.youn@samsung.com>
 <1286883983-27790-1-git-send-email-sw.youn@samsung.com>
 <002301cb6aac$12a05e10$37e11a30$%kim@samsung.com>
 <20101013080902.GA6424@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <20101013080902.GA6424@rakim.wolfsonmicro.main>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Mark Brown' <broonie@opensource.wolfsonmicro.com>
Cc: 'Seungwhan Youn' <sw.youn@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, alsa-devel@alsa-project.org, ben-linux@fluff.org, lrg@slimlogic.co.uk, jassi.brar@samsung.com
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> 
> On Wed, Oct 13, 2010 at 04:55:55PM +0900, Kukjin Kim wrote:
> > Seungwhan Youn wrote:
> 
> > > This patch adds warning about changing EPLL rate to notice that other
> > > driver that controls H/W, which is using EPLL, will has unknown
effects
> > > by this EPLL rate change.
> 
> > > +	printk(KERN_WARNING "EPLL Rate changes from %lu to %lu\n",
> > > +			clk->rate, rate);
> 
> > Do we really need KERN_WARNING here?
> > How about just KERN_INFO?...In my opinion, to change EPLL value seems to
be
> > nearer 'information' message more than 'warning'.
> 
> Personally I don't think it really makes much odds so long as the
> message is displayed on the console by default.

Hmm...yeah I mean just EPLL is used only in the audio and SPI now. However
we don't know which driver will use it later. And as you said, need to show
it. Ok...will apply.

Mr. Youn, no need to re-work this.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
