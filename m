From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [RFC] ALSA: add new alsa control byte extended
Date: Fri, 29 Nov 2013 18:58:25 +0530
Message-ID: <20131129132825.GI8834@intel.com>
References: <1385699397-18662-1-git-send-email-vinod.koul@intel.com>
 <s5hbo13fy6c.wl%tiwai@suse.de> <20131129074459.GE8834@intel.com>
 <s5hzjoneft5.wl%tiwai@suse.de> <52986123.5040004@perex.cz>
 <s5hsiufedxu.wl%tiwai@suse.de>
 <20131129110549.GQ27568@sirena.org.uk>
 <20131129102937.GG8834@intel.com>
 <20131129131153.GF10013@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 00CEA261700
 for <alsa-devel@alsa-project.org>; Fri, 29 Nov 2013 15:25:49 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20131129131153.GF10013@opensource.wolfsonmicro.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 29, 2013 at 01:11:53PM +0000, Charles Keepax wrote:
> > I am leading more towards adding new ioctl for this along with new ones for
> > enumerating controls. Then additional support for alsa-lib and tinyalsa.
> > That way existing tinymix, amxier can see these as controls while not disturbing
> > existing apps. I dont think we need save and restor, then alsactl need not be
> > modified.
> 
> It does feel a little odd to have this data set through a
> different interface to other existing control data, but I guess
> anything we do does have to be very careful around upsetting
> existing user-space code.
Am thinking users and driver shouldn't feel that it is different. The approach i
am leaning now is adding three ioctls, for enumerating, reading and then
writing. The tinyalsa and alsa-lib should also enumerate these new ones.  But we
don't impact ABI so old users/apps won't change.  Similarly on kernel side we
still treat these as kcontrols and drivers use existing infrastructure to manage
these...

-- 
~Vinod
