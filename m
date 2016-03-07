From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH 4/4] ALSA: dice: force to add two pcm
 devices for listed models
Date: Mon, 7 Mar 2016 01:24:42 +0100
Message-ID: <20160307012442.6935bc04@kant>
References: <1457179087-27604-1-git-send-email-o-takashi@sakamocchi.jp>
 <1457179087-27604-5-git-send-email-o-takashi@sakamocchi.jp>
 <20160305160733.6306be3f@kant> <56DC2514.2010101@sakamocchi.jp>
 <20160306235521.7aabff60@kant>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
 by alsa0.perex.cz (Postfix) with ESMTP id BF1882605C3
 for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2016 01:24:43 +0100 (CET)
In-Reply-To: <20160306235521.7aabff60@kant>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On Mar 06 Stefan Richter wrote:
[...]
> Then I also tried 88200 and 96000 Hz.  This gives 16+16 channels at
> subdevice #0 like it should, and capture works, but playback is mute.
[...]
> Next thing for me to do will be to remove patches and figure out whether
> a previous driver revision gives me unmuted playback at 96000 Hz on the
> PRO 40. 

Plain v4.5-rc6 gave me unmuted playback at 88200/96000 Hz once, but it was
distorted by some sort of high clinking.  Other times plain v4.5-rc6 had
muted playback at 88200/96000 Hz too.

I tested with mplayer+jack+alsa, audacious+jack+alsa, and
audacious+alsa.
-- 
Stefan Richter
-======----- --== --===
http://arcgraph.de/sr/
