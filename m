From: Thomas Charbonnel <thomas@undata.org>
Subject: Re: Intel8x0 problems with rc1
Date: Tue, 02 Dec 2003 23:46:22 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FCD163E.7040702@undata.org>
References: <3FCB855F.7080505@undata.org>	<s5hd6b8fl1s.wl@alsa2.suse.de>	<s5h8ylwfk40.wl@alsa2.suse.de>	<3FCC7EC4.6050200@undata.org>	<s5hn0abe7vm.wl@alsa2.suse.de>	<3FCC9A49.3070300@undata.org> <s5h3cc3dxrb.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h3cc3dxrb.wl@alsa2.suse.de>
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
> please try the attached patch.
> possibly this isn't a fix, but it will print debug messages while
> probing and opening the pcm.
> 
> 
> Takashi
> 

Takashi, I applied your patch but nothings shows up in my logs.
I even replaced all the KERN_DEBUG by KERN_EMERG, and still nothing.
The only thing I get is this :
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x300100]
ALSA intel8x0.c:599: codec_read 0: semaphore is not ready for register 0x56
Is it possible that your code never gets called ? You seem also to be 
investigating about spdif, but my card does not have spdif output.

Thomas




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
