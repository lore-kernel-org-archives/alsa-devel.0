From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH 0/4] ALSA: dice: enable to handle several
	streams
Date: Wed, 9 Mar 2016 23:00:53 +0100
Message-ID: <20160309230053.41c56575@kant>
References: <1457357745-24756-1-git-send-email-o-takashi@sakamocchi.jp>
 <56E021D7.9020909@sakamocchi.jp> <s5htwkf7jt8.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
 by alsa0.perex.cz (Postfix) with ESMTP id 21ABD260682
 for <alsa-devel@alsa-project.org>; Wed,  9 Mar 2016 23:00:55 +0100 (CET)
In-Reply-To: <s5htwkf7jt8.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de, ffado-devel@lists.sf.net, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

On Mar 09 Takashi Iwai wrote:
> On Wed, 09 Mar 2016 14:15:03 +0100, Takashi Sakamoto wrote:
> > On mar 7 2016 22:35, Takashi Sakamoto wrote:  
> > > Takashi Sakamoto (4):
> > >   ALSA: dice: have two sets of isochronous resources/streams
> > >   ALSA: dice: handle whole available isochronous streams
> > >   ALSA: dice: handle several PCM substreams when any isochronous streams
> > >     are available
> > >   ALSA: dice: force to add two pcm devices for listed models
> > > 
> > >  sound/firewire/dice/dice-midi.c   |   8 +-
> > >  sound/firewire/dice/dice-pcm.c    | 147 +++++++++-----
> > >  sound/firewire/dice/dice-stream.c | 398 ++++++++++++++++++++++++--------------
> > >  sound/firewire/dice/dice.c        |  41 ++++
> > >  sound/firewire/dice/dice.h        |  33 +++-
> > >  5 files changed, 424 insertions(+), 203 deletions(-)  
> > 
> > I strongly request to merge this patchset to linux-next for 4.6 kernel.
> > For already supported models, this patchset basically adds no changes
> > except for actual codes. Therefore few possibilities of regressions.  
> 
> I expected some tested-by tags or such, but OK, it's fine to merge
> without that.  There are minor nitpicks, but they can be improved
> later.
> 
> Now applied all patches.

I now tested this version of these four patches too, in the same way as
the previous version from March 5.
kernel: v4.5-rc6 plus
    ALSA: dice: limit to current sampling transfer frequency
    ALSA: dice: limit stream to current sampling transfer frequency.
    ALSA: dice: add MIDI ports according to current number of MIDI substreams
    ALSA: dice: get the number of MBLA data channel at opening PCM substream
    ALSA: dice: purge generating channel cache
    ALSA: dice: ensure phase lock before starting streaming
    ALSA: dice: change notification mask to detect lock status change
    ALSA: dice: old firmware optimization for Dice notification
    ALSA: dice: drop duplex streams synchronization to transfer own time stamps
cherry-picked from tiwai/sound.git, and current 4 patches applied on top.
Host: AMD64, Texas Instruments XIO2213B FireWire adapter.
Audio devices tested:  Focusrite Saffire PRO 24 and PRO 40.
Again no regression with PRO 24 or PRO 40, previously inaccessible higher
channels of the PRO 40 are now accessible (now as devices 0 and 1 on the
respective ALSA card), older muting quirk of the PRO 40 at 88.2/96 kHz still
happens with or without the 9+4 dice patches.
-- 
Stefan Richter
-======----- --== -=--=
http://arcgraph.de/sr/
