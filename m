From: Paul Davis <pbd@op.net>
Subject: Re: should i be able to abort in the middle of snd_pcm_mmap_{begin,commit} ?
Date: Wed, 13 Feb 2002 12:53:15 -0500
Message-ID: <200202131758.MAA13972@renoir.op.net>
Received: from renoir.op.net (root@renoir.op.net [207.29.195.4])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id SAA22790
	for <alsa-devel@alsa-project.org>; Wed, 13 Feb 2002 18:58:10 +0100
In-reply-to: Your message of "Wed, 13 Feb 2002 18:44:43 +0100."
             <Pine.LNX.4.31.0202131842190.495-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Jaroslav Kysela <perex@perex.cz>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>> should it work for me to call snd_pcm_drop() for both playback and
>> capture streams if i'm in the middle of a snd_pcm_mmap_{begin,commit}
>> pair?
>
>Nope. Do you think that we need to lock these related code blocks in
>alsa-lib for threaded applications or leave this locking for application
>coders?

leave it for applications.

but here's the problem. i'm in the middle of an mmap_{begin,commit}
pair, and i realize that i've caused a xrun (e.g. because i waited too
long via poll(2) for something else to happen). there's no point
calling mmap_commit() at this point, since i know i don't have any
data to commit and i know i'm too late. what i want to do is to stop
the interface, and then restart it from scratch. so, i am effectively
doing:

    poll
    snd_pcm_mmap_begin();
    snd_pcm_mmap_commit();
    poll
    snd_pcm_mmap_begin();
    ... realize things have gone wrong ...
    snd_pcm_drop();
    snd_pcm_prepare();
    snd_pcm_start ();
    poll
    snd_pcm_mmap_begin();
    snd_pcm_mmap_commit();

i would have expected snd_pcm_drop() to effectively shut down the
driver, or at least for snd_pcm_drop() and snd_pcm_prepare() to get it
back to a "pristine" state again.

so, how should i handle such a condition?

--p


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
