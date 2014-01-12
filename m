From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [RFC][PATCH v2 00/13] speakers: Add support for
 capture/playback of PCM/MIDI
Date: Sun, 12 Jan 2014 23:53:10 +0900
Message-ID: <52D2AC56.1000509@sakamocchi.jp>
References: <1388920417-5584-1-git-send-email-o-takashi@sakamocchi.jp>
 <1389367775-21360-1-git-send-email-o-takashi@sakamocchi.jp>
 <52D01586.10806@ladisch.de> <s5hsisvx21s.wl%tiwai@suse.de>
 <52D01D47.4030004@sakamocchi.jp> <20140112133508.6894fe70@stein>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 47E3C2618F2
 for <alsa-devel@alsa-project.org>; Sun, 12 Jan 2014 15:53:15 +0100 (CET)
In-Reply-To: <20140112133508.6894fe70@stein>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi Stefan,

 > The constants which patch 13/13 adds to
 >  include/uapi/sound/{asound,firewire}.h
 > should of course be named accordingly then.

Yes. I forgot to rename it...

And I'm really sorry to maintainer but this patch (for hwdep) includes 
more bugs. I just added hwdep functionality but forgot to add codes to 
use it in PCM/MIDI functionality.

The codes are almost the same as the other drivers 
(snd-fireworks/snd-bebob) have. So in this time I hope you consider 
about the items which I mentioned in the first post.
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-January/070705.html


Thanks

Takashi Sakamoto
o-takashi@sakamocchi.jp
