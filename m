From: Mark Knecht <markknecht@attbi.com>
Subject: RE: Further info: Bug: ALSA Sequencer or MTPAV - easy
	to reproduce
Date: 12 Feb 2003 17:20:12 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1045099213.1982.4.camel@Godzilla>
References: <Pine.LNX.4.44.0302122223430.30420-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-ba44p+mu1DEpmTcFsNGF"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0302122223430.30420-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--=-ba44p+mu1DEpmTcFsNGF
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2003-02-12 at 13:25, Jaroslav Kysela wrote:
> On Wed, 12 Feb 2003, Mark Knecht wrote:
> 
> > Jaroslav,
> >    Hi. Actually, I had been looking around for where to report this sort of
> > problem. I'm using an HDSP 9652 for MIDI input and getting stuck notes on
> > all soft synths I'm using. (amSynth, ZynAddSubFx and iiwusynth) I'm at a bit
> > of a loss as to how to debug this, but I do see the problem.
> > 
> >    I have found that it is independent of MIDI applications, as I see the
> > problem if I just use kaconnect to hook MIDI input to the soft synth and
> > qjackconnect to hook analog output to my speakers.
> 
> Could you try the command 'dd if=/dev/snd/midiC0D0 of=abcd bs=1' and play
> some notes on connected keyboard? In the file abcd will be the raw context
> of midi input, so we can determine, if it's driver or sequencer problem.
> 
> 						Jaroslav

Hi,
   OK, as requested, here's a few chords and some notes. However, I
cannot hear the soft synth when doing this, and I normally only get a
stuck note once every 5-10 minutes, so there's no guarantee that there's
anything interesting in here.

   Maybe I could record something, using Rosegarden, until I get a stuck
note, and give you a MIDI file? Don't know if that would be of much help
as this problem is not terribly repeatable yet.

   Is there any way I can pipe this input to my soft synth so I can hear
what I'm doing?

Cheers,
Mark

--=-ba44p+mu1DEpmTcFsNGF
Content-Disposition: attachment; filename=midi_notes
Content-Type: application/octet-stream; name=midi_notes
Content-Transfer-Encoding: base64

kD9DkENVkDxVkEMAkDwAkD8AkD5QkDtSkENVkEMAkDsAkD4AkDxSkENVkEFVkEMAkDwAkEEAkDxO
kD9JkENMkEMAkDwAkD8AkENKkDtGkD5GkEMAkD4AkDsAkDpKkD5JkDdOkD4AkDcAkDoAkDdKkDlG
kDcAkDo3kDkAkDwOkDoAkD5HkDwAkD4A

--=-ba44p+mu1DEpmTcFsNGF--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
