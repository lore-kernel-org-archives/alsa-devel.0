From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: Verifying mixer dB data/Invalid dB data from USB
 cards, especially Aureon 5.1 MkII
Date: Wed, 17 Feb 2010 13:54:28 +0100
Message-ID: <20100217125427.GB24165@tango.0pointer.de>
References: <20100215192451.GA17938@tango.0pointer.de>
	<4f3252891002161944m197e60c1pbb600cab8e0fd483@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id A34D1103874
	for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2010 13:54:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4f3252891002161944m197e60c1pbb600cab8e0fd483@mail.gmail.com>
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

On Wed, 17.02.10 11:44, Raymond Yau (superquad.vortex2@gmail.com) wrote:

> WHAT YOU NEED?
> 
>          a) A sound card where input and output are synchronous
>          b) A feedback cable that allows you to feed sound card output
> 
> 
> how do I know my sound card support synchronous playback and
> capture ?

We had a discussion about that on alsa-devel a month back or so. The
conclusion was basically that software may assume that playback and
capturing on the same card is clocked the same way and that is all
this tool needs.

> do you program able to find out whether the sound card support synchronous
> playback and  capture ?

No.

> do your result still valid if the sound card does not support synchronous
> playback and  capture ?

It's fine if there is a constant phase shift between what you play
back and record. What matters is that the clock of playback and clock
of capture have the same speed. The tool will sum up a recorded sample
window a couple of times to reduce the noise level below some
threshold, and for that to work we need to make sure that our sine
wave isn't shifted each time we sum it up.

> do the result different if I use analog loop back of the ac97 codec instead
> of a loop back cable ?

Presumably.

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
