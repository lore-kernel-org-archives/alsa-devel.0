From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ARM: pxa: add support for Raumfeld DDX
Date: Wed, 16 Nov 2011 16:07:43 +0000
Message-ID: <20111116160742.GH29986@opensource.wolfsonmicro.com>
References: <1320661562-422-1-git-send-email-zonque@gmail.com>
	<20111115141348.GG3077@opensource.wolfsonmicro.com>
	<4EC3B30F.60403@gmail.com> <20111116150722.GA15580@sig21.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A717224565
	for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2011 17:07:45 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20111116150722.GA15580@sig21.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Johannes Stezenbach <js@sig21.net>
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 16, 2011 at 04:07:22PM +0100, Johannes Stezenbach wrote:

> IIRC the PXA can handle 24bit audio, and the STA32x can handle it, too.
> However due to constraints in the clock ratios on the Raumfeld board
> this mode cannot be used.  Thus this constraint is in sound/soc/pxa/raumfeld.c.

If that's the case then the comment needs to be updated as currently
what it says is that this is a CPU side limitation.
