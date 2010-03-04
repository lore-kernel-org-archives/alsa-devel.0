From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: [PATCH]Support MCP89 and GT21x hdmi audio
Date: Thu, 4 Mar 2010 09:17:07 +0800
Message-ID: <20100304011707.GA6462@localhost>
References: <6B4D417B830BC44B8026029FD256F7F1C068B2BA8B@HKMAIL01.nvidia.com>
	<20100302054307.GA6165@localhost> <s5h8wa9oqbi.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 6700D1037FB
	for <alsa-devel@alsa-project.org>; Thu,  4 Mar 2010 02:17:13 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5h8wa9oqbi.wl%tiwai@suse.de>
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
Cc: 'Pavel Hofman' <pavel.hofman@insite.cz>, Wei Ni <wni@nvidia.com>, 'akpm' <akpm@linux-foundation.org>, 'alsa-devel' <alsa-devel@alsa-project.org>, 'linux-kernel' <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 03, 2010 at 02:46:25PM +0800, Takashi Iwai wrote:
> At Tue, 2 Mar 2010 13:43:07 +0800,
> Wu Fengguang wrote:
> > 
> > On Mon, Mar 01, 2010 at 07:27:53PM +0800, Wei Ni wrote:
> > > Hi, Takashi
> > > I developed the hdmi audio driver for new chipset MCP89 and GT21x.
> > > The new HAD controller and codec support standard HDMI operation.
> > > 
> > > I attached the patch file, please check it.
> > 
> > Wei Ni,
> > 
> > Can we avoid the big copy&paste and do more code reuse?
> > This benefits all of us in long term.
> 
> The plan is to merge all current patch_*hdmi.c into one.
> But this can be done later once after we get the working driver
> for the new Nvidia codecs.
> 
> The new Nvidia HDMI codec is a bit tricky (which has 4 separate
> codec slots), so I'd like to get it working first.

OK, it makes sense to solve one problem at a time.

Wei Ni, would you ensure these naming rules:

- unmodified functions: keep the original function name hdmi_*
  (if the original function name is intelhdmi_*, rename it to hdmi_*)

- modified function: rename function name to nvhdmi_*
  (if the original function name is hdmi_*, rename it to intel_hdmi_*)

And do the same for data structures, enums, variables, etc.

This hopefully will make it easier to do the future merge.

Thanks,
Fengguang
