From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: Re: [PATCH RFC 2/4] ALSA: Add RME MADI FX Kconfig
	entries
Date: Sun, 03 Feb 2013 12:52:28 +0100
Message-ID: <510E4F7C.90904@drcomp.erfurt.thur.de>
References: <1359722921-18769-1-git-send-email-adi@drcomp.erfurt.thur.de>
 <1359722921-18769-2-git-send-email-adi@drcomp.erfurt.thur.de>
 <1359722921-18769-3-git-send-email-adi@drcomp.erfurt.thur.de>
 <20130202161636.23c04179@rvllap.ps13>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ltw.loris.tv (ltw.loris.tv [188.40.101.23])
 by alsa0.perex.cz (Postfix) with ESMTP id E293E2615C0
 for <alsa-devel@alsa-project.org>; Sun,  3 Feb 2013 12:52:29 +0100 (CET)
In-Reply-To: <20130202161636.23c04179@rvllap.ps13>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andre Schramm <andre.schramm@iosono-sound.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, Feb 02, 2013 at 04:16:36PM +0100, Andre Schramm wrote:

Hi!

> > +config SND_MADIFX
> > +	tristate "RME Hammerfall DSP MADI FX"
> > +	select SND_HWDEP
> > +	select SND_RAWMIDI
> > +	select SND_PCM
> > +	help
> > +	  Say Y here to include support for RME Hammerfall DSP MADI
> > FX
> > +	  soundcards.
> > +
> > +	  To compile this driver as a module, choose M here: the
> > module
> > +	  will be called snd-hdspm.
> > +
> Should this be "snd-madifx"?

Of course. Copy&paste error, thanks for spotting. Fixed.

> Also, the the mail on patch 4/4 seems to be lost - can you resend it?

Weird, it was in my backup (cause I was automatically CCed), but neither
gmane nor you received it.

I've resent it. Let's see.



Cheers

-- 
mail: adi@thur.de  	http://adi.thur.de	PGP/GPG: key via keyserver
