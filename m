From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: hammerfall_mem.c - obsolete - to be removed
Date: Fri, 06 Jun 2003 10:25:44 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200306061434.QAA03910@alsa.alsa-project.org>
References: <s5hptlrjszx.wl@alsa2.suse.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail08.voicenet.com (mail08.voicenet.com [207.103.0.34])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id QAA03910
	for <alsa-devel@alsa-project.org>; Fri, 6 Jun 2003 16:34:38 +0200
In-reply-to: Your message of "Fri, 06 Jun 2003 14:22:10 +0200."
             <s5hptlrjszx.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@suse.cz>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>> 	I think that hammerfall_mem.c should be removed from the ALSA 
>> tree, because we have unified preallocation / buffer cache system in 
>> the snd-page-alloc module (alsa-kernel/core/memalloc.c) which 
>> completely replaces the original single purpose code.
>
>yep, the only thing to do is to test and debug it :)

and to verify that it has no dependencies on any other module ...


-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
