From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Re: alsa error /dev/snd/pcmC1D1c failed: No such
 file or directory
Date: Wed, 24 Jul 2002 20:48:31 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0207242047110.578-100000@pnote.perex-int.cz>
References: <Pine.LNX.4.44.0207231541230.6752-100000@cmn24.stanford.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id UAA25642
	for <alsa-devel@alsa-project.org>; Wed, 24 Jul 2002 20:48:39 +0200
In-Reply-To: <Pine.LNX.4.44.0207231541230.6752-100000@cmn24.stanford.edu>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Gary Scavone <gary@ccrma.Stanford.EDU>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 23 Jul 2002, Gary Scavone wrote:

> 
> OK, I changed my code to do as you suggested (using the ctl interface)  
> and that works.  Thanks for the info.
> 
> However, I still feel that my original gripe (the error message
> output) is valid.  In all other cases that I'm aware of, you never
> automatically spit out an error message to stderr or stdout.  Why 
> should it be different in this case?  There is an error retrieval 
> mechanism in place, namely snd_strerror().
> 
> So, what is the validation for automatically printing an error for the 
> function snd_pcm_open() and not, for example, for 
> snd_pcm_hw_params_any()?  Why can I not determine whether a device can 
> handle input by attempting to open it with the appropriate stream 
> without incurring this error message?

Have you realized, that we have snd_lib_error_set_handler() function? If 
you create an empty callback, you'll get no error messages. I think that 
the default behaviour is good for command-line tools.

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
