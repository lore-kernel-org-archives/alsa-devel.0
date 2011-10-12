From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Make SND_SOC_SAARB and
 SND_SOC_TAVOREVB3 depend on MFD_88PM860X
Date: Wed, 12 Oct 2011 13:10:45 +0100
Message-ID: <20111012121045.GK3647@opensource.wolfsonmicro.com>
References: <1318420192.28832.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CF2F710393A
	for <alsa-devel@alsa-project.org>;
	Wed, 12 Oct 2011 14:10:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1318420192.28832.1.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Eric Miao <eric.y.miao@gmail.com>, linux-kernel@vger.kernel.org, Haojian Zhuang <haojian.zhuang@marvell.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 12, 2011 at 07:49:52PM +0800, Axel Lin wrote:
> In saarb_pm860x_init() and evb3_pm860x_init(), we call
> pm860x_hs_jack_detect() and pm860x_mic_jack_detect() which in turn
> calls pm860x_set_bits().
> Thus make SND_SOC_SAARB and SND_SOC_TAVOREVB3 depend on MFD_88PM860X

What we just did for WM8994 was add a select of the MFD for consistency
with the way the CODEC driver itself is handled.
