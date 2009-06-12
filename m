From: bill@tellytopia.com
Subject: Re: SB X-Fi driver fixes (Re: Testers wanted:
Date: Thu, 11 Jun 2009 21:32:17 -0700
Message-ID: <20090611213217.511367190d6e5c5c661eac68a9a86d95.97e5d99a94.wbe@email.secureserver.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpoutwbe05.prod.mesa1.secureserver.net
	(smtpoutwbe05.prod.mesa1.secureserver.net [208.109.78.207])
	by alsa0.perex.cz (Postfix) with SMTP id 60FBA24498
	for <alsa-devel@alsa-project.org>;
	Fri, 12 Jun 2009 06:32:54 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Gernot Kohlhaas <gernot.kohlhaas@googlemail.com>
List-Id: alsa-devel@alsa-project.org

Looking at the board, it is model SB1040, with
CA0110-IBG LF chip.
Is that an hda type chip?

> -------- Original Message --------
> Subject: Re: [alsa-devel] SB X-Fi driver fixes (Re: Testers wanted:
> From: Takashi Iwai <tiwai@suse.de>
> Date: Thu, June 11, 2009 6:54 pm
> To: bill@tellytopia.com
> Cc: "Gernot Kohlhaas" <gernot.kohlhaas@googlemail.com>,
> alsa-devel@alsa-project.org
> At Thu, 11 Jun 2009 14:28:02 -0700,
> bill@tellytopia.com wrote:
> > 
> > Yes, I have loaded the module snd-ctfxi many times,
> > and unloaded snd-hda-intl.
> > Also blacklisted snd-hda-intel, and put snd-ctxfi into modprobe.conf.
> Are you sure that your board has really emu20k1 or emu20k2 chip?
> X-Fi isn't always with these chips.  Some are HD-audio only (thus
> snd-hda-intel is the right driver) and some are with CA0106 chip.
> Takashi
