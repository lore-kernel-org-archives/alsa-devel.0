From: Daniel James <daniel@64studio.com>
Subject: Re: Card won't accept new sample rate?
Date: Tue, 29 Aug 2006 16:00:35 +0100
Message-ID: <44F45693.3000205@64studio.com>
References: <44F43EED.4090608@64studio.com>	<s5hhczv656g.wl%tiwai@suse.de>	<44F44FEA.1040301@64studio.com>
	<s5h3bbf61w5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5h3bbf61w5.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net, Free Ekanayaka <free@64studio.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

> If you start JACK, usually it prefers "hw" PCM, which means the direct
> access to the hardware without resampling, up/downmix, and format
> conversion (also without soft-mixing).  The "default" PCM is with
> everything, i.e. dmix, and plug layer.

Right - I just tried 'default' on my laptop, which points to the AC97 
chipset, and JACK wouldn't even start at 44100Hz. I switched to 
'default' at 48000Hz and it worked.

However if I plug in a USB audio interface (M Audio MobilePre), used as 
hw:2, then jack starts fine at either 44100 or 48000 and the sample rate 
is correctly displayed in qjackctl.

I think it's because of this USB interface that I believed JACK used to 
work at 44100Hz on this particular laptop. Now I know different :-)

Thanks!

Daniel


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
