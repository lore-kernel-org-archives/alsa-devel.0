From: "Singh, Guneshwor" <guneshwor.o.singh@intel.com>
Subject: Re: [PATCH v2 0/6] ASoC: Intel: Skylake: Skylake
	driver updates
Date: Thu, 7 Dec 2017 17:41:20 +0530
Message-ID: <20171207121119.GA23627@g2>
References: <20171206110406.11400-1-guneshwor.o.singh@intel.com>
 <20171206174344.kimjlfmy6frjibxz@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A2FC2670BC
 for <alsa-devel@alsa-project.org>; Thu,  7 Dec 2017 13:11:17 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20171206174344.kimjlfmy6frjibxz@sirena.org.uk>
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
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, ALSA <alsa-devel@alsa-project.org>, Vinod Koul <vinod.koul@intel.com>, Patches Audio <patches.audio@intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 06, 2017 at 05:43:44PM +0000, Mark Brown wrote:
> On Wed, Dec 06, 2017 at 04:34:00PM +0530, Guneshwor Singh wrote:
> > This series includes fixes for HDMI widgets sysfs not updating, shim
> > read optimization, fixes for dmic dev_type check and feature to
> > configure DSP clock source.
> 
> Please don't throw together a bunch of unrelated things into a patch
> series, if a patch is a standalone thing that isn't really related to
> and doesn't depend on the rest of the series just send it separately.
> This makes it much easier to follow what's going on and avoids changes
> getting held up by other, unrelated, changes.  For example here the DSP
> clock scaling stuff is a three patch series, if there were problems with
> this probably the rest of the series would take longer to get looked at.

Makes sense. I will take care of this in my future posts.
