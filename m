From: peloy@chapus.net (Eloy A. Paris)
Subject: Re: Occasional metallic sound when recording (cs46xx)
Date: Wed, 05 Nov 2003 10:08:33 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <87brrqrgy6.fsf@canaima.chapus.net>
References: <200310221739.h9MHd0m1024945@oud.linuxaudiosystems.com>
	<3F981FF3.4040902@gmx.at> <87oew7g4m9.fsf@canaima.chapus.net>
	<s5h7k2u93l7.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h7k2u93l7.wl@alsa2.suse.de> (Takashi Iwai's message of "Fri,
 24 Oct 2003 15:18:12 +0200")
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

This is from a thread about two weeks old. Didn't respond before because
was trying the suggestion you provided (see below.)

Takashi Iwai <tiwai@suse.de> writes:

> then it sounds like the specific problem for cs46xx driver.

That's a possibility, although I don't have another card to test the
theory.

> i guess some drift occured during the sample rate conversion or so.
> please check whether the same symptom happens on 48000Hz ?

I set the sample rate to 48 KHz, and while the problem still happens
sporadically it happens a *lot* less than when the rate was 32 KHz.

Does this offer any clues? Do you have any debugging suggestions to try
to pinpoint the problem, like printk's in some places, etc.?

Cheers,

Eloy.-


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
