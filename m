From: Thomas Charbonnel <thomas@undata.org>
Subject: Re: Intel8x0 problems with rc1
Date: Wed, 03 Dec 2003 15:47:23 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FCDF77B.7070702@undata.org>
References: <3FCB855F.7080505@undata.org>	<s5hd6b8fl1s.wl@alsa2.suse.de>	<s5h8ylwfk40.wl@alsa2.suse.de>	<3FCC7EC4.6050200@undata.org>	<s5hn0abe7vm.wl@alsa2.suse.de>	<3FCC9A49.3070300@undata.org>	<s5h3cc3dxrb.wl@alsa2.suse.de>	<3FCD163E.7040702@undata.org> <s5h65gyc8ri.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h65gyc8ri.wl@alsa2.suse.de>
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

Takashi Iwai wrote :

>>Takashi, I applied your patch but nothings shows up in my logs.
>>I even replaced all the KERN_DEBUG by KERN_EMERG, and still nothing.
>>The only thing I get is this :
>>ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x300100]
>>ALSA intel8x0.c:599: codec_read 0: semaphore is not ready for register 0x56
> 
> 
> and the driver still works somehow?
> 
> 
>>Is it possible that your code never gets called ?
> 
> 
> if the driver works, it must not happen.
> 
> 
> Takashi

Ok, my fault, sorry Takashi, I stupidly reloaded only the snd-intel8x0 
module and forgot snd-ac97-codec, here's the log :

ac97_pcm_open: rate = 48000, cfg = 2, slots = 0x198
setting ac97 reg 0x2c to rate 48000
setting ac97 reg 0x2e to rate 48000
ALSA ../../alsa-kernel/pci/ac97/ac97_pcm.c:561: error in 
snd_ac97_set_rate: cidx=0, reg=0x2e, rate=48000
, err=-22<0>ac97_pcm_open: rate = 48000, cfg = 2, slots = 0x198

(The file's rate was 44100 kHz)

Thomas




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
