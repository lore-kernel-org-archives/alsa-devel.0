From: Aki Parviainen <aki.parviainen@iki.fi>
Subject: Re: PROBLEM: snd_intel_hda audio regression in 2.6.36-rc5
Date: Wed, 22 Sep 2010 18:31:26 +0300
Message-ID: <AANLkTi=Tctwyz=wLWSpf09Ex18wNgHqDv7PRSxXQ8LTw@mail.gmail.com>
References: <20100921173254.GA3037@ht>
	<s5hwrqenmz4.wl%tiwai@suse.de>
	<AANLkTikgOaBizi2z+AuAgD+anvmc+kG3z9KTqfzXs1zm@mail.gmail.com>
	<s5hmxr97sfb.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hmxr97sfb.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, perex@perex.cz
List-Id: alsa-devel@alsa-project.org

>
> So, you are testing only over SPDIF output, right?

Yes, I'm only using SPDIF output!

> Looks like the SPDIF status bits has been reset by some reason.
> Try to restore via iecset program included in alsa-utils package,
> e.g.
> =A0 =A0iecset original on
> =A0 =A0iecset category 0x02

I tried this and didn't notice any difference.

>
> If this doesn't help, try to unload sound driver once, remove (or
> backup) /etc/asound.state (which might be in a different path
> depending on the distro), then load sound modules again.
> This will restore the default SPDIF status. =A0Unmute / adjust mixer
> setups appropriately after doing this.

I also tried this but didn't notice a difference but however I noticed
a workaround to this problem that might be related to deleting the
asound.state (debian places it btw to /var/lib/alsa/asound.state): now
the regular audio works via SPDIF once again if I first play a file
with digital preencoded audio. Ie:

-Boot with 2.6.36-rc5
-Start kaffeine
-Play mp3 file -> no sound at all via spdif
-Play mkv file with 5.1 sound -> sound ok
-Play mp3 file again -> sound ok!
-Exit kaffeine & restart kaffeine or vlc
-Play mp3 file again -> sound ok!

Unfortunately the fix isn't permanent because after reboot I cannot
get regular sound via spdif until I have once played a file with 5.1
audio track.

Yours,

Aki
