From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: [PATCH] AudigyLS updates.
Date: Mon, 28 Jun 2004 13:39:25 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40E0117D.6010503@superbug.demon.co.uk>
References: <40DC9B32.6000204@superbug.demon.co.uk> <s5hlli8dkld.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from anchor-post-33.mail.demon.net (anchor-post-33.mail.demon.net [194.217.242.91])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id D58D616A
	for <alsa-devel@alsa-project.org>; Mon, 28 Jun 2004 13:36:07 +0200 (MEST)
In-Reply-To: <s5hlli8dkld.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> 
>>2) Add a CAPUTRE source switch for switch between "MIC", "Line in", 
>>"SPDIF in", "TAD in", "AUX in" and "What u hear". Currently, one cannot 
>>switch to capture "SPDIF in" or "What u hear", but all the other inputs 
>>are possible via switches in the AC97.
> 
> 
> This will need better control on user-space.
> ac97 mixer will provide the generic capture source only...
> 
> 
> Takashi
> 
> 

I am adding better controls as I find out what does what.
How is the userspace mixer controls status? (Using a lisp .conf file to 
control how the mixer behaves).

What shall I call the AC97 capture controls?
1) AC97 Master CAPTURE.
2) AC97 MIC CAPTURE.
3) AC97 Line in CAPTURE.
4) AC97 TAD in CAPTURE.
5) AC97 AUX CAPTURE.
option (1) to (5) can act together, so one can record some from MIC and 
also some from Line in at the same time.
6) Feedback into PLAYBACK from CAPTURE.

There is also another capture source register I have found out about.
0 - Selects SPDIF CAPTURE.
1 - What you hear CAPTURE.
2 - Unknown
3 - AC97 CAPTURE. (See 1) to 5) above)
If this register is not set to 3, all the AC97 inputs are muted.

I think I will add some new control renaming/deleting code, so that only 
the controls I know about are displayed to the user. I can put an #if 1 
... #endif round it, so that I can disable the renaming when I am testing.

Is there a document somewhere for alsa-driver developers that states 
what one should set things to as the default, the "on start up" settings?

E.g.
Initial Analog volume controls.
Should digital out be enabled at startup, or analog outputs.

I think we should have the following (although the audigyls.c does not 
follow this yet!):-
Analog volume controls muted.
Default to Analog output.

In windows the defaults are:
I don't know what the analog defaults are.
digital out is disabled at start up.

The windows driver controls digital output using a on/off switch called 
"SPDIF Out"

I think it might be a good idea to change the "Audigy Analog/Digital 
Output Jack"  to instead say "SPDIF Out", with it defaulting to off for 
Analog.

The "Audigy Analog/Digital Output Jack" being an on/off switch was 
confusing, because it was not clear to a casual user what [off] meant. 
Does that mean "Analog off", or "Digital off".


Cheers
James


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
