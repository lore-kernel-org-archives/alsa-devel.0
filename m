From: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v8 1/5] video: rmk's HDMI notification prototype
Date: Thu, 11 Aug 2016 16:40:46 +0200
Message-ID: <1470926446.2493.48.camel@pengutronix.de>
References: <1470907227-899-1-git-send-email-p.zabel@pengutronix.de>
 <1470907227-899-2-git-send-email-p.zabel@pengutronix.de>
 <20160811101817.GT1041@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20160811101817.GT1041-l+eeeJia6m9URfEZ8mYm6t73F7V6hmMc@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Cc: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>, Koro Chen <koro.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hans Verkuil <hans.verkuil-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, PC Liao <pc.liao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Cawa Cheng <cawa.cheng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Am Donnerstag, den 11.08.2016, 11:18 +0100 schrieb Russell King - ARM
Linux:
> On Thu, Aug 11, 2016 at 11:20:23AM +0200, Philipp Zabel wrote:
> > This is Russell's HDMI notification prototype [1], currently waiting
> > for the HDMI CEC situation to resolve.
> > 
> > The use case for the notifications on MediaTek MT8173 is to let the
> > (dis)connection notifications control an ALSA jack object.
> > 
> > No Signed-off-by since this is not my code, and still up for discussion.
> 
> Well, I have two drivers (both CEC drivers) which use this, and I still
> don't see any alternative solution to the problem that this patch is
> solving.
> 
> I don't think it's really a CEC problem - there's three bits to HDMI
> that need to track each others state - the video, audio and CEC paths.
> 
> While the video and audio paths may be one block, the CEC path may
> actually be a separate block.  For example, the TDA998x devices
> integrate the HDMI video/audio block along with a TDA9950 on the
> same device - the TDA9950 being a CEC engine.  The TDA9950 is also
> available as a separate device, and even when integrated with HDMI,
> it appears on the I2C bus as a seperate device.
> 
> So, splitting the functionality is definitely the right model.  We
> just need some way to keep each blocks state in sync.  What's provided
> in this patch is the simple solution which seems to work for the use
> cases we have.

Yes, it works fine for the MT8173 use case.

> I think, in light of no comments against this approach, and no other
> approach being available, that this is good enough justification to
> merge this, especially as it is blocking other work.
> 
> So... if people want to give me reviewed-by/acked-bys, I'll add them
> to my patch, and I'll post that and the dw-hdmi and tda9950 CEC drivers.

Acked-by: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

regards
Philipp
