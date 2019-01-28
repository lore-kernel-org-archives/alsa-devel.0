From: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
Subject: Re: [RFC PATCH 1/2] ASoC: mediatek: add btcvsd driver
Date: Mon, 28 Jan 2019 16:22:18 +0800
Message-ID: <1548663738.11945.19.camel@mtksdaap41>
References: <20190124085842.24073-1-kaichieh.chuang@mediatek.com>
 <20190124085842.24073-2-kaichieh.chuang@mediatek.com>
 <20190124192502.GJ5641@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by alsa0.perex.cz (Postfix) with ESMTP id E09A3267456
 for <alsa-devel@alsa-project.org>; Mon, 28 Jan 2019 09:22:29 +0100 (CET)
In-Reply-To: <20190124192502.GJ5641@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, garlic.tseng@mediatek.com, linux-mediatek@lists.infradead.org, kaichieh.chuang@mediatek.com
List-Id: alsa-devel@alsa-project.org


On Thu, 2019-01-24 at 19:25 +0000, Mark Brown wrote:
> On Thu, Jan 24, 2019 at 04:58:41PM +0800, KaiChieh Chuang wrote:
> 
> > The driver function for transferring/receiving
> > BT encoded data to/from BT hardware.
> 
> It's really nice to see someone submitting a driver for actual radio
> hardware, this is great to see!  
> 
> The driver looks pretty good, I've got a few quite minor comments below
> but the main one is that given that this doesn't have any DAIs or DAPM
> it looks like it doesn't integrate with the rest of the sound card much
> so perhaps it could just be a free standing ALSA driver?  If there's
> inputs that let you link it to the rest of the sound card which will be
> added later then that's obviously a good reason to keep it in ASoC (I'd
> not be surprised if there were) but otherwise I'm not sure what
> advantage ASoC brings you.

Our btcvsd radio chip is tightly bound with baseband SoC,
Currently, the mtk-btcvsd resides in mtk afe sound cards,
such as mt6797-mt6351 sound card.

"free standing ALSA driver" i'm not quite sure what you mean by this,
do you mean something like usb sound card (sound/usb/)?
Unlike normal BT SCO chip is transfer with PCM format,
we transfer encoded data directly. It's a MTK hardware-proprietary,
i'm not sure a standalone ALSA driver can do any good here.
Thats why I decided to put it under sound/soc/mediatek/.


> There's quite a few of these dev_info() calls which look like they might
> be a bit noisy and could perhaps be dev_dbg() instead.

I'll cut down the log in next patch

> Some of these enums (all of them except the narrow/wide band one) should
> be simple number controls ending with Switch as covered in
> control-names.rst, this helps UIs display them better.

I'll update this in next patch

> > +	SND_SOC_BYTES_TLV("btcvsd_tx_timestamp",
> > +			  sizeof(struct mtk_btcvsd_snd_time_buffer_info),
> > +			  btcvsd_tx_timestamp_get, NULL),
> 
> There's an ALSA timestamping API - see commit 4eeaaeaea1ce (ALSA: core:
> add hooks for audio timestamps) and related commits.  I don't know if
> that applies here and might be a better fit or not?

We would like to keep the exact time stamp during copy (read/write).
and the remain data in kernel temp buffer. I think its a little different
to ALSA API. I would prefer keeping this for now?
