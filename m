From: Mark Knecht <markknecht@comcast.net>
Subject: Re: Alsa-1.0.0rc2 Hammerfall Light - small bug report
Date: Sat, 06 Dec 2003 18:15:19 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1070763319.31277.0.camel@Wizard.knechthome.com>
References: <1070760538.5385.12.camel@Wizard.knechthome.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1070760538.5385.12.camel@Wizard.knechthome.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sat, 2003-12-06 at 17:28, Mark Knecht wrote:
> Hi,
>    The Hammerfall Light driver has a couple of small bugs in the way it
> identifies port status in /proc/asound where it lists the spdif port as
> an ADAT port. I'm not using spdif on this machine so I cannot check to
> see if it shows lock status correctly. Someone may want to look at this.
> 
> Cheers,
> Mark

Sorry. Forgot to attach what I saw. Note ADAT3 which do not exist on
this card.


[mark@localhost mark]$ cat /proc/asound/card0/rme9652 
RME Digi9636 (Rev 1.5) (Card #1)
Buffers: capture ee400000 playback ee000000
IRQ: 10 Registers bus: 0xf5000000 VM: 0xf091d000
Control register: 44006

Latency: 512 samples (2 periods of 2048 bytes)
Hardware pointer (frames): 0
Passthru: no
Clock mode: autosync
Pref. sync source: ADAT1

ADAT1 Input source: ADAT1 optical

IEC958 input: Coaxial
IEC958 output: Coaxial only
IEC958 quality: Consumer
IEC958 emphasis: off
IEC958 Dolby: off
IEC958 sample rate: error flag set

ADAT Sample rate: 44100Hz
ADAT1: No Lock
ADAT2: No Lock
ADAT3: No Lock

Timecode signal: no
Punch Status:

 1: off  2: off  3: off  4: off  5: off  6: off  7: off  8: off 
 9: off 10: off 11: off 12: off 13: off 14: off 15: off 16: off 
17: off 18: off 
[mark@localhost mark]$ 





-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
