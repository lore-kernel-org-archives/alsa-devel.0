From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Capture problems, 'bogus'(?) audio overrun, pcm,
 via8233
Date: Wed, 4 Dec 2002 22:09:38 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0212042202400.521-100000@pnote.perex-int.cz>
References: <n665u9wmkz.fsf@saida.lysator.liu.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <n665u9wmkz.fsf@saida.lysator.liu.se>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Pontus Lidman <pontus@lysator.liu.se>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On 4 Dec 2002, Pontus Lidman wrote:

> Hello,
> 
> I'm experiencing audio overruns when recording with an ALSA
> application, but after investigation I'm inclined to consider them
> 'bogus' because I believe there is no way that the buffer can be
> overrun in such a short time. I don't know how I can avoid them, I
> hope somebody can help me troubleshoot this.
> 
> The application, 'avview' (TV capture software), runs fine for some
> time, randomly between 5-30 seconds, independent of sampling rate,
> after every snd_pcm_prepare, but then I get an audio overrun
> reported. This is invariably when a very short time elapsed since the
> last successful read.
> 
> I tried to record about 10 minutes, and I got 37 overruns. I measured
> the time since the last read, when the buffer is supposedly near
> empty, and the intervals are between 3 and 36 microseconds, the
> average being 18 microseconds. Obviously something strange is going
> on.
> 
> When the reading loop is successful, the time between successful reads
> depends on the blocksize; since the read call has to block to wait for
> data, I assume I'm calling the read function often enough. Since I'm
> recording video at the same time, the system is a bit loaded, but
> 'top' reports constantly more than 50% idle.
> 
> My hardware is a MSI KT3 Ultra2 motherboard with 'VIA Technologies,
> Inc. VT8233 AC97 Audio Controller (rev 80)' (source: cat /proc/pci).
> 
> For ALSA, stop threshold is set to 65536, buffer time is set to
> 100020, I'm doing blocking reads. I've tried varying these settings,

Could you send me full dump of sw and hw params? see *dump() functions in 
pcm.h header file. Also, could you check lines coming from the sound 
driver in /var/log/messages (if any)?

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by: Microsoft Visual Studio.NET 
comprehensive development tool, built to increase your 
productivity. Try a free online hosted session at:
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr0003en
