From: "Tehn-Yit Chin" <Tehn-Yit.Chin@greyinnovation.com>
Subject: alsa dma transfer
Date: Wed, 29 Jun 2005 16:35:21 +1000
Message-ID: <9AEDBAA573BBD346BCF9637D80097D911DCCE9@greysvr02.GreyInnovation.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-class: urn:content-classes:message
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

Hi,

Please bear with me as I am a newbie at writing an ALSA device driver. I
am a bit confused as to how ALSA manages its buffers and memory.
Currently, I am confused as to audio data is being passed into the
device driver so that the driver can start the DMA transfer

I have read Takashi Iwai doc on "Writing an ALSA Driver" and reviewed
some of the drivers already in the source tree and was not able to get a
clear understanding of it.

>From what I can tell, runtime->dma_start is a virtual memory buffer that
has the audio data, and the amount of data to transfer is in
frames_to_bytes(runtime, runtime->period_size). Is this right?

And how do I tell pcm layer that the device does not support recording?

Many thanks,

Tehn Yit Chin=20
Software Engineer, Grey Innovation Pty. Ltd.


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
