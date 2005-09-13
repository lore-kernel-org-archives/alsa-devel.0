From: Daniel Svensson <nano@nittionio.nu>
Subject: Re: Problems with Hercules DJ Console and the usb-audio driver
Date: Tue, 13 Sep 2005 16:09:35 +0200
Message-ID: <20050913140934.GA24953@nittionio.nu>
References: <20050912182716.GA26327@nittionio.nu> <s5h8xy1fcbi.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5h8xy1fcbi.wl%tiwai@suse.de>
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

On Tue, Sep 13, 2005 at 01:15:45PM +0200, Takashi Iwai wrote:
> This may be fixed by the patch below.
> 
> > The rest of the device doesn't work either. The mixer fails because the
> > mixer element "Delay Control" cannot be read. 
> 
> Not the right fix, but as a workaround, try to uncomment
> IGNORE_CTL_ERROR in usbmixer.c and recompile the driver.

The MIDI ports are now recognized. All the controls on the device
works and the MIDI keyboard connected to the interface works too. So 
the MIDI part isworking well again. Uncommenting the IGNORE_CTL_ERROR
obviously allows alsamixer to start. However, there are _four_ elements
named 'PCM', and then the 'Delay Control'. And amixer contents only
reports three ("PCM Playback Switch", "PCM Playback", "Delay Control").

Here is the output of "amixer scontents":

Simple mixer control 'PCM',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right - Rear Left - Rear Right - Front Center - Woofer
  Limits: Playback 0 - 181
  Mono:
  Front Left: Playback 145 [80%] [on]
  Front Right: Playback 145 [80%] [on]
  Rear Left: Playback 145 [80%] [on]
  Rear Right: Playback 145 [80%] [on]
  Front Center: Playback 145 [80%] [on]
  Woofer: Playback 145 [80%] [on]
Simple mixer control 'Delay Control',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 1
  Mono: 0 [0%]

Which doesn't match alsamixer controls very well (in count and names). 

Ok, so some progress. The device accepts S16, 6 channels, 48kHz.
Still no output, fails with kernel message:

ALSA /hom.../usbaudio.c:807: cannot submit datapipe for urb 5, err = -28


-- 
Daniel Svensson <nano@nittionio.nu>


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
