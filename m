From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 3/5] ALSA: soc-sst-bxt-da7219_max98357a:
 fix obsoleted initializers for array
Date: Wed, 27 Jul 2016 08:45:00 +0530
Message-ID: <20160727031500.GX9681@localhost>
References: <1469540517-32466-1-git-send-email-o-takashi@sakamocchi.jp>
 <1469540517-32466-4-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 17915265335
 for <alsa-devel@alsa-project.org>; Wed, 27 Jul 2016 05:07:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1469540517-32466-4-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: tiwai@suse.de, Patches Audio <patches.audio@intel.com>, alsa-devel@alsa-project.org, broonie@kernel.org, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 26, 2016 at 10:41:55PM +0900, Takashi Sakamoto wrote:
> Sparse reports below warnings.
> 
> bxt_da7219_max98357a.c:250:9: warning: obsolete array initializer, use C99 syntax
> bxt_da7219_max98357a.c:275:9: warning: obsolete array initializer, use C99 syntax
> bxt_da7219_max98357a.c:290:9: warning: obsolete array initializer, use C99 syntax
> bxt_da7219_max98357a.c:304:9: warning: obsolete array initializer, use C99 syntax
> bxt_da7219_max98357a.c:317:9: warning: obsolete array initializer, use C99 syntax
> 
> There's no need to use obsoleted way. This commit fixes it.

Thanks for the patch

Acked-by: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
