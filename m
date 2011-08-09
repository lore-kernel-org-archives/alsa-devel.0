From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: Add device tree binding for WM8753
Date: Mon, 8 Aug 2011 23:51:00 -0700
Message-ID: <20110809065100.GB8017@core.coreip.homeip.net>
References: <1312778255-29755-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <CAGsJ_4y2tDb3ZBPo8bCtrjFt0OWzR8WeG+kL_RKJPRP7-pZopw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAGsJ_4y2tDb3ZBPo8bCtrjFt0OWzR8WeG+kL_RKJPRP7-pZopw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Grant Likely <grant.likely@secretlab.ca>, alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, linux-input@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Barry,

On Mon, Aug 08, 2011 at 04:38:41PM +0800, Barry Song wrote:
> 2011/8/8 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> > Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> 
> Without this patch, DT can still connect driver with device by the
> heuristic way(of_modalias_node).
> 
> i have a patch just like yours in input subsystem "[PATCH v2] input:
> touchscreen: add OF match table for ads7846" with "Acked-by: Grant
> Likely", but Dmitry seems to just ignore it.
> 
> so not sure whether this kind of new added match tables are totally
> liked by people or not.

The issue I have with the ads7846 driver is that it still needs platform
code to supply the needed platform data structure to make the
driver/device usable. So I am not sure what the benefit DT matching code
brings to that driver.

Thanks.

-- 
Dmitry
