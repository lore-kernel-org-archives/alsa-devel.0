From: Knut J Bjuland <knutjbj@online.no>
Subject: Re: Re: [Alsa-user] alsa cvs, redhat9, kernel 2-4-20-9
Date: Tue, 15 Apr 2003 08:47:15 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E9BAAF2.177D8685@online.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

There is still unresolved symbols in alsa cvs aginst kernel 2.4.20-9.


Starting sound driver: snd-emu10k1
/lib/modules/2.4.20-9SGI_XFS_1.2.0custom/kernel/sound/acore/snd.o:
unresolved symbol schedule_work
/lib/modules/2.4.20-9SGI_XFS_1.2.0custom/kernel/sound/acore/snd.o:
insmod /lib/modules/2.4.20-9SGI_XFS_1.2.0custom/kernel/sound/acore/snd.o
failed
/lib/modules/2.4.20-9SGI_XFS_1.2.0custom/kernel/sound/acore/snd.o:
insmod snd-emu10k1 failed








Re: [Alsa-devel] Re: [Alsa-user] alsa cvs, redhat9, kernel 2-4-20-8

    * From: Takashi Iwai
    * Subject: Re: [Alsa-devel] Re: [Alsa-user] alsa cvs, redhat9,
kernel 2-4-20-8
    * Date: Mon, 07 Apr 2003 08:45:07 -0700

At Mon, 7 Apr 2003 12:27:53 +0200,
Matthias Saou wrote:
>
> Takashi Iwai <[EMAIL PROTECTED]> wrote :
>
> > the current alsa code checks the existence of __WORK_INITIALIZER
> > macro.  if it's defined, no wrapper function is used.
> > in rh's include/linux/workqueue.h, is this macro defined?
>
> Yes, it is... from /usr/src/linux-2.4.20-x/include/linux/workqueue.h:
>
> #define __WORK_INITIALIZER(n, f, d) {                           \
>         .entry  = { &(n).entry, &(n).entry },                   \
>         .func = (f),                                            \
>         .data = (d) }

hmm, then it should be ok.  the configure and make should work without
any patches.

did anyone build successfully with RH9 and RH's kernel?


Takashi


-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb:
Dedicated Hosting for just $79/mo with 500 GB of bandwidth!
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
_______________________________________________
Alsa-devel mailing list
[EMAIL PROTECTED]
https://lists.sourceforge.net/lists/listinfo/alsa-devel




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
