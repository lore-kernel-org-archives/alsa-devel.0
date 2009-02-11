From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: [PATCH 0/4] Intel HDMI audio fixes
Date: Wed, 11 Feb 2009 16:20:05 +0800
Message-ID: <20090211082005.GA25593@localhost>
References: <20090211072227.760779741@intel.com> <s5hab8te6ls.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 4B592103860
	for <alsa-devel@alsa-project.org>; Wed, 11 Feb 2009 09:20:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hab8te6ls.wl%tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Shane W <shane-alsa@csy.ca>
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 11, 2009 at 10:10:55AM +0200, Takashi Iwai wrote:
> At Wed, 11 Feb 2009 15:22:27 +0800,
> Wu Fengguang wrote:
> > 
> > Hi Takashi,
> > 
> > Here are four assorted fixes for Intel HDMI audio.
> > They have been tested in G35 SDVO HDMI and G45 integrated HDMI systems,
> > and shall be OK for 2.6.29.
> > 
> > [PATCH 1/4] hda - allow multi-channel HDMI audio playback when ELD is not present
> > [PATCH 2/4] hda - enable HDMI audio pin out at module loading time
> > [PATCH 3/4] hda - compute checksum in HDMI audio infoframe
> > [PATCH 4/4] hda - add id for Intel IbexPeak integrated HDMI codec
> 
> Thanks, all look good, so applied now.
> I'll queue them for the next pull request.

Thank you!

Fengguang
