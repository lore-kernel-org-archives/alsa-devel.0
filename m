From: Pavel Polischouk <pavelp@rogers.com>
Subject: Re: [PATCH 1/2] M-Audio USB
Date: Thu, 14 Dec 2006 22:36:08 -0500
Message-ID: <45821828.6070708@rogers.com>
References: <45675582.9060707@inbox.ru>
	<20061203215521.beksv3idcw444o4g@webmail.supelec.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20061203215521.beksv3idcw444o4g@webmail.supelec.fr>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Thibault Le Meur wrote:
> However, it does not correct the corrupted initialization state that
> occur when the device is turned on before the snd-usb-audio module is
> initialized with a valid device_setup parameter (see below).
>   
There are 2 reasons for this:
1. The default setting "0" will immediately make the device stuck in a 
weird semi-working mode. Avoid. I'll add a check to the next patch 
revision that will REFUSE to load the driver for M-Audio unless a valid 
setup parameter is specified. Another approach would be to use a mixer 
control to select available configuration (with the default of NONE).
2. If you're using a daemon that loads USB drivers automatically, it 
will always load using "default" setting. If a valid device_setup 
parameter is added to /etc/modprobe.conf, it will be possible to turn on 
the device before initializing the driver.
> As far as the documentation is concerned, shouldn't it be better to keep
> an Audiophile-USB.txt file with only the following sentence: "Updated  
> documentation on  this device can now be found in the M-Audio.txt  
> file" ?
>   
Agreed.
Also, I will update the JACK info. Current version can work natively 
with 24bit big-endian interfaces, and also works fine with  Quattro in 
4-channel input mode.

Another problem that I found with Quattro. The driver works fine in 
24/96k mode, no underruns. But in 44k/48k modes, it's always giving me 
JACK xruns, or just skips in arecord, even with the most forgiving JACK 
settings (high realtime priority and big buffers). This looks 
counter-intuitive, that the slower mode performs worse than faster one. 
Could it be that the driver reserves not enough USB bandwidth from 
hardware, or something similar? What settings could be changed to try to 
correct this?

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
