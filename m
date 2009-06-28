From: Paul Vojta <vojta@math.berkeley.edu>
Subject: Re: PC speaker beeps in 2.6.30?
Date: Sat, 27 Jun 2009 23:39:08 -0700
Message-ID: <20090628063908.GA2089@math.berkeley.edu>
References: <4A365DA6.8000102@msgid.tls.msk.ru>
	<4A4464CA.4060006@msgid.tls.msk.ru> <s5hws6y86wl.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out1.berkeley.edu (smtp-out1.Berkeley.EDU [128.32.61.106])
	by alsa0.perex.cz (Postfix) with ESMTP id 6A0442465A
	for <alsa-devel@alsa-project.org>;
	Sun, 28 Jun 2009 08:39:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hws6y86wl.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Michael Tokarev <mjt@tls.msk.ru>
List-Id: alsa-devel@alsa-project.org

On Sat, Jun 27, 2009 at 09:36:42AM +0200, Takashi Iwai wrote:
> At Fri, 26 Jun 2009 10:03:54 +0400,
> Michael Tokarev wrote:
> > 
> > [Adding some more Cc's...]
> > 
> > Am I the only concerned about this?  My 2.6.30 is still
> > silent w.r.t. old good PC speaker beeps, and I wasn't
> > able to make it to produce any sound.  Yes, as pointed
> > out by others there is a control now, in alsa, and I
> > can hear ugly and scary beeps from my stereo speakers
> > (when they're turned on and when the control is un-muted).
> > But that's.. not a solution/answer to the original
> > question... ;)
> 
> Try 2.6.31-rc1.  There was a fix regarding beep frequency.

Not necessarily.  Based on the OP's original post, as well as his mails
to the LKML (Google the subject line to find them), he has a desktop
system with external powered speakers connected to a sound card, and also
a small PC speaker inside the system case.  He wants to hear the beeps
coming out of the small speaker, since the external speakers (and/or sound
card) are not always turned on.

For that, try turning off SND_HDA_INPUT_BEEP.

(Regarding the beep frequency issue, the patch in 2.6.31-rc1 works for
all HDA codecs *EXCEPT* sigmatel/idt.  For sigmatel/idt, please see the
patch in bug #0004556.)

--Paul Vojta, vojta@math.berkeley.edu
