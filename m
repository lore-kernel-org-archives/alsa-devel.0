From: Remy Bruno <remy.bruno@libertysurf.fr>
Subject: How to change hwparams of a device?
Date: Wed, 30 Oct 2002 14:48:11 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021030144811.A13883@immersivesound.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello,

I'm developping an application where I sometimes have to change the hwparams
(or swparams) of an opened pcm device (playback or capture). At first, I
thought the simpler way to do that was to close the stream and reopen it. But 
with alsa-0.9.0beta10a, closing and re-opening the device caused a crash, so I
finaly managed to do this with snd_pcm_hw_free and with a re-alloc of hwparams.
It seemed to work rather good, but I still got crashes from times to times wich
I suspect came from that. I upgraded to alsa-0.9.0rc5, and now this solution
doesn't work at all any longer. So the sequence leading to a crash is:
* open playback
* alloc and init hwparams for playback
* Possibly play sound
* open capture
* alloc and init hwparams for capture
* free hwparams for playback
* alloc and init hwparams for playback  <= the crash is here, the function
   snd_pcm_hw_params() aborts with :
   fts: pcm.c:6273: snd_pcm_unlink_ptr: Assertion `0' failed.
   Apparently, it comes from an object which is not found in a list where it
   should be in snd_pcm_unlink_ptr.

What is the right way to do things like this?

Another question, linked with that: the snd_pcm_link function can only be
called in a given state (I don't remember exactly, maybe it is SETUP?), so when
a stream has already been played, it is not in the right state (even if I stop
it). So, I had to free the hwparams, then re-alloc and init hwparams with the
same parameters so that the stream can be linked with another stream. Is there
another simpler solution? (moreover, this solution doesn't work any longer
because of the problem explained above)

The reason why I do like this is that the user (of my application) decides if
he opens another stream, or if he wants to change parameters, or if he wants to
link streams together during the program execution, so I can't do all the inits
at the begining.

Thanks in advance.

Best regards,

Remy Bruno


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
