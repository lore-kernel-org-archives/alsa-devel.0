From: Lee Revell <rlrevell@joe-job.com>
Subject: [Fwd: Re: [MPlayer-dev-eng] AV out of sync with "-ao alsa" in
 gmplayer, mplayer works ok]
Date: Wed, 29 Dec 2004 04:11:14 -0500
Message-ID: <1104311474.2984.2.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
Cc: Reimar.Doeffinger@stud.uni-karlsruhe.de
List-Id: alsa-devel@alsa-project.org

OK, I trolled the mplayer dev list, and got this response. ;-)

Are Reimar's statements about memory leaks valid?

Lee

-------- Forwarded Message --------
From: Reimar Döffinger <Reimar.Doeffinger@stud.uni-karlsruhe.de>
Reply-To: mplayer-dev-eng@mplayerhq.hu
To: mplayer-dev-eng@mplayerhq.hu
Subject: Re: [MPlayer-dev-eng] AV out of sync with "-ao alsa" in
gmplayer, mplayer works ok
Date: Wed, 29 Dec 2004 09:41:01 +0100
Hi,
On Tue, Dec 28, 2004 at 10:55:33PM -0500, Lee Revell wrote:
> Using 1.0pre6, "gmplayer -ao alsa" results in the sound and video being
> out of sync.  "mplayer -ao alsa" works fine, as does "-ao oss" with
> either mplayer or gmplayer.

Are you sure this isn't caused either by different settings in gmplayer
or because the computer is too slow? Please provide a full -v log.

> This is quite annoying, as I was expecting to FINALLY have a gmplayer
> release usable with ALSA.  Previous versions were unusable due to that
> stupid "/dev/mixer" bug.
> 
> What's the deal?  Why is it so hard for the mplayer developers to get
> ALSA support right?  I hack on ALSA a lot, so if there is some problem
> with the ALSA API, we would like to hear about it on the mailing list.

Yes, please fix the huge memory leak with ALSA output, especially when
changing the volume (it is cause by the call to snd_mixer_load, but I
couldn't find an ALSA function that frees that memory again
snd_mixer_free has absolutely no effect :-( ).
Also the problem is more that the Gui is not well supported.

> Or do you all just use OSS still?

The OSS interface is actually a lot nicer, so yes it is supported better.

> From the users perspective things like this make ALSA look bad, while
> the problem is really with gmplayer's shoddy ALSA support.

>From what I saw of ALSA as a developer it is bad, but that's a bit of
personal opinion of course. What I refer to is very slow software mixing, no way to use it
without getting into synchronization hell because it uses threads,
hundreds of function calls to initialize it, and those memory leaks that
to my best knowledge seem to come from the alsa lib (my best guess is
that this is because like in conf.c, in _snd_config_make pointers
are overwritten without being freed first).
What makes it a bit difficult to use it that it's quite difficult to
find the function that is supposed to free things again, they e.g.
often aren't located directly below the allocation function in the
headers, and that there is a snd_mixer_load function but no
snd_mixer_unload as I would expect it.
All these things together made me give up on ALSA.

Greetings,
Reimar Döffinger

_______________________________________________
MPlayer-dev-eng mailing list
MPlayer-dev-eng@mplayerhq.hu
http://mplayerhq.hu/mailman/listinfo/mplayer-dev-eng




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
