From: William <walsac3@orthoset.com>
Subject: Real-time per-note attenuation on single MIDI channel in emu10k1
Date: Wed, 8 Dec 2004 11:27:40 GMT
Message-ID: <200412081127.LAA01444@orthoset.com>
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

Does the emu10k1 driver have any way of doing real-time attenuation
for notes that are already playing at particular pitches on one MIDI channel?
Using MIDI Expression Controller #11 affects all playing notes on one channel.
I'd like to be able to attenuate in real-time a subset of the
already playing notes on a single channel by specifying their pitches.
Calling these two functions sequentially from inside the kernel

 snd_emux_send_effect(port, chan, EMUX_FX_ATTEN, value, EMUX_FX_FLAG_ADD)
 snd_emux_update_channel(port, chan, SNDRV_EMUX_UPDATE_VOLUME);

changes the attenuation in real-time on {port,chan} but it attenuates
all of the currently playing notes equally at all pitches,
i.e. you cannot choose which pitches are attenuated.

If it's not yet possible to do it, how feasible would it be to write
a new function, e.g. snd_emux_attenuate_note(port,chan,note,value)
for attenuating in real-time a particular note pitch?

William


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
