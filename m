From: Thomas Charbonnel <thomas@undata.org>
Subject: Re: hdsp I/O-error
Date: 11 Apr 2003 20:37:55 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1050086275.1337.37.camel@satellite.undata.org>
References: <200304112048.38744.Jaakko.Prattala@Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200304112048.38744.Jaakko.Prattala@Helsinki.FI>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaakko =?ISO-8859-1?Q?Pr=E4tt=E4l=E4?= <Jaakko.Prattala@Helsinki.FI>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

> Hi. I'm having problems with my multiface+cardbus.
> I've tested the card in windows and it works.
> I just updated the firmware from rev 5 to 11, but the problem persists.
> 
> If I don't load the firmware in windows, hdsploader goes:
> hdsploader - firmware loader for RME Hammerfall DSP cards
> Looking for HDSP + Multiface or Digiface cards :
> Card 0 : RME Hammerfall DSP at 0x10800000, irq 11
> Upload firmware for card hw:0
> Hwdep ioctl error on card hw:0 : Input/output error.

> If I boot to windows and then back, hdsploader looks
> ok but pd says:
> ALSA lib pcm_hw.c:325:(snd_pcm_hw_hw_params)
> SNDRV_PCM_IOCTL_HW_PARAMS failed: Device or resource busy
> and jack hangs after "creating alsa driver ... hdsp|1024|2|48000|swmon|rt"
> 
> I'm using alsa cvs from ~2 hours ago, rhl8.0 stock kernel (2.4.18-14)
> and the usual rhl8.0 pcmcia setup (I don't know what that actually is,
> there's a separate package called kernel-pcmcia-cs-3.1.31-9 that I have
> installed with rhl).

Could you please send the output of dmesg ?
Did alsactl tried to restore old settings ?

Thomas




-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
