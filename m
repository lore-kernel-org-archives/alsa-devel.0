From: Frank Barknecht <barknech@ph-cip.uni-koeln.de>
Subject: Using plughw vs. hw in PD
Date: Sun, 17 Feb 2002 12:51:13 +0100
Message-ID: <20020217125112.A1636@fliwatut.scifi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi all,

I encountered a problem using PD (available at
http://www.crca.ucsd.edu/~msp/software.html) with the plugin layer of
ALSA (and a Midiman Audiophile + SBLive card here). This probably is a
problem with the PD source code, but on pd-list one is a bit at a loss
in fixing that problem. I can give PD a PCM device name to use, e.g.:

$ pd -alsadev hw:0

or second card (SBLive):

$ pd -alsadev hw:1

This works without a flaw, if I use "hw" PCMs. hw:0,0 is the default
device in PD anyways. But a soon as I try the plugin layer, the audio
gets stuck and I get this error message:

$ pd -alsadev default [OR plughw:0 OR etc.]
[...]
audio I/O stuck... closing audio

ALSA lib pcm_hw.c:145:(snd_pcm_hw_hw_free) SNDRV_PCM_IOCTL_HW_FREE failed: File descriptor in bad state
snd_pcm_close (input): File descriptor in bad state
ALSA lib pcm_hw.c:145:(snd_pcm_hw_hw_free) SNDRV_PCM_IOCTL_HW_FREE failed: File descriptor in bad state
snd_pcm_close (output): File descriptor in bad state
pd: exiting

This especially is a problem for Hammerfall users, as here directly
acessing the "hw" does not work at all, according to reports on pd-list.

Does this error ring a bell in anyone? What could be missing in PD's
ALSA code (s_linux.c)? Or is this a configuration error on my side and I
have to use a tricky ~/.asoundrc? In aplay, using "-D plughw:0" or
"default" works.

Thanks for help and greetings,
-- 
                                                 __    __
 Frank Barknecht       ____ ______   ____ __ trip\ \  / /wire ______
                      / __// __  /__/ __// // __  \ \/ /  __ \\  ___\	
                     / /  / ____/  / /  / // ____// /\ \\  ___\\____ \	
                    /_/  /_____/  /_/  /_//_____// /  \ \\_____\\_____\
                                                /_/    \_\ 

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
