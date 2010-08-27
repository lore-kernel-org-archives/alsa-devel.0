From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: explicit commandline control of speakers
 vs	headphone output
Date: Fri, 27 Aug 2010 21:26:37 +0200
Message-ID: <4C78116D.9040704@canonical.com>
References: <210284.64008.qm@web50707.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 822321038B2
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Aug 2010 21:26:39 +0200 (CEST)
In-Reply-To: <210284.64008.qm@web50707.mail.re2.yahoo.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eric Holstege <eric_holstege@yahoo.com>
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

2010-08-27 20:46, Eric Holstege skrev:
> Thanks, Clemens;
> 
> How were you able to determine that from the "amixer scontents" output.
> 
> Although I can't disable *automatic* speaker mute on headphone 
> insertion, can I explicitly unmute them again (e.g. with amixer sset or 
> cset)?
> 
> If not....
> "cat /proc/asound/card*/codec*" says it is the Realtek ALC888.
> Does this mean I have to somehow patch the kernel sound module file
> .../linux-source-2.6.*/sound/pci/hda/patch_realtek.c
> to fix this somehow?

So in the long run, I think it would be better to leave all auto-muting
to userspace. Then stuff like pulseaudio could to advanced decision of
how to handle input events. But that's the long way.

There are certainly ways to disable auto-muting for Realtek ALC888, look
along the lines of "speaker_automute" and "unsol_event". It is also
possible that you could tweak your user_pin_config to trick your HP out
into a Line Out. That way it won't automute, and you don't have to
recompile your kernel.

As a side note: The VIA HDA driver, I believe, have an option for
turning automute off. But it also sets "mute" on a misnamed control at
the same time, tricking PA into believing that you want to mute all
output. So PA is "helpful" and mutes everything else as well. :-/

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
