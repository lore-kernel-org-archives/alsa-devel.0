From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: snd_ prefix for module options
Date: Wed, 9 Oct 2002 12:33:32 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0210091231030.953-100000@pnote.perex-int.cz>
References: <20021009090225.92283.qmail@web40601.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20021009090225.92283.qmail@web40601.mail.yahoo.com>
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

On Wed, 9 Oct 2002, [iso-8859-1] Chris Rankin wrote:

>  --- Jaroslav Kysela <perex@suse.cz> wrote: > On Tue,
> 8
> >
> alsa-module-name=snd_this=x,snd_that=y,snd_the_other=z
> > 
> > No, it should be: alsa-module-name=x,y,z . The
> > prefix for alsa-module-name 
> > is required, because we have collisions with OSS
> > drivers.
> 
> I'm not talking about "snd" on the alsa-module-name,
> which is why I wrote it as "alsa-module-name" in the
> above example in the first place. I am referring to
> all the options "snd_index", "snd_enabled" etc.

Ok, the you distict between modules and kernel command line. Both have 
different syntax.

> If the option names are not required on the kernel
> command line, then can I assume that you can safely

Replace required with allowed. You have to specify all parameters "in
order".

> omit any that you don't want to specify by writing:
> 
> alsa-module-name=1,0,,,10
> 
> for example?

It's the right example.

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
