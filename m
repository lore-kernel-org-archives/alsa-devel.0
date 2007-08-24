From: Jorge Peixoto de Morais Neto <jorgepeixotomorais@gmail.com>
Subject: Re: Unknown card info
Date: Fri, 24 Aug 2007 04:45:37 -0300
Message-ID: <20070824044537.55ff7403@localhost.localdomain>
References: <20070820162910.58f7f1e0@localhost.localdomain>
	<s5hps1fiwu4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.232])
	by alsa0.perex.cz (Postfix) with ESMTP id 744E410386C
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Aug 2007 09:45:47 +0200 (CEST)
Received: by wr-out-0506.google.com with SMTP id 58so759463wri
	for <alsa-devel@alsa-project.org>; Fri, 24 Aug 2007 00:45:46 -0700 (PDT)
In-Reply-To: <s5hps1fiwu4.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> > When I issue sudo modprobe snd_bt87x load_all=1, the following lines
> > appear in dmesg:
> > 
> > unknown card 0x878-0x1554:0x4011, using default rate 32000
> > please mail id, board name, and, if it works, the correct digital_rate
> > option to <alsa-devel@alsa-project.org>
> > 
> > I am obeying the request and mailing this information to you. I have no
> > idea what is the correct digital_rate option; all I know is that the
> > default seems to work ok. I have a cable connecting the sound output of
> > the tv card to the line in of my sound card; it seems that when wathing
> > tv through mplayer this is the mechanism used (and it works ok).
> > However, when recording tv through mencoder, it seems to use snd_bt87x
> > (in fact, it does not work if snd_bt87x is not loaded), and it also
> > works ok.
> 
> Thanks, now I added the entry for your device.
> 
> 
> Takashi
I forgot to say that I am having video capture bugs. The bug manifests
itself in weirdness in the video (a particular field of the video keeps
reappearing periodically), and in overall  system instability
(segfaults, and lockups in which not even the magick SysRq keys work).
I also get this kind of message in mencoder:

v4l2: ioctl dequeue buffer failed: Input/output error, idx = 000 [10706:0]
v4l2: ioctl dequeue buffer failed: Input/output error, idx = 0
v4l2: ioctl dequeue buffer failed: Input/output error, idx = 0
v4l2: ioctl dequeue buffer failed: Input/output error, idx = 0
v4l2: ioctl dequeue buffer failed: Input/output error, idx = 0
v4l2: ioctl dequeue buffer failed: Input/output error, idx = 0

Invalid frame duration value (35.021/0.000 => -35.021). Defaulting to 0.033 sec.
v4l2: ioctl dequeue buffer failed: Input/output error, idx = 000 [10708:0]
v4l2: ioctl dequeue buffer failed: Input/output error, idx = 0
v4l2: ioctl dequeue buffer failed: Input/output error, idx = 0
v4l2: ioctl dequeue buffer failed: Input/output error, idx = 0
v4l2: ioctl dequeue buffer failed: Input/output error, idx = 0
v4l2: ioctl dequeue buffer failed: Input/output error, idx = 0
v4l2: ioctl dequeue buffer failed: Input/output error, idx = 0
v4l2: ioctl dequeue buffer failed: Input/output error, idx = 0
v4l2: ioctl dequeue buffer failed: Input/output error, idx = 0
v4l2: ioctl dequeue buffer failed: Input/output error, idx = 0
v4l2: ioctl dequeue buffer failed: Input/output error, idx = 0
v4l2: ioctl dequeue buffer failed: Input/output error, idx = 0

Invalid frame duration value (35.021/0.000 => -35.021). Defaulting to 0.033 sec.
v4l2: ioctl dequeue buffer failed: Input/output error, idx = 000 [10711:0]
v4l2: ioctl dequeue buffer failed: Input/output error, idx = 0
v4l2: ioctl dequeue buffer failed: Input/output error, idx = 0
v4l2: ioctl dequeue buffer failed: Input/output error, idx = 0
v4l2: ioctl dequeue buffer failed: Input/output error, idx = 0
v4l2: ioctl dequeue buffer failed: Input/output error, idx = 0

Invalid frame duration value (35.021/0.000 => -35.021). Defaulting to 0.033 sec.
v4l2: ioctl dequeue buffer failed: Input/output error, idx = 000 [10713:0]
v4l2: ioctl dequeue buffer failed: Input/output error, idx = 0
v4l2: ioctl dequeue buffer failed: Input/output error, idx = 0
v4l2: ioctl dequeue buffer failed: Input/output error, idx = 0
v4l2: ioctl dequeue buffer failed: Input/output error, idx = 0
v4l2: ioctl dequeue buffer failed: Input/output error, idx = 0
v4l2: ioctl dequeue buffer failed: Input/output error, idx = 0
v4l2: ioctl dequeue buffer failed: Input/output error, idx = 0
v4l2: ioctl dequeue buffer failed: Input/output error, idx = 0
v4l2: ioctl dequeue buffer failed: Input/output error, idx = 0
v4l2: ioctl dequeue buffer failed: Input/output error, idx = 0
v4l2: ioctl dequeue buffer failed: Input/output error, idx = 0

Invalid frame duration value (35.021/0.000 => -35.021). Defaulting to 0.033 sec.
v4l2: ioctl dequeue buffer failed: Input/output error, idx = 000 [10716:0]
v4l2: ioctl dequeue buffer failed: Input/output error, idx = 0
v4l2: ioctl dequeue buffer failed: Input/output error, idx = 0
v4l2: ioctl dequeue buffer failed: Input/output error, idx = 0
v4l2: ioctl dequeue buffer failed: Input/output error, idx = 0
v4l2: ioctl dequeue buffer failed: Input/output error, idx = 0
v4l2: ioctl dequeue buffer failed: Input/output error, idx = 0
v4l2: ioctl dequeue buffer failed: Input/output error, idx = 0
v4l2: ioctl dequeue buffer failed: Input/output error, idx = 0
v4l2: ioctl dequeue buffer failed: Input/output error, idx = 0
v4l2: ioctl dequeue buffer failed: Input/output error, idx = 0
v4l2: ioctl dequeue buffer failed: Input/output error, idx = 0

Invalid frame duration value (35.021/0.000 => -35.021). Defaulting to 0.033 sec.
v4l2: ioctl dequeue buffer failed: Input/output error, idx = 000 [10717:0]
v4l2: ioctl dequeue buffer failed: Input/output error, idx = 0
v4l2: ioctl dequeue buffer failed: Input/output error, idx = 0
v4l2: ioctl dequeue buffer failed: Input/output error, idx = 0
v4l2: ioctl dequeue buffer failed: Input/output error, idx = 0
v4l2: ioctl dequeue buffer failed: Input/output error, idx = 0

Invalid frame duration value (35.021/0.000 => -35.021). Defaulting to 0.033 sec.
Pos:  35.2s    995f ( 0%) 24.72fps Trem:   0min   0mb  A-V:0.000 [10720:0]
Flushing video frames.
Writing index...
Writing header...
ODML: Aspect information not (yet?) available or unspecified, not writing vprp h                                                             eader.

Video stream: 10720.710 kbit/s  (1340088 B/s)  size: 47173581 bytes  35.202 secs                                                               995 frames
v4l2: ioctl dequeue buffer failed: Input/output error, idx = 0
v4l2: 990 frames successfully processed, 61 frames dropped.






These problems however happen even if I don't modprobe snd_bt87x, so the
bug is probably somewhere else.

Also, this bug appeared recently.Until some time ago, I could use my TV
capture card with no problems.
I have tried going back to the older kernel version, the older mplayer
version, with no help.

I even think this may be a hardware problem...

The point is, I do have this problem, but I don't think it indicates a
bug in the snd_bt87x support for my particular card, and your decision
to add the entry was correct. I'm only telling you about this problem
because, even though I don't think it is relevant, you may have a
different oppinion, so I think you should know this.

Thank you for your work,

Jorge Peixoto

-- 
Software is like sex: it is better when it is free. --Linus Torvalds
