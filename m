From: vanDongen-Gilcher <gml@xs4all.nl>
Subject: rme96 and mmap, bug?
Date: Mon, 25 Nov 2002 23:24:06 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <0ClXuX241FA30000.gml@xs4all.nl>
References: <200207011724.g61HOt716880@d1o1116.telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200207011724.g61HOt716880@d1o1116.telia.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Anders Torger <torger@ludd.luth.se>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi all,

When I try to use mmap with this card I get the following behaviour:
(BTW, I give an explicit snd_pcm_start)
In stereo-mode (device 0), I can preload the buffer with 2 periods of audio 
data, start and it works well.
In ADAT-mode (device 1), trying to preload with 2 periods, gives a very 
distorted sound. It only works with preloading 3 (or more) periods before 
starting.

When I use regular writei, I don't see this limitation. I only need 2 
periods of audio in ADAT-mode.


Is this a bug of the driver, or a property of the card?


regards

Gerard



-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
