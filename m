From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [RFC PATCH 5/5] ASoC: simplify the SSP DMA
	parameters settings	by run-time generation
Date: Thu, 23 Apr 2009 10:08:10 +0100
Message-ID: <20090423090810.GD30105@sirena.org.uk>
References: <f17812d70904222208i79604f3evb9950d6351377a83@mail.gmail.com>
	<74d0deb30904230153l5ec490eck211d6ef456869f36@mail.gmail.com>
	<f17812d70904230202t5dc459bbud36c13b11c6d5725@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id E5CC6103847
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Apr 2009 11:08:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <f17812d70904230202t5dc459bbud36c13b11c6d5725@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: alsa-devel@alsa-project.org, Paul Shen <bshen9@marvell.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, pHilipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 23, 2009 at 05:02:14PM +0800, Eric Miao wrote:
> >> + ?? ?? ?? snprintf(dma->name, 20, "SSP%d PCM %s %s", ssp->port_id,
> >> + ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? stereo ? "Stereo" : "Mono", out ? "out" : "in");

> > Should we change Stereo/Mono to 32-bit/16-bit here?

> Depends on Mark, the dma->name and the comments below doesn't
> actually match very well ...

The change seems reasonable - the text has bitrotted with respect to
what actually happens.
