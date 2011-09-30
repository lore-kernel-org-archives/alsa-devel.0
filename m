From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: Remove unused "control_data" field of struct
 aic3x_priv
Date: Fri, 30 Sep 2011 12:50:26 +0100
Message-ID: <20110930115025.GC5366@opensource.wolfsonmicro.com>
References: <1317349870.4193.1.camel@phoenix>
 <1317349957.4193.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1317349957.4193.3.camel@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Vladimir Barinov <vova.barinov@gmail.com>, Liam Girdwood <lrg@ti.com>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 30, 2011 at 10:32:37AM +0800, Axel Lin wrote:
> The control_data field is used to initialize the codec's control_data field,
> but since this is also done by the snd-soc-cache core, the redundant
> assignment can be removed and the field can be dropped.

Applied, thanks.
