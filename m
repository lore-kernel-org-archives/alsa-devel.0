From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: handling of dmix and non-dmix in the same
 configuration file
Date: Fri, 22 Feb 2008 14:50:18 +0100
Message-ID: <47BED31A.606@ladisch.de>
References: <200802211804.39684.vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id B5A4D245DC
	for <alsa-devel@alsa-project.org>; Fri, 22 Feb 2008 14:48:31 +0100 (CET)
In-Reply-To: <200802211804.39684.vapier@gentoo.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mike Frysinger wrote:
> [...]
> but now we want to support dmix/dsnoop.  the overhead for dmix vs non-dmix is
> such that we make it optional.  if the user does not need software mixing,
> they can disable this overhead.  this leads to two (incompatible) alsa config
> files (in this case, for the AD1980 codec).  we're wondering if it's possible
> to have the right settings selected on the fly some how during runtime rather
> than having to select one file or the other.

Let's assume we have the following definitions:

AD1980.pcm.default_dmix_yes {
    ...
}
AD1980.pcm.default_dmix_no {
    ...
}

Then we can select one of them based on a setting in some configuration
file:

AD1980.pcm.default {
    @args [ CARD ]
    @args.CARD { type string }
    @func refer
    name {
        @func concat
        strings [
            "cards.AD1980.pcm.default_dmix_"
            {
                @func refer
                name defaults.use_AD1980_dmix
                default yes
            }
            ":CARD="
            $CARD
        ]
    }
}

To disable dmix, put the line
    defaults.use_AD1980_dmix no
into /etc/asound.conf or the user's ~/.asoundrc.

It is also possible to use the value of an environment variable:

AD1980.pcm.default {
    @args [ CARD ]
    @args.CARD { type string }
    @func refer
    name {
        @func concat
        strings [
            "cards.AD1980.pcm.default_dmix_"
            {
                @func getenv
                vars [ USE_AD1980_DMIX ]
                default yes
            }
            ":CARD="
            $CARD
        ]
    }
}

This environment variable must be set to "no" before starting the
respective application.

It is also possible to use the value of an environment variable but to
fall back to some configuration setting if the env var does not exist:

AD1980.pcm.default {
    @args [ CARD ]
    @args.CARD { type string }
    @func refer
    name {
        @func concat
        strings [
            "cards.AD1980.pcm.default_dmix_"
            {
                @func getenv
                vars [ USE_AD1980_DMIX ]
                default {
                    @func refer
                    name defaults.use_AD1980_dmix
                    default yes
                }
            }
            ":CARD="
            $CARD
        ]
    }
}


HTH
Clemens
