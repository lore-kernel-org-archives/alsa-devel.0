From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Buffer underrun in a not empty playback buffer
Date: Wed, 25 Jul 2012 09:01:13 +0200
Message-ID: <500F99B9.1050905@ladisch.de>
References: <500F9321.30305@voiceinterconnect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 2BE922652D7
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2012 09:01:14 +0200 (CEST)
In-Reply-To: <500F9321.30305@voiceinterconnect.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Christian Gruber <christian.gruber@voiceinterconnect.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Christian Gruber wrote:
> I had a problem with an ALSA-driver, which causes an underrun in the
> playback stream before the playback buffer was completely empty
> (snd_pcm_avail() < playback buffer size). The driver developer told
> me, that this is correct, since for correct DMA transfer a minimum
> buffer filling level is required.

There is indeed a minimum buffer filling level.  If the device reads
data out of the buffer x bytes at a time, then you'd better make sure
that there are at least x bytes available.

> Is this an allowed ALSA-driver behaviour

This has nothing to do with the driver itself; the ALSA framework checks
for underruns.

Furthermore, the underrun does not happen before the buffer is empty;
underruns are alway detected after the fact.  It's just that your
application will never be able to read snd_pcm_avail()==0 because that
value would automatically trigger the underrun detection.

(Or does that driver, which you did not name, do additional checks?)

> how can I get to know about the required minimum buffer filling level
> before an underrun occurs?

The minimum buffer filling level _before_ an underrun is one frame.
However, to ensure that the device has enough data available, and to
protect against random scheduling delays, your application should
try to keep the buffer always as much filled as possible.

There is no function to read the device's read block size.  However, for
large block sizes, snd_pcm_hw_params_is_block_transfer() returns 1, and
the block size cannot be larger than one period.  (Quite a few embedded
devices indeed transfer entire periods.)


Regards,
Clemens
