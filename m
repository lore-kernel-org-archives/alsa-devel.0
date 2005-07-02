From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: Fix emu10k1 breakages in kernel 2.6.12
Date: Sat, 02 Jul 2005 23:30:25 +0100
Message-ID: <42C71581.4070504@superbug.co.uk>
References: <1120273701.12256.30.camel@mindpipe>	 <42C66D9D.9020203@superbug.co.uk> <1120328091.2196.16.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1120328091.2196.16.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>, Takashi Iwai <tiwai@suse.de>, Arnaud Patard <arnaud.patard@rtp-net.org>, Mikael Magnusson <mikaelmagnusson@glocalnet.net>, Peter Zubaj <pzad@pobox.sk>
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:
> 
> Right, but if the name does not match, alsactl cannot restore the
> previous mixer settings, so the mixer is reset to the default state, ie
> no sound.
> 

Ok, which name should we be using here?
cat /proc/asound/cards
0 [Audigy2        ]: Audigy2 - Audigy 4 PRO [SB0380]
                     Audigy 4 PRO [SB0380] (rev.4, serial:0x20071102) at
0x9000, irq 23
1 [Audigy2_1      ]: Audigy2 - Audigy 2 Value [SB0400]
                     Audigy 2 Value [SB0400] (rev.0, serial:0x10011102)
at 0x9400, irq 17
2 [CA0106         ]: CA0106 - CA0106
                     Live! 7.1 24bit [SB0410] at 0x8400 irq 21
3 [CA0106_1       ]: CA0106 - CA0106
                     AudigyLS [SB0310] at 0x8800 irq 22


But alsactl asound.state uses the following names:
state.SB0400 {
state.SB0240 {
state.SB0380 {
state.CA0106 {
state.Audigy2 {

If I clear asound.state, I now get:
state.Audigy2 {
state.Audigy2_1 {
state.CA0106 {
state.CA0106_1 {

This must have been a change to alsactl. I think that using Audigy2_1
etc. is a much better idea than using something like SB0400.

I don't believe my changes to emu10k1 caused this to change. It was
something independent that changed.

James


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
