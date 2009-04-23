From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [RFC PATCH 5/5] ASoC: simplify the SSP
	DMA	parameters settings by run-time generation
Date: Thu, 23 Apr 2009 09:23:28 +0100
Message-ID: <20090423082328.GB30105@sirena.org.uk>
References: <f17812d70904222208i79604f3evb9950d6351377a83@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 557B9103838
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Apr 2009 10:23:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <f17812d70904222208i79604f3evb9950d6351377a83@mail.gmail.com>
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
Cc: alsa-devel@alsa-project.org, Paul Shen <bshen9@marvell.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 23, 2009 at 01:08:51PM +0800, Eric Miao wrote:
> The SSP DMA parameters can actually be easily generated at run-time since
> they are almost similar except for the FIFO width and direction. Another
> benefit is the re-use of information from 'struct ssp_device', like SSDR
> physical FIFO address and DRCMR register index for both directions.

> Signed-off-by: Eric Miao <eric.miao@marvell.com>

This looks like a win - is there any reason not to merge it without
waiting for the rest of the series (I've not tested it yet)?
