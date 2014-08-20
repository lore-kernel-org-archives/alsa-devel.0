From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: Audio mini conference 2014?
Date: Wed, 20 Aug 2014 14:11:07 +0530
Message-ID: <20140820084106.GD13288@intel.com>
References: <s5hbnropcvd.wl-tiwai@suse.de>
 <20140813165517.GB17528@sirena.org.uk>
 <20140817231021.GQ14537@sirena.org.uk>
 <s5hha1aw6we.wl-tiwai@suse.de> <20140819172948.GX13288@intel.com>
 <alpine.DEB.2.00.1408191451550.10517@phandrigan-desktop>
 <20140820042109.GY13288@intel.com> <s5hy4ujhfta.wl-tiwai@suse.de>
 <20140820070236.GC13288@intel.com> <s5hr40bhaz2.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 55C2E2656CF
 for <alsa-devel@alsa-project.org>; Wed, 20 Aug 2014 11:18:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hr40bhaz2.wl-tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Tanu Kaskinen <tanu.kaskinen@linux.jf.intel.com>, Paul Handrigan <paul.handrigan@cirrus.com>, Mark Brown <broonie@kernel.org>, Daniel Mack <daniel@zonque.org>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 20, 2014 at 09:33:05AM +0200, Takashi Iwai wrote:
> > Configuration convergence:
> > From the OS side, we have Desktop OSes relying on PA, Chrome using CRAS,
> > Android using flinger. With DSPs and tons of configuration it doesn't bode
> > well to have multiple configuration for same stuff for the sound cards. Can
> > we talk about unifying the configuration at least. Sure OSes will have their
> > own ways to use, but from ALSA can we standardize configurations which
> > can be reused across.
> 
> I thought UCM was targeted to this, but not widely used as expected?
Chrome uses t but not Android due to licensing issues. What happend to
tinyucm?

-- 
~Vinod
