From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: alsa sequencer: note interface
Date: Mon, 14 Oct 2002 18:29:18 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0210141828010.7202-100000@pnote.perex-int.cz>
References: <200210141716.17222.bownie@bownie.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200210141716.17222.bownie@bownie.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Richard Bown <bownie@bownie.com>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 14 Oct 2002, Richard Bown wrote:

> A question - if you're sending a load of MIDI notes (as opposed to 
> noteons/noteoffs) with very long duration and to curtail these notes 
> you're sending notes with shorter (finite if you like) duration to same 
> channel/pitch should the longer ones clear down from ALSA and get cast 
> away?
> 
> At the moment I can get the notes to stop sounding correctly but after 
> playing more notes for a while (and everything sounding fine) the 
> sequencer just eventually stops accepting any more notes for playback 
> presumably because the original long notes are still hanging around in 
> a buffer somewhere.
> 
> Thoughts?

When NOTE event is processing, the NOTEON event is delivered to 
attached clients and NOTEOFF event is enqueued to be processed later.
So, it's possible that you'll have buffer full with NOTEOFF events.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
