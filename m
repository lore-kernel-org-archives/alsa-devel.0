From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Bug in alsa-lib or alsamixer and amixer
Date: Wed, 16 Jun 2010 06:29:36 +0800
Message-ID: <AANLkTikawWMIPuuahzJuqnqHTW0MsRZWaP1c3O4pY8N7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 15329103853
	for <alsa-devel@alsa-project.org>;
	Wed, 16 Jun 2010 00:29:37 +0200 (CEST)
Received: by vws1 with SMTP id 1so1271292vws.38
	for <alsa-devel@alsa-project.org>; Tue, 15 Jun 2010 15:29:37 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/6/16 Colin Guthrie <gmane@colin.guthr.ie>

> 'Twas brillig, and Raymond Yau at 15/06/10 00:43 did gyre and gimble:
> > +12dB(400%) is even larger than the software gain 150% of PA
>
> Software gain of PA 150% = ~+11dB, so not as different as you imply.
>
> I've explained the cubic mapping already, so please don't use arbitrary,
> differently calculated percentages when comparing things. It's like
> comparing apples to oranges.
>
> Col
>
>
When I changed the volume slider of the gnome sound applet ( select
perference ) in Fedora 13 to maximum (i.e. PA 150% )

Seem to be bug in amixer and alsamixer

alsamixer also change to 150% but press any key change back to 100%

The volume range is only from 0 to  65536

why did alsa-lib allow alsa-pulse plugin to set it outside the range ,
alsamixer and amixer also display 150% ?

amixer -D pulse
Simple mixer control 'Master',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 65536
  Mono:
  Front Left: Playback 98304 [150%] [on]
  Front Right: Playback 98304 [150%] [on]
