From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: [PATCH] hda: add bounds checking for the codec
	command fields	v2
Date: Fri, 17 Jul 2009 19:10:51 +0800
Message-ID: <20090717111051.GB21516@localhost>
References: <20090717082410.GA20628@localhost>
	<20090717082703.GA21835@localhost>
	<20090717084919.GA24645@localhost>
	<BB1F052FCDB1EA468BD99786C8B1ED2C05871FFCB9@PDSMSX501.ccr.corp.intel.com>
	<s5hljmn8u52.wl%tiwai@suse.de> <s5hfxcv8tsr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 0D3F21038CF
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Jul 2009 13:11:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hfxcv8tsr.wl%tiwai@suse.de>
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
Cc: "Guo, Chaohong" <chaohong.guo@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, John Villalovos <jvillalo@redhat.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 17, 2009 at 06:53:24PM +0800, Takashi Iwai wrote:
> At Fri, 17 Jul 2009 12:46:01 +0200,
> I wrote:
> > 
> > At Fri, 17 Jul 2009 18:41:05 +0800,
> > Guo, Chaohong wrote:
> > > 
> > > Although it does address this issue, I am not comfortable with this fixing. 
> > > It seems more like a workaround than fix.
> > 
> > No, it's rather for catching a bug.  This is definitely neither
> > "workaround" nor "fix".
> 
> BTW, I fixed the patch again as below.
> 
> 
> Takashi
> 
> ---
> >From 82e1b804b03defe46fb69ffd2c8b19e6649bcb0d Mon Sep 17 00:00:00 2001
> From: Takashi Iwai <tiwai@suse.de>
> Date: Fri, 17 Jul 2009 12:47:34 +0200
> Subject: [PATCH] ALSA: hda - Fix the previous sanity check in make_codec_cmd()
> 
> The newly added sanity-check for a codec verb can be better written
> with logical ORs.  Also, the parameter can be more than 8bit.

Ah OK, thanks for the fix!

Thanks,
Fengguang
