From: Paul Davis <pbd@op.net>
Subject: Re: poll_descriptors_count
Date: Mon, 01 Jul 2002 07:40:38 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E17OzWO-0003TU-00@usw-sf-list1.sourceforge.net>
References: <20020701024100.GG18519@reverberate.org>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Sun, 30 Jun 2002 19:41:03 PDT."
             <20020701024100.GG18519@reverberate.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Joshua Haberman <joshua@haberman.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>int snd_pcm_poll_descriptors_count(snd_pcm_t *pcm)
>{
>    assert(pcm);
>    return 1;
>}
>
>I don't understand: why the abstraction for the number of poll
>descriptors when it is always 1?  What could change in the future to
>require more poll descriptors per stream?

it could already return more than 1 if the implementation of the
"shared" PCM type was altered. its that kind of reason that explains
the use of the abstraction, i think.

>Also, how should programs interpret multiple poll descriptors: if the
>poll succeeds on some descriptors but not others, does this mean the
>stream is only "partially" ready?

yes. see the internals of JACK's jack/drivers/alsa/alsa_driver.c

>Also, is snd_pcm_poll_descriptors_revents() understood to return the
>events that have triggered on just *one* poll descriptor or on *all*?  In
>other words, are you ANDing bitmasks or ORing them?  Right now the
>semantics are impossible to deduce because the function just returns the
>revents verbatim since there is only one poll descriptor.

The semantics are those of POSIX poll(2): it returns the status for
each file descriptor. ALSA's low level and mid level drivers don't
modify this in anyway. If there 3 fd's for playback and 2 for capture,
then the return data would indicate status for each of the 5 fd's
(assuming you asked for it for all 5).

--p



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
