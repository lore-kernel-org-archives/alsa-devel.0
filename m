From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Feature request: PCM volume control per snd_pcm_open().
Date: Mon, 03 Nov 2003 11:30:56 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FA63C70.5050203@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

When playing some audio from multiple sources to the same sound card, 
one would like to have: -

PCM1 -> Volume1 -> MixerA -> PCM Volume -> Mixer B -> Speakers.
PCM2 -> Volume2 -----^

But currently one has: -
PCM1 -> MixerA -> PCM Volume -> MixerB -> Speakers.
PCM2 ----^

MixerA is a harware mixer on Multi-open cards, and dmix software mixer 
on Single-open cards.
MixerB is normally the Mixer in the AC97 chip.
PCM1 is audio from application 1
PCM2 is audio from application 2
Volume1 should be controlled by application1, and changing the Volume1 
should only effect the volume of the sound coming from application2

Suggested API: -
fd = snd_pcm_open("front")
set all the hw and sw values. (Sample rate etc.)

Then, anytime during playback of sound, one can call: -
snd_pcm_volume(fd, VOL) where VOL is the dB value to set.

Then alsa-lib will do software volume control on every snd_pcm_write() call.
The default value for snd_pcm_volume will be 0 dB, so that the software 
volume function would then be a "no operation".

One might want to expand this so that one has a VOL level for each 
channel in the PCM.

I think that this sort of api would make life a lot easier for 
applications that only want to adjust the volume of their own output, 
and don't want to talk to the entire mixer with all it's multitude of 
controls.

Summary: -
Provide an api call so an application can adjust the audio volume of 
it's own output without effecting other application's volume settings.

Cheers
James



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
