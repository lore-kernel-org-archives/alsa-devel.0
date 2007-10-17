From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Recent ALSA version needs special configuration
 for Terratec Phase 26 USB
Date: Wed, 17 Oct 2007 16:01:41 +0200
Message-ID: <1192629701.18595.1216364497@webmail.messagingengine.com>
References: <87d4ve5jwc.fsf@waghdas.discendum.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 9FBD72470D
	for <alsa-devel@alsa-project.org>;
	Wed, 17 Oct 2007 16:01:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <87d4ve5jwc.fsf@waghdas.discendum.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Janne Himanka <janne.himanka@iki.fi>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Janne Himanka wrote:
> I run Debian unstable on my Athlon XP1800 machine,

32 or 64 bits?

> and updating libasound2 package from version 1.0.13-2 to 1.0.14 (and
> later)

Did you try 1.0.15?

> made my Terratec Phase 26 USB soundcard useless. Whenever I tried to
> play something, the program would crash with a segmentation fault.
> When I downgraded to 1.0.13, everything would work again. 
> 
> It took a lot of head scratching and experimentation to find out that
> adding 
> 
> cards.USB-Audio.pcm.use_dmix."USB2448" no
> 
> to my .asoundrc (it is otherwise empty) is needed for it to
> work.

This looks like a bug in the dmix plugin.
Do you have any other USB audio device that works?

Can you get a stack trace from gdb when playing something with aplay?

> The Phase 26 is adaptive; it doesn't need converting for a specific
> format. Bitrates from 32 KHz to 96 KHz and word lengths from 16 to 32
> bits just work.

32-bit samples are not possible with USB audio devices.  I guess ALSA
automatically converts for you.


Regards,
Clemens
