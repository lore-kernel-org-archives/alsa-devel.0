From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 3/6] ASoC: Add quirk data to support
 multiple	codecs
Date: Tue, 9 May 2017 15:56:23 +0530
Message-ID: <20170509102623.GS6263@localhost>
References: <1494235140-29369-1-git-send-email-naveen.m@intel.com>
 <1494235140-29369-4-git-send-email-naveen.m@intel.com>
 <s5h7f1q8sfw.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 21D682667E7
 for <alsa-devel@alsa-project.org>; Tue,  9 May 2017 12:24:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h7f1q8sfw.wl-tiwai@suse.de>
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
Cc: liam.r.girdwood@linux.intel.com, Naveen M <naveen.m@intel.com>, alsa-devel@alsa-project.org, broonie@kernel.org, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

On Tue, May 09, 2017 at 08:17:39AM +0200, Takashi Iwai wrote:
> On Mon, 08 May 2017 11:18:57 +0200,
> Naveen M wrote:
> > 
> > Add quirk data in sst_acpi_mach() which will hold number of codecs
> > and codec names to search for a best possible matching machine.
> > Set NULL for existing drivers not using this.
> 
> It's better to rewrite the existing code with C99 style
> initialization before introducing such a new field.  For the atom
> driver, it's more better with some macros to simplify.
> Then you don't have to touch the code as long as the default value is
> zero.

Agreed and it is more readable as well, we will change this :)

-- 
~Vinod
