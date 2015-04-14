From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [RFC 11/11] ASoC: hda - enable ASoC Skylake HD
	audio driver
Date: Tue, 14 Apr 2015 10:16:22 +0530
Message-ID: <20150414044621.GK2963@intel.com>
References: <1428842178-7105-1-git-send-email-subhransu.s.prusty@intel.com>
 <1428842178-7105-12-git-send-email-subhransu.s.prusty@intel.com>
 <s5h8udwp79b.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id B7072261A8E
 for <alsa-devel@alsa-project.org>; Tue, 14 Apr 2015 06:51:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h8udwp79b.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, patches.audio@intel.com, lgirdwood@gmail.com, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 13, 2015 at 02:01:04PM +0200, Takashi Iwai wrote:
> At Sun, 12 Apr 2015 18:06:18 +0530,
> Subhransu S. Prusty wrote:
> > 
> > From: Jeeja KP <jeeja.kp@intel.com>
> > index 0000000..1711126
> > --- /dev/null
> > +++ b/sound/soc/hda/Kconfig
> > @@ -0,0 +1,29 @@
> > +menu "SKL-HD-Audio"
> > +
> > +config SND_SOC_HDA
> > +        tristate
> > +        select SND_HDA_CORE
> > +
> > +if SND_SOC_HDA
> > +
> > +config SND_HDA_PREALLOC_SIZE
> 
> The symbol conflicts.
Oops, any guidance for this name... ASOC_HDA_PREALLOC_SIZE or
SND_SOC_SND_HDA_PREALLOC_SIZE (but its too long)

Or move this up to hdac and be used by both?

-- 
~Vinod
