From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [Rosegarden-devel] Re: Sequencer port type flags
Date: Fri, 9 May 2003 12:43:43 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0305091237280.1237-100000@pnote.perex-int.cz>
References: <3EBB7ABE.3000308@all-day-breakfast.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3EBB7ABE.3000308@all-day-breakfast.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Chris Cannam <cannam@all-day-breakfast.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>, rosegarden-devel <rosegarden-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 9 May 2003, Chris Cannam wrote:

> Jaroslav Kysela wrote:
> > Note that the SYNTH ports should support SNDRV_SEQ_EVENT_SAMPLE* events. 
> > It means direct wavetable synthesis not MIDI event communication.
> 
> OK, now I'm confused again.  Are you saying that a soft synth that
> can only be driven via MIDI should not describe itself as a SYNTH?
> If so, how do I know it's a synth?
> 
> My interpretation so far has been that most soft synths should set
> SYNTH, APPLICATION and possibly SAMPLE if they're sample-based,
> whereas a sequencer like Rosegarden should set APPLICATION and
> nothing else.  Do I have that wrong?
> 
> (And I don't know of any soft synths that are always GM devices,
> so I'm doubtful -- as I mentioned in another email -- whether they
> should be setting GM or not.)

Note that we might change the define if it cause problems. But here is
interpretation of flags:

SNDRV_SEQ_PORT_TYPE_MIDI_* defines are for client which understands the 
midi v1.0 commands and extensions

SNDRV_SEQ_PORT_TYPE_SYNTH define is for clients which can do direct 
wavetable synthesis (used by modplayers etc.)

SNDRV_SEQ_PORT_TYPE_APPLICATION is for an application (sequencer or 
editor) - it doesn't apply for software MIDI synthesizers nor for 
wavetable direct synthesizers in the user space

I think that your confusion is that we separate MIDI synthesizers 
(clients) and direct wavetable sythesizers (clients).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
