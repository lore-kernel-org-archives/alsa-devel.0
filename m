From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: Re: [PATCH v3 14/15] ASoC: hdac_hdmi: Add jack
 reporting for user space
Date: Wed, 9 Dec 2015 13:33:38 +0530
Message-ID: <20151209080338.GC9554@subhransu-desktop>
References: <1449523078-4311-1-git-send-email-subhransu.s.prusty@intel.com>
 <1449523469-4395-1-git-send-email-subhransu.s.prusty@intel.com>
 <1449523469-4395-14-git-send-email-subhransu.s.prusty@intel.com>
 <s5hy4d6kzb5.wl-tiwai@suse.de> <20151208063135.GN1854@localhost>
 <s5htwnt1m2x.wl-tiwai@suse.de> <20151208074216.GO1854@localhost>
 <s5hio491iol.wl-tiwai@suse.de> <20151208083831.GP1854@localhost>
 <s5h7fkp1gda.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id CC1E02604A9
 for <alsa-devel@alsa-project.org>; Wed,  9 Dec 2015 09:00:59 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5h7fkp1gda.wl-tiwai@suse.de>
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
Cc: Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

> > 
> > > > > Though, the max number of converters is limited, thus what you can
> > > > > actually use is defined by this constraint.  Due to this, we'll likely
> > > > > manage MST for the legacy HDA by assigning MST devs dynamically to
> > > > > pins in a certain procedure to make things compatible.
> > > > 
> > > > but how many MST devs are you going to create?
> > > 
> > > This is exactly the point: for the legacy HDA, instead of creating the
> > > entry for each MST devices, they are assigned dynamically to PCM at
> > > activation.  So the number of devices exposed to user-space is
> > > limited -- or better to say, user-space won't notice the difference.
> > 
> > And how many PCMs are you proposing for MST?
> 
> 5 for Intel, i.e. Nconv * 2 - 1.  This could be even Nconv, but we
> provide the reserved slots just for the compatible behavior that
> assumes the static pin/slot assignment.
>

How is Nconv * 2 - 1 PCMs are derived? Lets assume, there are 3 cvts and 4pins,
I think it will not work.

-- 
Subhransu
