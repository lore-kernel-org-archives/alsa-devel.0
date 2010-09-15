From: Wu Fengguang <wfg@linux.intel.com>
Subject: Re: Unifying sound/pci/hda/patch_*hdmi.c
Date: Wed, 15 Sep 2010 22:51:42 +0800
Message-ID: <20100915145142.GA11222@localhost>
References: <s5hsk1b12qw.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id DC752103805
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Sep 2010 16:51:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hsk1b12qw.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>, wni@nvidia.com
List-Id: alsa-devel@alsa-project.org

Thanks. I'll test it on Intel hardware tomorrow :)

On Wed, Sep 15, 2010 at 04:48:55PM +0200, Takashi Iwai wrote:
> Hi,
> 
> the below is a patch for unifying three patch_*hdmi.c into a single
> file.  I'd like to push this to 2.6.37, so please review, especially
> whether it can break Nvidia hardware (since I have no h/w available).
> 
> In future, we can reduce ATI- and Nvidia-specific codes gradually
> after confirming the generic parser works.
> 
> The patch is found in sound-unstable git tree, too.  The corresponding
> alsa-driver-unstable tarball can be used for external builds.
> 
> 
> thanks,
> 
> Takashi
