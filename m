From: Mark Zealey <mz234@cam.ac.uk>
Subject: Re: intel8x0 no sound in 2.6.12
Date: Wed, 7 Sep 2005 17:06:03 +0100
Message-ID: <200509071706.03680.mz234@cam.ac.uk>
References: <200509071557.02218.mz234@cam.ac.uk> <200509071616.25024.mz234@cam.ac.uk> <s5hek807ui8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hek807ui8.wl%tiwai@suse.de>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Yep did the aplay and it works fine but no audio comes out of the speakers or 
the headphone jack - the box remains silent. I did not use any options when 
loading the drivers. I have a second identical laptop bought at the same time 
which runs windows xp and has no problem with sound.

Mark

On Wednesday 07 September 2005 4:44 pm, Takashi Iwai wrote:
> At Wed, 7 Sep 2005 16:16:24 +0100,
>
> Mark Zealey wrote:
> > Laptop is an IBM thinkpad R50e. Attached are the 2 files
>
> Hmm, I don't find anything wrong at a first glance.
> Try to turn on/off "Line Jack Sense" and "Headphone Jack Sense" mixer
> switches.
>
> Do you have any module option for snd-intel8x0?
>
> And what do you mean "sound doesn't work"?  For testing PCM, try
>
> 	% aplay -vv somefile.wav
>
> and see whether VU meter appears.  If it looks working but no sound
> comes out, it's either in the driver, the mixer setting, or a hardware
> problem.  If the aplay is blocked, it's a typical device race, not a
> bug.
>
>
> Takashi

-- 

Mark Zealey
http://zealey.org/mark


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
