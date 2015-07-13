From: Jonathan Woithe <jwoithe@just42.net>
Subject: Re: [FFADO-devel] [RFC][PATCH 32/37] ALSA:
 firewire-motu: add stream functionality
Date: Mon, 13 Jul 2015 20:53:21 +0930
Message-ID: <20150713112321.GD32641@marvin.atrad.com.au>
References: <1436623968-10780-1-git-send-email-o-takashi@sakamocchi.jp>
 <1436623968-10780-33-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.atrad.com.au (server.atrad.com.au [150.101.241.2])
 by alsa0.perex.cz (Postfix) with ESMTP id 041F42605A9
 for <alsa-devel@alsa-project.org>; Mon, 13 Jul 2015 13:23:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1436623968-10780-33-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On Sat, Jul 11, 2015 at 11:12:43PM +0900, Takashi Sakamoto wrote:
> +enum snd_motu_clock {
> +	SND_MOTU_CLOCK_INTERNAL = 0,
> +	SND_MOTU_CLOCK_OPT,		/* S/PDIF or ADAT */
> +	SND_MOTU_CLOCK_SPDIF_COAX,
> +	SND_MOTU_CLOCK_SPH,		/* SMPTE */
> +	SND_MOTU_CLOCK_ADAT_DSUB,
> +	SND_MOTU_CLOCK_AESEBU_XLR,
> +	SND_MOTU_CLOCK_WORD_BNC,
>  };

I'm not convinced that perpending the physical interface connection is all
that necessary because generally speaking the clock source uniquely implies
the physical connection.  Word clock is always on BNC, AES/EBU is always on
XRL, an SPDIF clock is assumed to be on coax and an "ADAT clock" is always
on the D-sub (it is common knowledge that this is different from an optical
clock).  I will concede that for qualifying the ADAT clock is justifiable to
avoid confusion (in FFADO I used ADAT_9PIN).  I also think that it is
unnecessary to abbreviate "optical" to "opt": there's no reason not to use 4
additional letters and "OPTICAL" is much clearer than "OPT" (the latter is
ambiguous and could be taken to be short for "optional" for example). 
Finally, the SMTPE clock should be called just this: the fact that it
happens to be transported via the SPH is largely irrelevant.  Using SMTPE in
the identifer makes the source entirely clear as to what's being done,
whereas SPH is rather vague.

Therefore I would suggest the following set of clock identifiers would be
perfectly adequate:

  SND_MOTU_CLOCK_INTERNAL
  SND_MOTU_CLOCK_OPTICAL
  SND_MOTU_CLOCK_SPDIF
  SND_MOTU_CLOCK_SMPTE
  SND_MOTU_CLOCK_ADAT_DSUB
  SND_MOTU_CLOCK_AESEBU
  SND_MOTU_CLOCK_WORDCLOCK

Regards
  jonathan
