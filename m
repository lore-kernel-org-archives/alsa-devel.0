From: "random.bits" <random.bits@rogers.com>
Subject: alsa driver, repeat playback of buffer contents
Date: Mon, 14 Mar 2005 15:30:20 -0500
Message-ID: <200503141530.20339.random.bits@rogers.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
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


I have been reading up on the alsa driver. I would like 
to have the alsa driver play a small pcm sound bite 
over and over without have to re-write it to the 
device.

By small, I mean 1.9K in length. I have followed the 
examples enough to get it to play the sound bite once, 
but I cannot figure out how to get it to play it 
multiple times without having to make another call to 
snd_pcm_writei() again.

This sound will play on in the background, while other 
cpu, data bus, and disk intensive work is being 
performed. 

Thank you for any pointers, tips or help.

Mark



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
