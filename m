From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Problems with intel8x0 driver. (and probably the cause of VT8233/A/8235
 Clock Problem)
Date: Wed, 10 Dec 2003 02:34:43 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FD68643.4080203@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

Hi,

I have just downloaded the latest alsa-kernel cvs and installed it.
The sample rate converters and rate setting functions seem broken.

For example. I can output at any rate to a SB Audigy2 because it does 
not need any sample rate conversion, but if I use the intel8x0 chip for 
sound output, the rate on the chip is fixed at 48000, and any rate other 
than that either hangs the output, or fails.
When if fails: -
err = snd_pcm_hw_params_set_rate_near(handle, params, &rate, 0);

If "rate" is initially 48000 it works, if "rate" is 44100 if fails, but 
in different ways, if device name is "default", it hangs when outputting 
audio and no sound even begins to come out of the speakers, if device 
name is "front", err = 0, and rate gets given the value of 0 or 48000 
randomly!

If I am using a plug device like the "front" or "default" device, it 
should automatically do sample rate conversion for me, but none of the 
sample rate conversion seems to work!

Cheers
James


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
