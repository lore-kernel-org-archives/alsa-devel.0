From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Novation X-Station: mostly success, but...
Date: Thu, 17 Mar 2005 14:06:11 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0503171359590.7260-100000@studcom.urz.uni-halle.de>
References: <200503170056.29280.wanthalf@centrum.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <200503170056.29280.wanthalf@centrum.cz>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Pavel Vondricka <wanthalf@centrum.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Pavel Vondricka wrote:
> However, I have problems with the "standard compliant" audio part: I can play
> sounds through the device, but I cannot capture them.

According to the descriptors, the devices captures only from the Mic
input, not from the Line in.  What does the manual say?

There should be two "Mic" controls, one for capturing and one for
monitoring.

> No wonder: the mixer seems to have no effect on the device. There
> are just a few controls anyway:  bass, treble, mic volume, speaker
> volume, aso. - nothing seems to have any effect when playing a
> sound through the device, just hardware volume knobs on it :-).

Bass/Treble/Speaker should affect the playback.

> When playing, the sound is not clean all the time, there are some clicks from
> time to time. Maybe a problem of the computer?

Does this happen when you're playing back something without doing
anything else on the computer?

> BTW: I also have to use the "plug" device to convert the sound format, because
> the card didn't want to play an ordinary 44.1kHz/16b WAV directly with
> "aplay -D hw:1,0 sound.wav".
> But maybe that's only some limitation of the hardware...?

Yes, the hardware is limited to 24 bit samples ...


Regards,
Clemens



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
