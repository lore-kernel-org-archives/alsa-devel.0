From: "Mark Knecht" <mknecht@controlnet.com>
Subject: RE: Further info: Bug: ALSA Sequencer or MTPAV - easy to reproduce
Date: Wed, 12 Feb 2003 13:32:00 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <NDBBLGIKBJENLAMOLFHGMEHNBGAB.mknecht@controlnet.com>
References: <Pine.LNX.4.44.0302122223430.30420-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Will do. I'll send it along this evening.

Thanks,
Mark

-----Original Message-----
From: Jaroslav Kysela [mailto:perex@suse.cz]
Sent: Wednesday, February 12, 2003 1:26 PM
To: Mark Knecht
Cc: alsa-devel@lists.sourceforge.net
Subject: RE: Further info: [Alsa-devel] Bug: ALSA Sequencer or MTPAV -
easy to reproduce


On Wed, 12 Feb 2003, Mark Knecht wrote:

> Jaroslav,
>    Hi. Actually, I had been looking around for where to report this sort
of
> problem. I'm using an HDSP 9652 for MIDI input and getting stuck notes on
> all soft synths I'm using. (amSynth, ZynAddSubFx and iiwusynth) I'm at a
bit
> of a loss as to how to debug this, but I do see the problem.
>
>    I have found that it is independent of MIDI applications, as I see the
> problem if I just use kaconnect to hook MIDI input to the soft synth and
> qjackconnect to hook analog output to my speakers.

Could you try the command 'dd if=/dev/snd/midiC0D0 of=abcd bs=1' and play
some notes on connected keyboard? In the file abcd will be the raw context
of midi input, so we can determine, if it's driver or sequencer problem.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
