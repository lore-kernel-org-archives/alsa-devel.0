From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH 0/10] Realtek auto-parser updates
Date: Sat, 30 Apr 2011 10:44:13 +0800
Message-ID: <BANLkTikYkZ5K1-Ws8b1LvpqimUN+0oT3FA@mail.gmail.com>
References: <1304097516-7258-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 9427E103823
	for <alsa-devel@alsa-project.org>;
	Sat, 30 Apr 2011 04:44:17 +0200 (CEST)
Received: by fxm5 with SMTP id 5so3247413fxm.38
	for <alsa-devel@alsa-project.org>; Fri, 29 Apr 2011 19:44:14 -0700 (PDT)
In-Reply-To: <1304097516-7258-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/4/30 Takashi Iwai <tiwai@suse.de>

> Hi, this is a series of patches I'm going to apply as 2.6.40 material.
> Basically this adds the missing features to BIOS auto-parser mode, the
> support of multi-channel setup (2/4/6-channels) and the auto-mute of
> line-out jacks as well as speakers.
>
> Many changes have been done but mostly in systematic manner.
> I've checked through hda-emu and a few machines with Realtek codecs,
> but of course can't cover all changes I made.
>
> If you see any issues with the updated tree, please let me know.
>
>
How about those 4 jacks 8 channels notebook (e.g. ms-1656)  ?

using hda-emu and codec info from

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=5244

0x1b is internal speaker
0x14 is the green jack
0x17 is the grey jack
0x18 is the pink jack
0x1a is the blue jack


autoconfig: line_outs=1 (0x17/0x0/0x0/0x0/0x0) type:line
   speaker_outs=1 (0x1b/0x0/0x0/0x0/0x0)
   hp_outs=1 (0x14/0x0/0x0/0x0/0x0)
   mono: mono_out=0x0
   dig-out=0x1e/0x0
   inputs: Mic=0x18 Internal Mic=0x19 Line=0x1a
