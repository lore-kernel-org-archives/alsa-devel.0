From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH v5] ASoC: sgtl5000: Fix the cache handling
Date: Tue, 27 May 2014 15:34:58 +0800
Message-ID: <20140527073452.GA8860@dragon>
References: <1401111260-23320-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0190.outbound.protection.outlook.com [207.46.163.190])
 by alsa0.perex.cz (Postfix) with ESMTP id 9DA4B26553F
 for <alsa-devel@alsa-project.org>; Tue, 27 May 2014 09:35:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1401111260-23320-1-git-send-email-fabio.estevam@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lars@metafoo.de
List-Id: alsa-devel@alsa-project.org

On Mon, May 26, 2014 at 10:34:20AM -0300, Fabio Estevam wrote:
> Since commit e5d80e82e32e (ASoC: sgtl5000: Convert to use regmap directly) a 
> kernel oops is observed after a suspend/resume sequence.
> 
> The kernel oops happens inside sgtl5000_restore_regs() as codec->reg_cache is no
> longer a valid pointer.
> 
> Add the remaining register entries into sgtl5000_reg_defaults[] and remove
> sgtl5000_restore_regs() completely, which allows suspend/resume to work fine and
> make the code simpler.
> 
> Tested on a im53-qsb board.
> 
> Reported-by: Shawn Guo <shawn.guo@freescale.com>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Tested-by: Shawn Guo <shawn.guo@freescale.com>
