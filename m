From: David Liontooth <liontooth@cogweb.net>
Subject: 0000773: Kernel 2.6.10 with ALSA 1.08rc1 from CVS (12/30/2004) Audigy2
 Value - SB0400 card Audigy2 Value- AUX-In and LINE-IN no sound
Date: Sun, 02 Jan 2005 00:57:31 -0800
Message-ID: <41D7B77B.90509@cogweb.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Just a quick note on the audigy2 value problem reported in 773,
"auxin and linein prevent tvtime and cd player from working".

On Debian amd64 (pure64) sid, running 2.6.9-ac6 and Alsa CVS
from 19 December 2004, this is working -- that is to say, tvtime and
other tv apps work, xmms works, even networked sound works
fine using alsaplayer-nas. But the mixer settings are tricky.

I get sound from a TV card by plugging a short cable from the
sound-out on the TV card to the line-in on the audigy2 value card.

Alsamixergui need these components on and up for television
and normal playback:

    * Master
    * PCM (for soundcard playback -- not used by TV)
    * Line (the first of the three Line components)
    * Analog Mix (the first of two for playback)
    * Analog Mix (the second of two for recording from TV)
    * Audigy Analog Output Jack (unmute)
    * EMU10K1 PCM (both, for playback)
    * Front

IEC958 Optical Raw must be off (muted).

To turn on the recording channel, you can also use

    amixer -c 0 cset numid=18 100%,100% unmute cap)

I saved (alsactl store) and occasionally the card muted, when
switching between recording and watching, or between different
tv apps (xdtv, motv, xawtv); alsactl restore fixed it.

It would be very useful if the mixer could by default be set with
plausible values for a particular card; it took me a long time by
nearly pure trial and error to find the channels I needed -- this
is not very intuitive and sometimes downright peculiar.

Cheers,
Dave





-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
