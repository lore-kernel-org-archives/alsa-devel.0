From: Bernard Urban <Bernard.Urban@meteo.fr>
Subject: Re: CMI8330: success !
Date: 20 Jan 2003 10:43:28 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <8765skqhq7.fsf@merceron.meteo.fr>
References: <s5hy96qro4i.wl@alsa2.suse.de> <87el83q0oh.fsf@merceron.meteo.fr>
	<s5h65szajak.wl@alsa2.suse.de> <s5h1y3naa5u.wl@alsa2.suse.de>
	<s5hlm1u8udt.wl@alsa2.suse.de> <873cnxz8pz.fsf@merceron.meteo.fr>
	<s5hel7hwf4p.wl@alsa2.suse.de> <87ptqy3ij6.fsf_-_@merceron.meteo.fr>
	<87el7bkhk4.fsf@merceron.meteo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <87el7bkhk4.fsf@merceron.meteo.fr>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net, Takashi Iwai <tiwai@suse.de>
Cc: bernard.urban@meteo.fr
List-Id: alsa-devel@alsa-project.org


Bernard Urban <Bernard.Urban@meteo.fr> writes:
> 
> Notice that I have deleted the controls with false or zero values to
> save some place. For card0, the SB controls are absent. There are also
> some differences between controls for card0 and CARD_0, why ? 
> I get the CARD_0 controls when using alsamixer. 
> The important thing to notice is that the SB
> controls need not to be unmuted (as I first believe was necessary) ! 
> So to have playback it is not needed
> to define these SB controls in routine cmi8330_add_sb_mixers(). 
> But the SB initialization step is probably mandatory (I will test it).

Actually, the cmi8330 card works when undefining ENABLE_SB_MIXER.
So the init step in snd_sbdsp_create() is sufficient. This is good, as
you can get rid of these additional and dysfunctional controls.

> 
> Actually, this is somehow curious, as PLAYBACK_ON_SB is defined, and
> so playback should go through SB ??? It is apparently not the case.
> 
> Only one application did not work correctly, namely the old libc5
> based xquake (yes, I have done
> echo "xquake.real 0 0 direct" >/proc/asound/card0/pcm0p/oss).
> There is sound, but extremely noisy.
> 
> Some words about the behaviour of the SB controls in alsamixer:
> "SB" control follows the "SB Capture" control value.
> "SB Synth", "SB PCM" and "SB Speaker" do not respond to commands.
> "SB CD", "SB Line" and "SB Mic" cannot have values above 10%.
> 
> I have also tried both "SB Mic" and "Mic" controls in alsamixer, 
> but capture did not work at all (only noise is registered and I have
> Larsen effect when the volume is pushed too high). Nevertheless, 
> as "SB Mic" cannot have values above 10%, here lies perhaps the 
> problem.
> 
> I will now try to use #undefine  PLAYBACK_ON_SB.

This works also, with ENABLE_SB_MIXER defined, 
but some .wav files played on events in the desktop
are scratchy (sometimes, not always). So the original
#define  PLAYBACK_ON_SB
is better.

> Concerning the SB16 driver, I could not record either
> (arecord is blocking indefinitly). Changing the 16 bits DMA control
> did not help.

No, this works. The blocking occurs when some application has an open
file descriptor for playback (in my case, esd for gnome, even in the
state "suspended"). But you must MANUALLY assign  16 bits DMA to
"Playback" to obtain a successful capture (and conversely
assign it to "Capture" for playback). The "Auto" value does not work.
I recall my card is a SB 16 Vibra X PNP, if you want to put a warning
in the README file about that.

Capture for cmi8330: no success at all, with or without
PLAYBACK_ON_SB, and ENABLE_SB_MIXER defined.
But I noticed that I cannot capture (mic recording) with DOS or
Windows either on this machine. The microphone is ok, it is the same
used for the successful SB16 test. So it is not out of possibility there is
a hardware problem on my mainboard (the chip is on it, not on an add-on  
card). I have not currently the possibility to test the "line in" entry. 
I will perhaps test the CD one if it makes sense ?

Regards.

-- 

Bernard Urban


-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
