From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 5/7] ALSA: hda - Use ops instead of
 directly accessing chmap helpers
Date: Thu, 3 Mar 2016 16:59:23 +0530
Message-ID: <20160303112923.GK11154@localhost>
References: <1456920208-1172-1-git-send-email-subhransu.s.prusty@intel.com>
 <1456920208-1172-6-git-send-email-subhransu.s.prusty@intel.com>
 <s5hmvqgsw8x.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 15B2E26519F
 for <alsa-devel@alsa-project.org>; Thu,  3 Mar 2016 12:25:45 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hmvqgsw8x.wl-tiwai@suse.de>
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
Cc: patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 02, 2016 at 05:03:10PM +0100, Takashi Iwai wrote:
> On Wed, 02 Mar 2016 13:03:26 +0100,
> Subhransu S. Prusty wrote:
> > 
> > Added more ops to the chmap object, so most of the helpers can be
> > accessed through ops instead instead of directly calling them.
> 
> Too many instead :)
> 
> > With this moving the chmap helpers to core will be easy.
> 
> Well, although I asked about reduction of exported stuff, I don't
> think it's worth to put everything in ops.  If any of them would be
> overridden, it's good to have as an ops.  If not, it's fine to have
> exported symbols.  These are just a few entries, not over 20.

I think the thought was that patch_hdmi and ASoC driver will use defaults
whereas the patch_nvidia etc will override with their own stuff..

-- 
~Vinod
