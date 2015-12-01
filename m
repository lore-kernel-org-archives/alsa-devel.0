From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: Re: [PATCH 04/15] ALSA: hda - Add helper to read eld
	data
Date: Wed, 2 Dec 2015 00:42:14 +0530
Message-ID: <20151201191214.GB5624@subhransu-desktop>
References: <1448991749-8091-1-git-send-email-subhransu.s.prusty@intel.com>
 <1448992031-8271-1-git-send-email-subhransu.s.prusty@intel.com>
 <1448992031-8271-4-git-send-email-subhransu.s.prusty@intel.com>
 <s5hvb8ipclk.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 0CD42261B01
 for <alsa-devel@alsa-project.org>; Tue,  1 Dec 2015 14:41:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hvb8ipclk.wl-tiwai@suse.de>
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
Cc: patches.audio@intel.com, Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 01, 2015 at 01:39:19PM +0100, Takashi Iwai wrote:
> On Tue, 01 Dec 2015 18:47:00 +0100,
> Subhransu S. Prusty wrote:
> > 
> > The eld reading APIs are required for ASoC skylake hdmi
> > driver as well. So moving these definition to core. Once
> > component ops for reading ELD is available will mark this
> > as deprecated.
> > 
> > Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
> > Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> 
> I'd like rather to merge this from my tree, not from asoc tree.
> Otherwise it makes hard to use this in the legacy HDA driver.

I have not updated the callers here and not planning to change for now as
it can be removed I guess once the component framework is available to
read eld. What do you say?

Regards,
Subhransu
> 
> Or make this local in asoc, and clean up later as a common helper.
> 
> 
> thanks,
> 
> Takashi
> 
> 

-- 
