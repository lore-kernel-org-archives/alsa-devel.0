From: "Eduardo Valentin" <edubezval@gmail.com>
Subject: Re: 1.0.14rc1 release
Date: Mon, 11 Dec 2006 10:49:04 -0400
Message-ID: <a0580c510612110649y7b292775tb2a918af476979ca@mail.gmail.com>
References: <Pine.LNX.4.61.0612111444050.13335@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.170])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 16F2331B
	for <alsa-devel@alsa-project.org>; Mon, 11 Dec 2006 15:49:06 +0100 (MET)
Received: by ug-out-1314.google.com with SMTP id j3so1276953ugf
	for <alsa-devel@alsa-project.org>; Mon, 11 Dec 2006 06:49:05 -0800 (PST)
In-Reply-To: <Pine.LNX.4.61.0612111444050.13335@tm8103.perex-int.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Jaroslav Kysela <perex@suse.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello Jaroslav,

     I've just downloaded the 1.0.14rc1 alsa-plugins package and
cloned the alsa-plugins hg  repo too. There are some missing files in
the 1.0.14rc1 packages under the maemo directory:

hg/maemo:

alsa-dsp.c
constants.h
debug.h
dsp-ctl.c
dsp-protocol.c
dsp-protocol.h
list.h
Makefile.am
reporting.h
types.h

1.0.14rc1/maemo:
alsa-dsp.c
dsp-ctl.c
dsp-protocol.c
Makefile.am
Makefile.in


   This should generate errors during the compilation process.

Thanks,

Eduardo Valentin

On 12/11/06, Jaroslav Kysela <perex@suse.cz> wrote:
> Hi all,
>
>         I have just released the 1.0.14rc1 packages. Only one change from
> testing packages is to fix the alsa-plugins compilation for systems
> without DBUS. The full changelog is available here:
>
> http://www.alsa-project.org/changes/v1-0-13--v1-0-14rc1.txt
>
>                                         Enjoy,
>                                                 Jaroslav
>
> -----
> Jaroslav Kysela <perex@suse.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, SUSE Labs
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys - and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
>


-- 
Eduardo Bezerra Valentin

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
