From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Re: [Alsa-user] repost: audioio-alsa error
Date: Wed, 1 Oct 2003 08:52:41 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.53.0310010844390.13267@pnote.perex-int.cz>
References: <Pine.LNX.4.44.0309302108300.853-100000@ecabase.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0309302108300.853-100000@ecabase.localdomain>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Cc: Jamie Lutch <jlutch@altairinc.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 30 Sep 2003, Kai Vehmanen wrote:

> Note: this probably belongs to alsa-devel, so please remove alsa-user from
> replies.
>
> On Fri, 26 Sep 2003, Jamie Lutch wrote:
>
> > Didnt have any responses on my post of a few days ago, so I'm giving it
> > another go:
>
> Sorry for the late reply.
>
> > So I have my setup (pdaudiocf card>ecasound) running fine at 24/96, but
> > every once in awhile it just stops mid-stream and gives the following error:
> [...]
> > (audioio-alsa) Unknown Device State!
>
> Ecasound is getting an error (res<0) from snd_read{in}/write{in}. It's one
> of...: EPIPE, EIO or EINTR.
>
> In response, Ecasound calls snd_pcm_status() and then
> snd_pcm_status_get_state() to query, but the returned state is not
> the expected 'SND_PCM_STATE_XRUN'. I'm not sure how this could happen. I
> could not reproduce this error with the latest ALSA&ecasound on my
> soundcards.
>
> I've added some debug printfs to the code, so could you retry the tests
> with the latest Ecasound from CVS? By doing this we should at least
> learn what is the exact state the soundcard is in.

I will explain what happens: The PDAudioCF driver checks the input rate
periodically and if it does not match, it will force
SND_PCM_STATE_DRAINING and stops the capture (because stream has invalid
 - non-settled - parameters). In this case, EPIPE is also returned.

The reason why SND_PCM_STATE_XRUN is not used is to tell the application
that stream parameters were changes and also the capture ring buffer might
not be full at this point, of course, so the XRUN condition is not true.

Jamie, it seems that your input source does not give constant stream (or
your cabling is broken). Could you try another input source or another
cables? Thanks.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
