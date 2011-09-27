From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/6] ASoC: Remove unused "control_data" field of struct
 wm8904_priv
Date: Tue, 27 Sep 2011 19:56:24 +0100
Message-ID: <20110927185623.GT4289@opensource.wolfsonmicro.com>
References: <1317127128.7207.1.camel@phoenix>
 <1317127222.7207.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1317127222.7207.3.camel@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 27, 2011 at 08:40:22PM +0800, Axel Lin wrote:
> The control_data field is used to initialize the codec's control_data field,
> but since this is also done by the snd-soc-cache core, the redundant
> assignment can be removed and the field can be dropped.

Applied all, thanks.
