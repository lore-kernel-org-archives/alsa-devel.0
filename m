From: Sander Smeenk <ssmeenk@freshdot.net>
Subject: Re: Realtek ALC892 / snd-hda-intel breakage between
 3.16 & 3.19
Date: Thu, 28 May 2015 17:17:24 +0200
Message-ID: <20150528151724.GC12158@dot.dmz.freshdot.net>
References: <20150527190106.GA12158@dot.dmz.freshdot.net>
 <CAN8cciY_PGVKaDWpOGmaZgRetS9oQpCoPqH5PpZdVdNgrk26YQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dot.freshdot.net (dot.freshdot.net [213.154.236.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 00B1D2604C2
 for <alsa-devel@alsa-project.org>; Thu, 28 May 2015 17:17:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAN8cciY_PGVKaDWpOGmaZgRetS9oQpCoPqH5PpZdVdNgrk26YQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Quoting Raymond Yau (superquad.vortex2@gmail.com):

> > After upgrading from 3.16.0-38-generic (Ubuntu Utopic) to
> > 3.19.0-18-generic (Ubuntu Vivid) my audio stopped working.
> > The issue appears to be in the snd-hda-intel driver.
[ .. ]
> HDMI fail because drm/i915 fail

So it appears. I hadn't noticed these: 
| [000d00h02m01s] Could not create debugfs 'i915_pipe_update_start' directory
| [000d00h02m01s] snd_hda_intel 0000:00:03.0: Cannot turn on display power on i915


> > | ALSA lib pcm_pulse.c:752:(pulse_prepare) PulseAudio: Unable to create stream: No such entity
> This seem pulseaudio fail

Yes. This error is because PulseAudio is also unable to communicate with
the soundcard while 3.19 is running. However, the issue at hand is not
PulseAudio related. Even with no Pulse running, aplay and friends fail
to work the card.

Thnx,
-Sndr
-- 
| Decafalon (n.): The grueling event of getting through the day consuming
| only things that are good for you.
| 4096R/20CC6CD2 - 6D40 1A20 B9AA 87D4 84C7  FBD6 F3A9 9442 20CC 6CD2
