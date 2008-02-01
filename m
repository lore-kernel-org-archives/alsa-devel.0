From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: ALC268 (no sound)
Date: Fri, 1 Feb 2008 18:12:32 +1030 (CST)
Message-ID: <200802010742.m117gWU0004940@mercury.physics.adelaide.edu.au>
References: <47A23800.6050305@harddisk.is-a-geek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelphi.physics.adelaide.edu.au
	(adelphi.physics.adelaide.edu.au [129.127.102.1])
	by alsa0.perex.cz (Postfix) with ESMTP id E814B103850
	for <alsa-devel@alsa-project.org>; Fri,  1 Feb 2008 08:50:37 +0100 (CET)
In-Reply-To: <47A23800.6050305@harddisk.is-a-geek.org> from "Marco Schuster"
	at Jan 31, 2008 10:05:04 PM
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Marco Schuster <marco@harddisk.is-a-geek.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
List-Id: alsa-devel@alsa-project.org

Hi Marco

> maybe this topic is a bit outdated, but still, when using the current
> hg code of the kernel module together with 2.6.24 (stable), I can't
> get any sound :(

Interesting.  I've had another user report getting sound out of the latest
hg tree with an ALC268 both with test mode and the "auto" mode.  Our
continued failure to get anything out of your laptop over the last few
months makes me suspect that there's some other non-standard thing (external
to the ALC268 codec) linked to the sound system in your laptop which
prevents audio unless activated.  Takashi, what's your take on this?

> Do I have also to upgrade the ALSA libs and programs?

This is strictly a driver-level issue; unless your libs are *really* ancient
(and from memory they aren't) it shouldn't matter.

Just to confirm, when attempting to use aplay, aplay appears to be working
but you get no sound - right?

Regards
  jonathan
