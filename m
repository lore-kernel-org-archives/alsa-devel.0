From: Paul Davis <pbd@op.net>
Subject: Re: poll_descriptors_count
Date: Mon, 01 Jul 2002 14:34:11 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E17P5yY-0006Se-00@usw-sf-list1.sourceforge.net>
References: <20020701171541.GA13023@reverberate.org>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Mon, 01 Jul 2002 10:15:42 PDT."
             <20020701171541.GA13023@reverberate.org>
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

>> yes. see the internals of JACK's jack/drivers/alsa/alsa_driver.c
>
>Honestly, I'm afraid to look at that file too carefully since it is GPL
>and PortAudio is BSD.  This puts me in kind of a weird situation.

nobody is going to come after you for an "extremely similar
implementation". the GPL doesn't prohibit intellectual inspiration -
you just can't copy & paste.

>> >Also, is snd_pcm_poll_descriptors_revents() understood to return the
>> >events that have triggered on just *one* poll descriptor or on *all*?  In
>> >other words, are you ANDing bitmasks or ORing them?  Right now the
>> >semantics are impossible to deduce because the function just returns the
>> >revents verbatim since there is only one poll descriptor.
>> 
>> The semantics are those of POSIX poll(2): it returns the status for

Drat! I missed that fact that you were talking about
snd_pcm_poll_descriptors_revents(), not poll(2) revents. 

I don't use this function at all, considering it something of it a
band-aid. 

>Are you saying that the revents paramter is treated as an array?  I was
>under the impression that it is treated as a pointer to a single short.
>This code fragment from test/pcm.c seems to confirm this interpretation:

You're right. But then again, I don't use wait_for_poll or the variant
on its theme that exists in alsa-lib, because its not written
correctly for multithreaded and some other code (mostly related to
handling errors while blocked on poll(2)).

>This gives me the impression that snd_pcm_poll_descriptors_revents() is a
>function that somehow "summarizes" all of the pfds into a single revents
>that speaks to the status of the entire PCM handle.

Yes, that's definitely the intent of the function.

--p







-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
