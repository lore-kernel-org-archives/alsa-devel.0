From: <danny@mailmij.org>
Subject: period/buffer bug on pmac ?
Date: Thu, 11 Nov 2004 22:17:07 +0100 (CET)
Message-ID: <Pine.LNX.4.33.0411112023320.16903-100000@luna.ellen.dexterslabs.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


In the process of fixing up the alsa output plugin of bmp a bit I've come 
upon a weird problem. The mp3s I was playing played to fast, with a 
audible click each few millisecond. This seemed to only happen when the 
period size was not a power of 2 (the output plugin used to set 
period_time). I've now calculated the period_size myself from the rate and 
set it to the nearest power of 2. Which seems to work fine, except in the 
case that the mp3 i play is not your regular 441000 kbs encoded, but for 
instance 32000. 

No error occurs on setting the rate (and it gets set at 
32000, although I doubt that the card, a pmac snapper, can do this) It 
seems that period size and buffersize get downscaled with a factor 
441000/32000. And the weird screwed up sound occurs again with these mp3s. 
The strangest thing is that although snd_pcm_params_get_* returns, 
for instance, 32000, 5944 and 763 for rate, buffersize and periodsize 
respectively, a cat /proc/asound/card0/pcm0p/sub0/hw_params tells me that 
actually the rate is 44100 and buffer 8192 and period 1015 (I also checked 
on my x86 with sblive, but there the proc entry says that the rate is 
32000, so I assume that card can downsample in hardware?).

Is this a bug in the driver or normal behaviour? If it is the last, how 
should I set the periodsize to something that both corresponds with the 
users preferenced sample time and with the fact that it apparently, has to 
be a power of 2?

danny







-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
