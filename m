From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [Rosegarden-devel] Re: Sequencer port type flags
Date: Fri, 9 May 2003 12:54:39 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0305091253060.1237-100000@pnote.perex-int.cz>
References: <3EBB7EEF.5060908@all-day-breakfast.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3EBB7EEF.5060908@all-day-breakfast.com>
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

> Chris Cannam wrote:
> > Are you saying that a soft synth that
> > can only be driven via MIDI should not describe itself as a SYNTH?
> > If so, how do I know it's a synth?
> 
> I suppose (replying to myself) that it's all about what these flags
> are intended to be used for.  I had assumed they were basically
> informational flags for identifying classes of device, and as I've
> only had to deal with MIDI clients (and then only very naively),
> I've only really thought about clients that are already assumed to
> understand MIDI.
> 
> I suppose the alternative is that these flags are necessary to
> distinguish between different modes of communication -- different
> sorts of events that a particular client understands.  So once
> I've found out that a device is a MIDI device, how I find out that
> it's then a synth is entirely my problem -- the API doesn't care,
> because MIDI is all the same to it anyway.
> 
> If that's so, then these flags are of no use to Rosegarden.

Resegarden will probably talk only with ports classified as 
SNDRV_SEQ_PORT_TYPE_MIDI_*, won't? All other ports doesn't understand 
the received events.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
