From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: future ALSA development
Date: Tue, 24 Jun 2003 07:43:25 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200306241136.NAA28437@alsa.alsa-project.org>
References: <Pine.LNX.4.44.0306241001410.1838-100000@pnote.perex-int.cz>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail09.voicenet.com (mail09.voicenet.com [207.103.0.43])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id NAA28437
	for <alsa-devel@alsa-project.org>; Tue, 24 Jun 2003 13:36:47 +0200
In-reply-to: Your message of "Tue, 24 Jun 2003 10:14:48 +0200."
             <Pine.LNX.4.44.0306241001410.1838-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Joern Nettingsmeier <nettings@folkwang-hochschule.de>, Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>@hooks [
>        {
>                func load
>                files [
>                        "/etc/asound.conf"
>                        "~/.asoundrc"
>                ]
>                errors false
>        }
>]
>
>New code:
>
># pre-load the configuration files
>
>@elisp "
>        (load-conf \"/etc/asound.conf\" 0)
>        (load-conf \"~/.asoundrc\" 0)
>"
>
>I think that it is much readable, is not?

slightly. but why on earth embed LISP within the existing language?
you now make users (and programmers working on alsa-lib) deal with
**TWO** languages. 

and just look at this ugliness:

>cards.@elisp "
>        (load-conf (concat (data-dir) \"/cards/aliases.conf\") 0)
>        (defun load-conf-all (card)
>                (when (> card -1)
>                        ((load-conf (concat (data-dir) "/cards/\" (driver card
>) \".conf\") 0)
>                         (setq card (next-card card)))
>                )
>        )
>        (load_conf_all (next-card -1))
>"

this is just another version of the kind of embedded quoting nightmare
that we all face when using shell scripts. the right form is:

(defun cards
        (load-conf (concat (data-dir) "/cards/aliases.conf") 0)
        (defun load-conf-all (card)
                (when (> card -1)
                        ((load-conf (concat (data-dir) "/cards/" 
				    (driver card) ".conf") 0)
                         (setq card (next-card card)))
                )
        )
        (load_conf_all (next-card -1))
)

Now *that's* elegant!

LISP can do everything that the existing language can do, it can do it
better, more flexibly, and more generically. I can see no
justification for making them both coexist. Either do the right thing
and use LISP or continue to hack the existing language "into
shape". Please. 

--p



-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
