From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: Bug tracking help wanted (Re: alsa driver #2234
 SoundScape Elite not support)
Date: Thu, 8 Jan 2009 22:57:11 +0100
Message-ID: <20090108225711.ecf17f1f.krzysztof.h1@poczta.fm>
References: <8D479F36-7BCB-487E-A4A9-25DB7C9A1AD0@hws.edu>
	<20090106181710.3a9ba7cd.krzysztof.h1@poczta.fm>
	<5A449489-AA9E-4D66-8376-771BE195EE0A@hws.edu>
	<20090107200341.ba7bfdd7.krzysztof.h1@poczta.fm>
	<525A9CFA-7E26-4C1F-949F-BCB5DA22F30F@hws.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239])
	by alsa0.perex.cz (Postfix) with ESMTP id 9572A1037F7
	for <alsa-devel@alsa-project.org>; Thu,  8 Jan 2009 22:54:44 +0100 (CET)
In-Reply-To: <525A9CFA-7E26-4C1F-949F-BCB5DA22F30F@hws.edu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Theodore J. Allen" <tjallen@hws.edu>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 7 Jan 2009 19:13:18 -0500
"Theodore J. Allen" <tjallen@hws.edu> wrote:

> Hi Krzysztof,
> 
> Yes, the Soundscape Elite does have the AD1848KP chip.
> 
> I compiled the 2.6.28 kernel and enabled the snd-sscape
> module, though I compiled the rest of the ALSA code into
> the kernel.  It is closer, but not there yet; I get some
> noise (clicks) from the card when trying to access it but
> no sound.  I ran the alsamixer and I also tried to upload
> firmware with the sscape_ctl program, but the only message
> I get from doing that is "ALSA sound/isa/sscape.c:536:
> sscape: No response from on-board processor after upload"
> 

It seems that the codec is detected correctly now so try running 
alsamixer, set volume to non-zero level (maximum is the best for 
the first trial but will be too loud probably) then use aplay 
command to play any sound. Do not upload card's firmware as
it maybe needed only for MIDI playback (OSS driver does not
need it). Let's try running the digital playback and recording
without the midi part first.

What is error message produced if you try using aplay? Is there
anything new in the dmesg file?

I will try comparing the source of the free OSS driver to find
out is there any additional actions inside driver required for the 
Elite card.

Regards,
Krzysztof

----------------------------------------------------------------------
Znamy wszystkie lekarstwa na nude! Przekonaj sie sam.
Kliknij >>  http://link.interia.pl/f200d
