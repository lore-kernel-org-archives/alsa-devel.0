From: Nicolin Chen <b42378@freescale.com>
Subject: Re: [PATCH] ASoC: WM8962: Remove remaining direct
 register cache accesses
Date: Fri, 14 Jun 2013 17:18:54 +0800
Message-ID: <20130614091853.GB9206@MrMyself>
References: <1371184490-2479-1-git-send-email-b42378@freescale.com>
 <20130614091853.GD1403@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 by alsa0.perex.cz (Postfix) with ESMTP id D74CF261A72
 for <alsa-devel@alsa-project.org>; Fri, 14 Jun 2013 11:33:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130614091853.GD1403@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Hi,

On Fri, Jun 14, 2013 at 10:18:53AM +0100, Mark Brown wrote:
> Applied, thanks.  I applied this as a bug fix so it needed some manual
> fixup and merging - it was fairly simple but it'd be good to check it
> all worked properly.

I've tested it with spk-mono case, and without this bug fix, my kernel
would crash at the point.

And in hp_sw(), most cases would successfully return after put_volsw().
There still might be an infinitesimal chance to run into the revised
parts but it should be okay.

Best regards,
Nicolin Chen
