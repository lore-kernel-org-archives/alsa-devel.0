From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: future ALSA development
Date: Tue, 24 Jun 2003 10:14:48 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0306241001410.1838-100000@pnote.perex-int.cz>
References: <3EF77D90.5080209@folkwang-hochschule.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (UNKNOWN@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id KAA25805
	for <alsa-devel@alsa-project.org>; Tue, 24 Jun 2003 10:15:27 +0200
In-Reply-To: <3EF77D90.5080209@folkwang-hochschule.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Joern Nettingsmeier <nettings@folkwang-hochschule.de>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 24 Jun 2003, Joern Nettingsmeier wrote:

> Jaroslav Kysela wrote:
>  >>
>  >>other people might propose XML.  then it becomes to a question whether
>  >>alsa-lib should rely on other libs...
>  >
>  >
>  > I think that XML is too overkill for our purposes.
> 
> true if you only consider alsa. but on most systems, libxml2 is there 
> anyway. <underwear type="asbestos">and imvho xml is less a matter of 
> taste than lisp.</underwear> and xml is way easier to handle in other 
> contexts (i'm thinking of auto.configuration stuff etc.)
> otoh, the embedded guys will probably not like it, but then memory is 
> becoming cheaper by the minute, and its additional size will be a moot 
> point in the very near future.

Note that I do not want to squash the current configuration syntax at all.
I only want to extend the parsing and runtime evaluation of given 
configuration, because we need to describe complex things. I really think 
that XML is not a good choice at the moment for this job and if we use 
XML, we must define some language as well.

I am trying to rewrite some runtime evaluation parts of alsa.conf:

Original code:

# pre-load the configuration files

@hooks [
        {
                func load
                files [
                        "/etc/asound.conf"
                        "~/.asoundrc"
                ]
                errors false
        }
]

New code:

# pre-load the configuration files

@elisp "
        (load-conf \"/etc/asound.conf\" 0)
        (load-conf \"~/.asoundrc\" 0)
"

I think that it is much readable, is not?

More complicated example (original code as first):

# load card-specific configuration files (on request)

cards.@hooks [
        {
                func load
                files [
                        {
                                @func concat
                                strings [
                                        { @func datadir }
                                        "/cards/aliases.conf"
                                ]
                        }
                ]
        }
        {
                func load_for_all_cards
                files [
                        {
                                @func concat
                                strings [
                                        { @func datadir }
                                        "/cards/"
                                        { @func private_string }
                                        ".conf"
                                ]
                        }
                ]
                errors false
        }
]

New code:

# load card-specific configuration files (on request)

cards.@elisp "
        (load-conf (concat (data-dir) \"/cards/aliases.conf\") 0)
        (defun load-conf-all (card)
                (when (> card -1)
                        ((load-conf (concat (data-dir) "/cards/\" (driver card) \".conf\") 0)
                         (setq card (next-card card)))
                )
        )
        (load_conf_all (next-card -1))
"

There is much better view, what we need:

1) loops
2) conditions

Also, in this way, we can define only primitives and describe the main 
loops in lisp which is more universal.

Note: There may be a syntax error, because I am using lisp for the 
first time.

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
