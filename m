From: Paul Davis <pbd@op.net>
Subject: Re: another control API issue
Date: Wed, 08 May 2002 09:07:17 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200205081306.g48D6VD04392@post2.fast.net>
References: <3CD9216E.BB354D6A@alsa-project.org>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Wed, 08 May 2002 15:00:30 +0200."
             <3CD9216E.BB354D6A@alsa-project.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Abramo Bagnara <abramo@alsa-project.org>
Cc: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>
List-Id: alsa-devel@alsa-project.org

>I expected something similar. Don't you think that to have a FLOAT type
>is a better choice (more card independent, more accessible, more
>representative, etc.).

Well, that was my initial thought. Then I remembered that we can't
have floating point code in the kernel, and its therefore unsafe to
even use this data type (an interrupt in kernel mode doesn't result in
an FP register restore, and we may have run another task in the
meantime that used the FP registers before we get back to our code).

In this particular case, even if it was safe to store the value in a
float, the actual float value has to be computed with FP math, which
is definitely not available in the kernel. so it wouldn't help much
here.

Sound right?

--p

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
