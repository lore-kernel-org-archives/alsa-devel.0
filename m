From: "Gupta, Kshitij" <kshitij@ti.com>
Subject: Dma query
Date: Wed, 25 Feb 2004 15:55:22 +0530
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <F509E6111989D311B63700805FA761DA09F28FEB@DBDE01>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

hi,
	I have a very trivial question about the dma transfers with respect
to ALSA framework.  

Let me first explain a scenario
We have a 
Circularly linked Buffer pool

buf1    buf2    buf3     buf4  .... bufn

In very simple terms playing an audio stream is reading from these buffers
and continuously dma'ing it to the audio device (let's assume we have a read
and write register with the audio device).  And in this circulary linked
audio buffer the user fills the data and the driver empties it to the
device.

Now I am not able to fit this scenario in the ALSA framework.  I am
referrring to alsa-kernel/arm/sa11xx-uda1341.c file as a reference for my
driver.  And here I don't understand where do we specify the the exact dma
parameters (like the start address of buffer and the destination address).

Can someone enlighten me on this or else suggest me some other reference
driver.

regards
-kshitij




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
