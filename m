From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: snd_ prefix for module options
Date: Wed, 9 Oct 2002 08:03:44 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0210090802170.519-100000@pnote.perex-int.cz>
References: <20021008224446.26961.qmail@web40611.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20021008224446.26961.qmail@web40611.mail.yahoo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: =?iso-8859-1?q?Chris=20Rankin?= <rankincj@yahoo.com>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 8 Oct 2002, [iso-8859-1] Chris Rankin wrote:

>  --- Takashi Iwai <tiwai@suse.de> wrote: > Hi,
> > so, i'd like to ask you how do you think to remove
> > this snd_ prefix.
> > of course, there is one and only big problem -
> > compatibility!
> 
> I think it's a worthy goal. It's just noise in
> modules.conf, of course. Irritating, but no more than
> that. What concerns me more is when you compile ALSA
> directly into the kernel. To pass the options NOW
> requires a boot-time parameter list:
> 
> alsa-module-name=snd_this=x,snd_that=y,snd_the_other=z

No, it should be: alsa-module-name=x,y,z . The prefix for alsa-module-name 
is required, because we have collisions with OSS drivers.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
