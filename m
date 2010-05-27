From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH 3/4] ALSA: usb-audio: parse UAC2 endpoint
 descriptors correctly
Date: Thu, 27 May 2010 20:15:14 +0200
Message-ID: <20100527181514.GL2695@buzzloop.caiaq.de>
References: <1274890299-8972-1-git-send-email-daniel@caiaq.de>
	<1274890299-8972-3-git-send-email-daniel@caiaq.de>
	<20100526161746.GE2695@buzzloop.caiaq.de>
	<20100526204657.GB7343@suse.de> <s5hfx1d4vff.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 40FC21037F1
	for <alsa-devel@alsa-project.org>;
	Thu, 27 May 2010 20:15:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hfx1d4vff.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Greg KH <gregkh@suse.de>, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

On Thu, May 27, 2010 at 10:10:12AM +0200, Takashi Iwai wrote:
> At Wed, 26 May 2010 13:46:57 -0700,
> Greg KH wrote:
> > 
> > On Wed, May 26, 2010 at 06:17:46PM +0200, Daniel Mack wrote:
> > > On Wed, May 26, 2010 at 06:11:38PM +0200, Daniel Mack wrote:
> > > > UAC2 devices have their information about pitch control stored in a
> > > > different field. Parse it, and emulate the bits for a v1 device.
> > > > 
> > > > A new struct uac2_iso_endpoint_descriptor is added.
> > > 
> > > > 
> > > > Signed-off-by: Daniel Mack <daniel@caiaq.de>
> > > > ---
> > > >  include/linux/usb/audio-v2.h |   16 ++++++++++++
> > > 
> > > Greg, I copied you because of this patch, just to let you know we're
> > > having fun in your area of responsibility again :)
> > 
> > Heh, no problem at all.
> > 
> > Takashi, feel free to add an:
> > 	Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
> > to this patch when you take it.
> 
> OK, I put this to my tree.  Will be included in the next pull request
> in this week.

Thanks Takashi!

Here's another small one that needs attention.

Daniel

>From 3beee40982b98314f8d58c775cc8b40a8e25ce18 Mon Sep 17 00:00:00 2001
From: Daniel Mack <daniel@caiaq.de>
Date: Thu, 27 May 2010 18:28:25 +0200
Subject: [PATCH] ALSA: usb-audio: fix feature unit parser for UAC2

Fix a small off-by-one bug which causes the feature unit to announce a
wrong number of channels. This leads to illegal requests sent to the
firmware eventually.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
---
 sound/usb/mixer.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 97dd176..03ce971 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1126,7 +1126,7 @@ static int parse_audio_feature_unit(struct mixer_build *state, int unitid, void
 	} else {
 		struct uac2_feature_unit_descriptor *ftr = _ftr;
 		csize = 4;
-		channels = (hdr->bLength - 6) / 4;
+		channels = (hdr->bLength - 6) / 4 - 1;
 		bmaControls = ftr->bmaControls;
 	}
 
-- 
1.7.1
