From: Valentine Sinitsyn <valentine.sinitsyn@gmail.com>
Subject: ALC662 NID 0x09 is not unmuted anymore - intentional?
Date: Thu, 30 Sep 2010 23:18:51 +0600
Message-ID: <AANLkTikCL0DBhQo4YhuTEjLxUQBE+ONmtgJGu-s0Vec7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f179.google.com (mail-px0-f179.google.com
	[209.85.212.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 6B1CE10382B
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Sep 2010 19:18:55 +0200 (CEST)
Received: by pxi1 with SMTP id 1so764096pxi.38
	for <alsa-devel@alsa-project.org>; Thu, 30 Sep 2010 10:18:52 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,

I happened to spend last couple of evenings figuring out what's wrong with
microphone on my laptop (Lenovo Y550P, in case you are interested in). It
has Intel HDA soundcard with Realtek 272 codec. No, I'm not going to ask for
a help on devel mailing list, at the very least because I know what's wrong
myself. But this knowledge poses some questions regarding snd-hda-intel
kenel driver (more precisely, patch_realtek.c, which is part of it) I want
to clarify. Anyway, sorry for the long intro :)

It quickly appeared that AUD_IN widget of the codec (NID 0x09) has no way to
be unmuted - its input amplifier is muted at the very beginning of
alc662_init_verbs and is not connected to any ALSA control (maybe it
should). I remembered the mic was working some time ago, so I've skimmed
through kernel versions and found the offending commit:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=cec27c891b805b2ab2302f9fcbdacb6f179ac0d4

One can clearly see from it that before it was applied (i.e. Linux 2.6.34),
this widget was unmuted in alc662_auto_init_verbs (thus it happened to every
auto-configured card, including mine), but it is not unmuted anymore (as far
as I can see, for any model except maybe ecs - I haven't dug into this too
much).

The question is if it is intentional (i.e. there should be some ALSA switch
connected to 0x09 input amplifier) or is it a bug?

Thanks for the explanations.

-- 
Regards,
Valentine Sinitsyn
