From: "Mark Knecht" <mknecht@controlnet.com>
Subject: RE: hammerfall_mem.c - obsolete - to be removed
Date: Fri, 6 Jun 2003 06:40:50 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <NDBBLGIKBJENLAMOLFHGAEKACGAB.mknecht@controlnet.com>
References: <Pine.LNX.4.44.0306061358020.2783-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from vivaldi.controlnet.com (hidden-user@mail.controlnet.com [199.108.40.159])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id PAA03236
	for <alsa-devel@alsa-project.org>; Fri, 6 Jun 2003 15:54:16 +0200
In-Reply-To: <Pine.LNX.4.44.0306061358020.2783-100000@pnote.perex-int.cz>
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

Jaroslav,
   Is this true with Alsa 0.9.4? Should I remove the loading of this module?

Thanks,
Mark

> -----Original Message-----
> From: alsa-devel-admin@lists.sourceforge.net
> [mailto:alsa-devel-admin@lists.sourceforge.net]On Behalf Of Jaroslav
> Kysela
> Sent: Friday, June 06, 2003 5:06 AM
> To: ALSA development
> Cc: Paul Davis; Takashi Iwai
> Subject: [Alsa-devel] hammerfall_mem.c - obsolete - to be removed
>
>
> Hi,
>
> 	I think that hammerfall_mem.c should be removed from the ALSA
> tree, because we have unified preallocation / buffer cache system in
> the snd-page-alloc module (alsa-kernel/core/memalloc.c) which
> completely replaces the original single purpose code.
>
> 						Jaroslav
>
> -----
> Jaroslav Kysela <perex@suse.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, SuSE Labs
>
>
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
> thread debugger on the planet. Designed with thread debugging features
> you've never dreamed of, try TotalView 6 free at www.etnus.com.
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
>
>




-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
