From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Problem in alsaconf
Date: Fri, 5 Dec 2003 09:35:29 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0312050934240.12693@pnote.perex-int.cz>
References: <20031204234839.GB4760@steinchen.winterberg.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20031204234839.GB4760@steinchen.winterberg.local>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Sebastian Stein <seb.stein@hpfsc.de>
Cc: Takashi Iwai <tiwai@suse.de>, ondrejj@salstar.sk, Bernd Kaindl <bk@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 5 Dec 2003, Sebastian Stein wrote:

> I'm not sure who is the current maintainer of the alsaconf shell script in
> the alsa-utils-1.0.0rc1 package, so I'm sending this mail to all of you!
> 
> On startup I can see a message saying:
> 
> /usr/bin/alsaconf: line 29: [: too many arguments
> /usr/bin/alsaconf: line 31: [: too many arguments

It does not happen with:

GNU bash, version 2.05b.0(1)-release (i586-suse-linux)
and
grep (GNU grep) 2.5.1

Perhaps, you don't have grep installed?

> Also, there is another problem with finding the alsasound script
> ($rcalsasound). On my distro it can be found under
> /etc/rc.d/inet.d/alsasound. Maybe a better approach then fixed path would

Added new path. Thanks.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
