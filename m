From: Paul Davis <pbd@op.net>
Subject: Re: poll_descriptors_count
Date: Tue, 02 Jul 2002 08:39:42 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E17PMuv-0002CF-00@usw-sf-list1.sourceforge.net>
References: <Pine.LNX.4.33.0207020756030.523-100000@pnote>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Tue, 02 Jul 2002 08:01:18 +0200."
             <Pine.LNX.4.33.0207020756030.523-100000@pnote>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Joshua Haberman <joshua@haberman.com>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>> Jaroslav, is it true what Paul says about this function not being robust
>> in the case of multithreaded use and poll(2) errors?  Can it be made to
>> be more robust?
>
>Paul talks about snd_pcm_wait() function. True, it has limited 
>functionality and can be used only for simple applications.

this is correct - i wasn't referring to
snd_pcm_poll_descriptors_revents(), and in fact, i plan to make JACK
use this now that i see what it does.

>> Looking at the implementation I infer that
>> snd_pcm_poll_descriptors_revents() is not designed to handle pfds from
>> more than one stream.  Is that correct?
>
>Yes, but don't look to the implementation. It can slightly change in the 
>future. The wait_for_poll() function in alsa-lib/test/pcm.c does really 
>the correct poll sequence, so use this code and don't try to do things 
>differently than designed like Paul often does ;-)

The sequence is correct, but the implementation is missing some
important details. There is no test for poll return an error, such as
EINTR, which means that there is no way to get a thread running this
loop to exit without sending it SIGKILL, which pthreads doesn't do
unless explicitly asked to (pthread_kill(3)).

Secondly, the loop is based on waiting for poll() to return with a
given state (i.e. POLLIN or POLLOUT or POLLHUP set), and doesn't allow
for a timeout.

Finally, the use of wait_for_poll() in the test program is based on
non-duplex operation. Its significantly more complex to make this work
for duplex, since there are two PCM handles, and its not necessary (or
desirable) to be calling poll with the descriptors for both of them
each time. if you do, then there are many cases where poll(2) will
return immediately because one handle's descriptor(s) are ready right
away, while the other's are not. This is very inefficient. I see this
all the time with my trident and tropez+ hardware, and its been show
on ensoniq pci h/w as well. I suspect its actually true for most h/w
except the hammerfall and its cousins.

That's why the code in JACK's alsa_driver is so complex, because in
the default (full duplex case) its waiting for playback *and* capture
at the same time. it has to continually check whether one or other or
both streams are ready, and if one is not, then re-enter poll to wait
just for that stream, and not the other. If what JACK is doing is not
"as designed", then perhaps you could fill me in on the intended
method of handling this situation.

--p




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
