From: Gary Scavone <gary@ccrma.Stanford.EDU>
Subject: Re: alsa error /dev/snd/pcmC1D1c failed: No such file or directory
Date: Fri, 19 Jul 2002 15:41:58 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0207191534050.32511-100000@cmn24.stanford.edu>
References: <Pine.LNX.4.44.0207191513050.10155-100000@cmn18.stanford.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from cm-mail.stanford.edu (cm-mail.Stanford.EDU [171.64.197.135])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id AAA02389
	for <alsa-devel@alsa-project.org>; Sat, 20 Jul 2002 00:42:36 +0200
Received: from cmn24.stanford.edu (cmn24.stanford.edu [171.64.197.173])
	by cm-mail.stanford.edu (8.11.6/8.11.6) with ESMTP id g6JMfwL13795
	for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2002 15:41:58 -0700
Received: from localhost (localhost [127.0.0.1])
	by cmn24.stanford.edu (8.11.6/8.11.6) with ESMTP id g6JMfwN00433
	for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2002 15:41:58 -0700
In-Reply-To: <Pine.LNX.4.44.0207191513050.10155-100000@cmn18.stanford.edu>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


ALSA lib pcm_hw.c:797:(snd_pcm_hw_open) open /dev/snd/pcmC1D1c failed:
No such file or directory


This message automatically gets output by the alsa library when you
call snd_pcm_open with SND_PCM_STREAM_CAPTURE on a device which can
only provide output (such as the second device of the ensoniq 1370).  
Since you cannot probe a device's capabilities without opening it, it
seems to me that the library should not automatically print this
message to stderr (or stdout).  Rather, the user can check the return
value of the call and get an error string if desired.

The current behavior is very confusing.

-------------------------------------------------
Gary Scavone
Center for Computer Research in Music & Acoustics
Stanford University
gary@ccrma.stanford.edu
http://www-ccrma.stanford.edu/~gary/
-------------------------------------------------



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
