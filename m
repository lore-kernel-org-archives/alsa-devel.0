From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: emu10k1 device naming
Date: Tue, 27 Jul 2004 15:17:06 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1090955826.1094.65.camel@mindpipe>
References: <1090729766.1952.7.camel@mindpipe>
	 <Pine.LNX.4.58.0407251013410.2010@pnote.perex-int.cz>
	 <1090779307.14951.24.camel@mindpipe>
	 <Pine.LNX.4.58.0407270852520.1775@pnote.perex-int.cz>
	 <s5hr7qx4f6l.wl@alsa2.suse.de>
	 <Pine.LNX.4.58.0407271937390.2325@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0407271937390.2325@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 2004-07-27 at 13:38, Jaroslav Kysela wrote:
> On Tue, 27 Jul 2004, Takashi Iwai wrote:
> 
> > Hmm, but there is no big disadvantage to use EFX for the default
> > capture...  Or do we have any?
> 
> Hardware rate conversions.
> 

Correct, I did not think of this.  The current default allows stereo
capture and playback at any sample rate, albeit at the expense of
multichannel, low latency capabilities.  This is the best default.

The other problem with the FX capture device is that currently the only
way to select the channels to record is to manually edit asound.state
and then do alsactl restore.  To put this in the mixer, we would need to
add 'EFX Voices Mask', consisting of 64 boolean values, and the number
of these which are unmuted at any given time must be a power of two.
Not sure if this is possible with the current mixer API, it certainly
would not be pretty.

Anyway, this issue is moot, because it turns out that JACK does support
full-duplex mode using different devices for capture and playback.  The
documentation and help text was incorrect.  This will be fixed in the
next JACK release.

The next release of qjackctl will also be updated to reflect this
development, as qjackctl currently disables the selection of input and
output devices if full duplex mode is selected.

Lee



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
