From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Changes over dmix: 1.0.11rc4 and future
Date: Mon, 03 Apr 2006 12:29:25 -0400
Message-ID: <1144081766.13151.29.camel@mindpipe>
References: <s5h64lzalr0.wl%tiwai@suse.de>
	 <1143919154.30769.16.camel@mindpipe>  <s5h3bgvc739.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h3bgvc739.wl%tiwai@suse.de>
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

On Mon, 2006-04-03 at 11:59 +0200, Takashi Iwai wrote:
> 
> If you still get an error regarding variable_buffer_size, just remove
> that line.
> 
> And note that this won't work with emu10k1. 

I now get:

Playing WAVE '/usr/share/sounds/error.wav' : Signed 16 bit Little
Endian, Rate 44100 Hz, Mono
ALSA lib pcm_params.c:2152:(snd_pcm_hw_refine_slave) Slave PCM not
usable
aplay: set_params:879: Broken configuration for this PCM: no
configurations available

Which I think is normal as hw:0,0 on the emu10k1 is only a stereo
device.

Lee



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
