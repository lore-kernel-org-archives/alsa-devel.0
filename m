From: =?iso-8859-1?q?Chris=20Rankin?= <rankincj@yahoo.com>
Subject: Re: 0.9.0rc4 release - D-1
Date: Mon, 21 Oct 2002 20:46:13 +0100 (BST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021021194613.94050.qmail@web40603.mail.yahoo.com>
References: <Pine.LNX.4.33.0210212057560.712-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from web40603.mail.yahoo.com (web40603.mail.yahoo.com [66.218.78.140])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id VAA19300
	for <alsa-devel@alsa-project.org>; Mon, 21 Oct 2002 21:46:51 +0200
In-Reply-To: <Pine.LNX.4.33.0210212057560.712-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

 --- Jaroslav Kysela <perex@suse.cz> wrote: > Hi all,
> 
> 	I've just commited to CVS last change for 0.9.0rc4
> (one day to
> launch). I'm sorry for this, but I definitely forgot
> this topic. As we
> discussed on the list, I've made the change for
> module options from
> 'snd_xxxx to xxxx'. Please, if you can, test these
> changes and report any
> fatal problems (compilation, wrong behaviour,
> description, etc...). Thank
> you very much and have fun with ALSA.

Oooch!

# modprobe snd
/lib/modules/2.4.19/kernel/drivers/sound/snd.o:
unresolved symbol snd_device_gid
/lib/modules/2.4.19/kernel/drivers/sound/snd.o:
unresolved symbol snd_device_uid
/lib/modules/2.4.19/kernel/drivers/sound/snd.o:
unresolved symbol snd_device_mode
/lib/modules/2.4.19/kernel/drivers/sound/snd.o:
unresolved symbol snd_major
/lib/modules/2.4.19/kernel/drivers/sound/snd.o: insmod
/lib/modules/2.4.19/kernel/drivers/sound/snd.o failed
/lib/modules/2.4.19/kernel/drivers/sound/snd.o: insmod
snd failed

Cheers,
Chris


__________________________________________________
Do You Yahoo!?
Everything you'll ever need on one web page
from News and Sport to Email and Music Charts
http://uk.my.yahoo.com


-------------------------------------------------------
This sf.net emial is sponsored by: Influence the future 
of  Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ad.doubleclick.net/clk;4699841;7576298;k?http://www.sun.com/javavote
