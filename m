From: =?iso-8859-1?q?Chris=20Rankin?= <rankincj@yahoo.com>
Subject: Re: snd_ prefix for module options
Date: Wed, 9 Oct 2002 10:02:25 +0100 (BST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021009090225.92283.qmail@web40601.mail.yahoo.com>
References: <Pine.LNX.4.33.0210090802170.519-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.33.0210090802170.519-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

 --- Jaroslav Kysela <perex@suse.cz> wrote: > On Tue,
8
>
alsa-module-name=snd_this=x,snd_that=y,snd_the_other=z
> 
> No, it should be: alsa-module-name=x,y,z . The
> prefix for alsa-module-name 
> is required, because we have collisions with OSS
> drivers.

I'm not talking about "snd" on the alsa-module-name,
which is why I wrote it as "alsa-module-name" in the
above example in the first place. I am referring to
all the options "snd_index", "snd_enabled" etc.

If the option names are not required on the kernel
command line, then can I assume that you can safely
omit any that you don't want to specify by writing:

alsa-module-name=1,0,,,10

for example?

Chris


__________________________________________________
Do You Yahoo!?
Everything you'll ever need on one web page
from News and Sport to Email and Music Charts
http://uk.my.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
