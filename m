From: Zidan Wang <zidan.wang@freescale.com>
Subject: Re: [PATCH v4] ASoC: wm8960: update pll and clock
 setting function
Date: Tue, 11 Aug 2015 18:12:37 +0800
Message-ID: <20150811101235.GA18737@shlinux2>
References: <f6e8caad9d39c37ff0660a5a59d707ee7b3963fb.1439268589.git.zidan.wang@freescale.com>
 <20150811080334.GJ25225@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0133.outbound.protection.outlook.com [157.56.110.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 6FE41265E28
 for <alsa-devel@alsa-project.org>; Tue, 11 Aug 2015 13:23:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20150811080334.GJ25225@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 11, 2015 at 09:03:35AM +0100, Charles Keepax wrote:
> On Tue, Aug 11, 2015 at 01:11:35PM +0800, Zidan Wang wrote:
> > Add sysclk auto mode. When it's sysclk auto mode, if the MCLK is
> > available for clock configure, using MCLK to provide sysclk directly,
> > otherwise, search a available pll out frequcncy and set pll.
> > 
> > Configure clock in hw_params may cause problems when using bypass style
> > paths without hw_params in machine driver getting called. So add configure
> > clock to set_bias_level.
> > 
> > Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
> > ---
> 
> Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> 
> Thanks,
> Charles
Hi Charles,

After rebase to the newest linux-nest/master, there will be a build error. I have fixed it and will
send patch v5, sorry for that.

Best Regards,
Zidan Wang
