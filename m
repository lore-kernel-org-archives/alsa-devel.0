From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: period/buffer bug on pmac ?
Date: Mon, 15 Nov 2004 17:53:26 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0411151745210.1491-100000@studcom.urz.uni-halle.de>
References: <Pine.LNX.4.33.0411112023320.16903-100000@luna.ellen.dexterslabs.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.33.0411112023320.16903-100000@luna.ellen.dexterslabs.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: danny@mailmij.org
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

danny@mailmij.org wrote:
> In the process of fixing up the alsa output plugin of bmp a bit I've come
> upon a weird problem. The mp3s I was playing played to fast, with a
> audible click each few millisecond. This seemed to only happen when the
> period size was not a power of 2 (the output plugin used to set
> period_time). I've now calculated the period_size myself from the rate and
> set it to the nearest power of 2. Which seems to work fine,

There is no general power-of-2 requirement in ALSA.  The pmac driver
doesn't set a hardware constraint; if the hardware requires power-of-2
periods, it's a bug in the driver.

> except in the case that the mp3 i play is not your regular 441000
> kbs encoded, but for instance 32000.
>
> No error occurs on setting the rate (and it gets set at
> 32000, although I doubt that the card, a pmac snapper, can do this) It
> seems that period size and buffersize get downscaled with a factor
> 441000/32000. And the weird screwed up sound occurs again with these mp3s.
> The strangest thing is that although snd_pcm_params_get_* returns,
> for instance, 32000, 5944 and 763 for rate, buffersize and periodsize
> respectively, a cat /proc/asound/card0/pcm0p/sub0/hw_params tells me that
> actually the rate is 44100 and buffer 8192 and period 1015

The "default" device uses the "plug" plugin for automatic sample rate
conversion.


HTH
Clemens



-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
