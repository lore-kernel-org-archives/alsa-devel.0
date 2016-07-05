From: Garlic Tseng <garlic.tseng@mediatek.com>
Subject: Re: [PATCH 3/4] ASoC: mediatek: add BT implementation
Date: Tue, 5 Jul 2016 16:59:15 +0800
Message-ID: <1467709155.10413.7.camel@mtksdaap41>
References: <1467629788-14411-1-git-send-email-garlic.tseng@mediatek.com>
 <1467629788-14411-4-git-send-email-garlic.tseng@mediatek.com>
 <20160704144406.GH6247@sirena.org.uk> <1467683533.4212.16.camel@mtksdaap41>
 <20160705081232.GL6247@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw01.mediatek.com (unknown [210.61.82.183])
 by alsa0.perex.cz (Postfix) with ESMTP id DE069265325
 for <alsa-devel@alsa-project.org>; Tue,  5 Jul 2016 10:59:22 +0200 (CEST)
In-Reply-To: <20160705081232.GL6247@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, ir.lian@mediatek.com, srv_heupstream@mediatek.com, tiwai@suse.de, linux-kernel@vger.kernel.org, koro.chen@mediatek.com, linux-mediatek@lists.infradead.org, PC.Liao@mediatek.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2016-07-05 at 10:12 +0200, Mark Brown wrote:
> On Tue, Jul 05, 2016 at 09:52:13AM +0800, Garlic Tseng wrote:
> > On Mon, 2016-07-04 at 16:44 +0200, Mark Brown wrote:
> 
> > > We really shouldn't be writing the registers or other internal data of
> > > the device.  Instead we should be getting the driver for the relevant
> > > hardware component to do it.  If we just write to registers that makes
> > > the interoperation with the real driver for the device more fragile than
> > > it should be, people might update the main driver without noticing the
> > > external driver.
> 
> > The AUDIO_TOP_CON4 is a reg of the ASoC hw module. All the registers
> > which are set in the btmrg operator belong to ASoC hardware. The reg
> > writing you mention above is to power up the MRG interface in the ASoC
> > module.
> 
> The problem is that this is the machine driver, not a driver for the
> chip that's being controlled.

The patch is for platform driver "mt2701-afe-pcm.c", which contorls the
ASoC module, not for machine driver. Maybe the patch sequence is
confusing and I'm sorry about that. Or did I misunderstand your comment?
