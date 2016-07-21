From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 2/2] ALSA - hda: Add support for link
 audio time reporting
Date: Thu, 21 Jul 2016 09:55:36 +0530
Message-ID: <20160721042536.GL9681@localhost>
References: <1468925202-29445-1-git-send-email-vinod.koul@intel.com>
 <1468925202-29445-3-git-send-email-vinod.koul@intel.com>
 <s5hk2gg98g9.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 0F730266570
 for <alsa-devel@alsa-project.org>; Thu, 21 Jul 2016 06:18:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hk2gg98g9.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, patches.audio@intel.com, Hardik T Shah <hardik.t.shah@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, liam.r.girdwood@linux.intel.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 20, 2016 at 07:36:54AM +0200, Takashi Iwai wrote:
> On Tue, 19 Jul 2016 12:46:42 +0200,
> Vinod Koul wrote:
> > 
> > +#ifdef CONFIG_X86
> ....
> > +#else
> > +static int azx_get_sync_time(ktime_t *device,
> > +		struct system_counterval_t *system, void *ctx)
> > +{
> > +	return -ENXIO;
> 
> This doesn't help much because the caller of azx_get_crosstime()
> doesn't check the return code.

Yes this is placeholder for getting arm build compiled. Anyway on ARM i dont
expect azx_get_crosstime to be called :)

-- 
~Vinod
