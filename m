From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: Re: alsa error /dev/snd/pcmC1D1c failed: No such
	file or directory
Date: Tue, 23 Jul 2002 16:00:53 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200207232300.QAA23694@cmn29.stanford.edu>
References: <Pine.LNX.4.44.0207231541230.6752-100000@cmn24.stanford.edu>
Mime-Version: 1.0 (NeXT Mail 3.3 v148.2.1)
Content-Type: text/plain
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from cm-mail.stanford.edu (cm-mail.Stanford.EDU [171.64.197.135])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id BAA11709
	for <alsa-devel@alsa-project.org>; Wed, 24 Jul 2002 01:01:27 +0200
In-Reply-To: <Pine.LNX.4.44.0207231541230.6752-100000@cmn24.stanford.edu>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: gary@ccrma.Stanford.EDU
List-Id: alsa-devel@alsa-project.org

> However, I still feel that my original gripe (the error message
> output) is valid.  In all other cases that I'm aware of, you never
> automatically spit out an error message to stderr or stdout.  Why
> should it be different in this case?  There is an error retrieval
> mechanism in place, namely snd_strerror().

I agree, I don't think that the library should be printing
anything at all (except for temporary debugging assert's or
things like that, I guess - maybe this is just debugging code
that will go away soon). The library should interact with the
user through the error messages it returns from the api calls.

-- Fernando


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
