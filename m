From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: future ALSA development
Date: Tue, 24 Jun 2003 13:56:48 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0306241352410.1838-100000@pnote.perex-int.cz>
References: <200306241136.NAA28437@alsa.alsa-project.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (UNKNOWN@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id NAA28753
	for <alsa-devel@alsa-project.org>; Tue, 24 Jun 2003 13:57:30 +0200
In-Reply-To: <200306241136.NAA28437@alsa.alsa-project.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Joern Nettingsmeier <nettings@folkwang-hochschule.de>, Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 24 Jun 2003, Paul Davis wrote:

> this is just another version of the kind of embedded quoting nightmare
> that we all face when using shell scripts. the right form is:
> 
> (defun cards
>         (load-conf (concat (data-dir) "/cards/aliases.conf") 0)
>         (defun load-conf-all (card)
>                 (when (> card -1)
>                         ((load-conf (concat (data-dir) "/cards/" 
> 				    (driver card) ".conf") 0)
>                          (setq card (next-card card)))
>                 )
>         )
>         (load_conf_all (next-card -1))
> )
> 
> Now *that's* elegant!
> 
> LISP can do everything that the existing language can do, it can do it
> better, more flexibly, and more generically. I can see no
> justification for making them both coexist. Either do the right thing
> and use LISP or continue to hack the existing language "into
> shape". Please. 

There are two differences between lisp and alsa configuration language.
Lisp is standard dynamic language but the ALSA configuration is static
(if you ommit the runtime evaluation hacks added to enhance functinality).

It is something similar like "HTML" and "Java script". The first one is 
good to describe the static part of web pages, but if you want something 
dynamic, you have to use another embeded language.

Note that 'cards.@elisp "code"' part expands the whole cards tree to 
(example):

cards.pcm.EMU10K1.front { EMU10K1.specific.configuration.is.here }
cards.pcm.YMFPCI.rear { YMFPCI...... }
						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
