From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: MIDI+USB - one way?
Date: Mon, 05 Aug 2002 14:54:25 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D4E7581.C3EDCB44@ladisch.de>
References: <Pine.LNX.4.33.0208042048550.951-100000@pnote.perex-int.cz>
 <3D4E3AB0.563AB976@ladisch.de> <s5hn0s1ehzp.wl@alsa2.suse.de>
 <3D4E5613.96D45644@ladisch.de> <s5hk7n5ebo5.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@suse.cz>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Clemens Ladisch wrote:
> > > (and i believe that no applications suffer by this change.)
> >
> > Yes, because applications expect the OSS behaviour.
> >
> > I didn't really look at the OSS PCM read() implementation, but the
> > sequencer read() already implements the correct POSIX behaviour.
> 
> i don't think that the oss pcm interface ever suffices the definition
> of posix above.  but we cannot change it since most of applications
> assume that the read aligned in a block size.

Sorry, I didn't mention that I do _not_ intend to change the PCM code.
It's fine as it is.

> in the case of alsa, this low-level behavior can be changed, because
> the difference can be absorbed inside the alsa-lib.

Both the OSS and native ALSA code finally use snd_pcm_lib_read() as far
as I see, so it could not be changed independently. (but I didn't look
deeply into this)

And there's already sleep_min or something like that, so we are beyond
POSIX anyway.

> but i see no good reason to change this now.

Neither do I.


Clemens


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
