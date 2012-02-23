From: Philip Spencer <pspencer@fields.utoronto.ca>
Subject: Re: [PATCH] Wrong latency in pulseaudio plugin breaks
 Adobe Flash Player
Date: Wed, 22 Feb 2012 21:50:57 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1202222059170.29627@fields.fields.utoronto.ca>
References: <alpine.LFD.2.00.1202161015470.19707@lpc8.fields.utoronto.ca>
	<4F3DAC41.4000602@canonical.com>
	<alpine.LFD.2.00.1202162248280.21549@fields.fields.utoronto.ca>
	<4F3E1A04.9080404@canonical.com>
	<alpine.LFD.2.00.1202171351300.11808@lpc8.fields.utoronto.ca>
	<4F42323E.1030204@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fileserver.fields.utoronto.ca (fileserver.fields.utoronto.ca
	[128.100.216.10])
	by alsa0.perex.cz (Postfix) with ESMTP id 4DF5C103BDA
	for <alsa-devel@alsa-project.org>; Thu, 23 Feb 2012 03:51:02 +0100 (CET)
In-Reply-To: <4F42323E.1030204@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thank you for the reply! (I've not quoted below because it was getting too 
cumbersome and the contents of this message are somewhat different from 
the previous discussions).

I have now dug into exactly what's happening by putting trace statements 
in all the alsa calls, and it turns out to be something very different 
from what I thought. It isn't pulseaudio at all that's introducing the 
extra latency, nor are underruns happening there.

What's happening is this:

   - Flash Player's understanding of ALSA polling and snd_pcm_wait is
     different from how ALSA actually behaves; it expects to be able to
     use these to wake up at the time of the next IO period.

   - After putting the first few packets into the buffer (each packet has
     20ms of samples, and 20ms is the IO period length), it waits about
     16.4 ms then calls snd_pcm_wait.

   - It expects the call to return at the start of the next I/O period
     (when the first 20ms worth of data have been played) and then writes
     the next packet, which by then it will have received from the network.

   - However, that's not how ALSA works. If the buffer isn't full, polling
     returns immediately, instead of waiting for the next I/O period.

   - Flash player then thinks playback is happening at an accelerated rate.
     The first time it probably has a packet or two buffered up internally
     so it sends those packets, but when these run out it inserts extra
     packets of silence and then starts trying to resample the incoming
     data to match what it thinks is a faster playback rate, resulting
     in extra packets being passed to ALSA: a 20ms packet is written
     every 16.4ms.

   - Eventually (after about 2.5 seconds) these extra packets have filled
     up the buffer and then Flash Player's snd_pcm_wait calls actually
     block until the next I/O period. At this point playback stabilizes
     but with a 500ms latency due to the now-full buffer.

This presumably happens with other ALSA backends too, not just the 
pulseaudio plugin.

If I change the pulseaudio plugin so that:

    -- Whenever a write request callback is received from pulseaudio,
       it records the writable size

    -- Whenever writes occur that reduce the writable size by at least
       an IO period's worth from the value that was recorded, polling is
       deactivated, and the "avail_min" parameter is adjusted so that
       the pcm will only be considered "ready" when the available bytes
       rise by an IO period's amount.

    -- When the next write request callback is received (pulseaudio
       seems to send them whenever an IO period's worth of samples are
       transferred to the sink), avail_min is reset to its normal
       value and polling is reactivated

thereby establishing the polling behaviour flash player seems to expect, 
then it works flawlessly.

However, that's probably not how ALSA was intended to behave -- or is it?
The documentation is somewhat ambiguous, and it does seem to imply in 
places that polling can be used to "wake up once every IO period".

What is the "right" behaviour in the following scenario?

    1. An app writes samples, at least one I/O period's worth, but not
       a full buffer's worth.

    2. The app then calls pcm_snd_wait, or calls poll or select on the
       polling file descriptors.

    3. What should happen?

           (a) The call returns immediately, since there's lots of room
               in the buffer.

           (b) The call returns after one I/O period's worth of data has
               been drained from the buffer.

If the correct answer is (a) (ALSA's current behaviour), then is there 
any mechanism for an app to achieve (b) -- get woken up after one I/O 
period's worth of data have been drained (other than just doing some
infinite loop of sleeping then checking snd_pcm_avail periodically)?

If the correct answer is (b), then things would need to be changed in 
ALSA, but would this break any existing apps that wait or poll before
filling up the buffer?

If ALSA were to be changed to behave as (b), then an app can easily 
achieve the old behaviour (a) by simply doing

     if (snd_pcm_avail(...) < ...) snd_pcm_wait(...)

instead of a plain snd_pcm_wait, but I don't see how to easily achieve (b)
if ALSA behaves as (a).

Do you, or anyone, have a definitive answer on what the "right" polling 
behaviour should be, and is ALSA currently doing the right thing or not?

Thanks,

Philip

--------------------------------------------+-------------------------------
Philip Spencer  pspencer@fields.utoronto.ca | Director of Computing Services
Room 336        (416)-348-9710  ext3036     | The Fields Institute for
222 College St, Toronto ON M5T 3J1 Canada   | Research in Mathematical Sciences
