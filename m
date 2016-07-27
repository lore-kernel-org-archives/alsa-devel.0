From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 3/5] ALSA: soc-sst-bxt-da7219_max98357a:
 fix obsoleted initializers for array
Date: Wed, 27 Jul 2016 11:30:02 +0530
Message-ID: <20160727060001.GA9681@localhost>
References: <1469540517-32466-1-git-send-email-o-takashi@sakamocchi.jp>
 <1469540517-32466-4-git-send-email-o-takashi@sakamocchi.jp>
 <20160727031500.GX9681@localhost> <57982CBB.90809@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id E3688265312
 for <alsa-devel@alsa-project.org>; Wed, 27 Jul 2016 07:52:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <57982CBB.90809@sakamocchi.jp>
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

On Wed, Jul 27, 2016 at 12:38:35PM +0900, Takashi Sakamoto wrote:
> 
> Thanks for your review.
> 
> On Jul 26 2016 22:41, Takashi Sakamoto wrote:
> > Although I got many warnings from Intel SST drivers due to confusions
> > of address spaces (__iomem and __kernel), I still left them as they
> > are, because they require more codes to fix. I hope Intel developers
> > will do additional work for them...
> 
> For your information. I'm happy if you and Intel developers are
> somewhat aware of them.

Thanks for reporting this Takashi san.

Will work on them as well

-- 
~Vinod
