From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: sequencer: handling non-registered parameter
 numbers....
Date: Mon, 16 Jun 2003 11:55:58 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0306161155250.11284-100000@pnote.perex-int.cz>
References: <3EED90A3.3010009@folkwang-hochschule.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3EED90A3.3010009@folkwang-hochschule.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Joern Nettingsmeier <nettings@folkwang-hochschule.de>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 16 Jun 2003, Joern Nettingsmeier wrote:

> Jaroslav Kysela wrote:
> > On Mon, 16 Jun 2003, Joern Nettingsmeier wrote:
> > 
> > 
> >>either i have not understood the semantics of nrpm, or nrpm  events are 
> >>not detected as such. when i move a slider, i always get four separate 
> >>normal controller events: two on 98/99 encoding the control number as a 
> >>14bit value, and two on 6 and 38 encoding the data.
> >>
> >>the case SND_EVENT_NONREGPARAM is never reached.
> >>now one of three things must be broken (in decreasing order of 
> >>likelihood): me, my wacky peavey controller, or alsa-lib.
> > 
> > 
> > The driver code and alsa-lib does not handle nonreg and reg parameters.
> > They simply pass them like standard controllers, so the four event 
> > sequence is ok. I think that we may add this piece code to seq_midi_event.c.
> > 
>  > 						Jaroslav
> 
> thanks for the clarification. i'd be glad to help, but i doubt i could 
> meet the coding standards of alsa-lib. at least i could help test it.
> do you or anyone of the alsa core developers have plans to tackle this 
> some time soon ? i'd love to be able to use my controller box for the 
> LinuxTag presentations in mid-July.

I am working on it right now, but it requires to add new states to 
sequencer event encoder...

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
