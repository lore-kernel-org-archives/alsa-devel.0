From: Bernard Urban <Bernard.Urban@meteo.fr>
Subject: Re: CMI8330: success !
Date: 21 Jan 2003 11:11:55 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <87of6aolqs.fsf@merceron.meteo.fr>
References: <s5hy96qro4i.wl@alsa2.suse.de> <87el83q0oh.fsf@merceron.meteo.fr>
	<s5h65szajak.wl@alsa2.suse.de> <s5h1y3naa5u.wl@alsa2.suse.de>
	<s5hlm1u8udt.wl@alsa2.suse.de> <873cnxz8pz.fsf@merceron.meteo.fr>
	<s5hel7hwf4p.wl@alsa2.suse.de> <87ptqy3ij6.fsf_-_@merceron.meteo.fr>
	<87el7bkhk4.fsf@merceron.meteo.fr> <8765skqhq7.fsf@merceron.meteo.fr>
	<s5hadhw5em7.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hadhw5em7.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Bernard Urban <Bernard.Urban@meteo.fr>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai@suse.de> writes:

[...]

>  
> thanks, nice to know that.
> does it work w/o ENABLE_SB_MXIER even after rebooting (i mean, after
> resetting the hardware) ?

Yes, even after power down/power up (and it is not an ATX power
supply, so it is really down when you switch off).

[...]
> 
> > Capture for cmi8330: no success at all, with or without
> > PLAYBACK_ON_SB, and ENABLE_SB_MIXER defined.
> > But I noticed that I cannot capture (mic recording) with DOS or
> > Windows either on this machine. The microphone is ok, it is the same
> > used for the successful SB16 test. So it is not out of possibility there is
> > a hardware problem on my mainboard (the chip is on it, not on an add-on  
> > card). I have not currently the possibility to test the "line in" entry. 
> > I will perhaps test the CD one if it makes sense ?
> 
> yes, but make sure that you connected the CD-cable :)
> 

Good news, capture works with CD !

Only one gotcha (probably not related to the cmi8330 driver): 
there are "Line Capture Volume", "Mic Capture Volume"
and "CD Capture Volume" controls. The first 2 appear in alsamixer, 
but not the CD one ? 
So you must raise the CD capture volume with amixer.

Sincerely.

-- 

Bernard Urban


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
