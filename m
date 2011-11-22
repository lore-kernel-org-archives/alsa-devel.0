From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC: max9877: Update register if either val or
	val2 is changed
Date: Tue, 22 Nov 2011 13:06:24 +0000
Message-ID: <20111122130624.GD21029@opensource.wolfsonmicro.com>
References: <1321944464.2236.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1F38324355
	for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2011 14:06:27 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1321944464.2236.3.camel@phoenix>
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
Cc: alsa-devel@alsa-project.org, Joonyoung Shim <jy0922.shim@samsung.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 22, 2011 at 02:47:44PM +0800, Axel Lin wrote:
> In the case of ((max9877_regs[reg] >> shift) & mask) != val
> but ((max9877_regs[reg2] >> shift) & mask) == val2,
> current code does not update the registers.

Applied, thanks.
