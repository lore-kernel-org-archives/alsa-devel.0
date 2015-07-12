From: Jonathan Woithe <jwoithe@just42.net>
Subject: Re: [FFADO-devel] [RFC][PATCH 31/37] ALSA:
 firewire-motu: add MOTU specific protocol layer
Date: Sun, 12 Jul 2015 10:35:15 +0930
Message-ID: <20150712010515.GA30499@marvin.atrad.com.au>
References: <1436623968-10780-1-git-send-email-o-takashi@sakamocchi.jp>
 <1436623968-10780-32-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.atrad.com.au (server.atrad.com.au [150.101.241.2])
 by alsa0.perex.cz (Postfix) with ESMTP id 05927260606
 for <alsa-devel@alsa-project.org>; Sun, 12 Jul 2015 03:05:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1436623968-10780-32-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi Takashi

Thanks for coding up a starting point of the MOTU firewire streaming
driver.  I have been seriously short of time this year and have not had a
chance to look at this yet.

On Sat, Jul 11, 2015 at 11:12:42PM +0900, Takashi Sakamoto wrote:
> Currently, this protocol layer causes noise like rectanglar wave, due to
> timestampling perhaps. The theory to implement timestamping is:
> 
>  * Using pre-computed table for the number of ticks per event:
>   *  44,1kHz: (557 + 123/441)
>   *  48.0kHz: (512 +   0/441)
>   *  88.2kHz: (278 + 282/441)
>   *  96.0kHz: (256 +   0/441)
>   * 176.4kHz: (139 + 141/441)
>   * 192.0kHz: (128 +   0/441)
>  * Accumulate the ticks and set the value to SPH for every events.
>  * This way makes sence for blocking transmission because this mode
>    transfers fixed number or none of events.
> 
> The reason is not clear.

The above approach will definitely not work and the resulting noise is not
unexpected.  The reason is that the MOTU audio clock is not locked to the
firewire bus clock in any way at all.  This means that you cannot base the
time stamps of the audio samples on the assumption that there is, for
example exactly 512 ticks per sample at 48 kHz.  Instead one must determine
the audio clock rate relative to the firewire cycle timer based on the
incoming audio packets from the device.  What this means is that the "ticks
per sample" is not a constant, is fractional (and possibly irrational), and
will vary from device to device (even on a single device depending on things
such as temperature of the internal timebase components).

In FFADO the generation of the audio clock used for timestamping tx packets
is done by locking an internal DLL to the incoming timestamps.  However, I
did it this way only because that was the way the rest of the FFADO
subsystem expected it to be done.  An alternative (which I had working very
early on with an out-of-tree proof of concept) is to base the advancing of
the tx timestamps on the differences seen in the rx timestamps.  Note that
there is an offset between the two due to pipeline delays.  I would have to
look up my early development notes on the MOTU driver to find out what that
was.

An alternative approach might be to simply use the arrival time of the
packet as a proxy for the internal timestamp.  However, since the timestamp
within the rx packet is likely to be more accurate for the purposes of
synchronising to the internal audio clock I would strongly suggest using
that.

The plan would therefore be as follows.  After starting streaming on the
device, wait for a few packets to arrive and store their timestamps.  During
this time it might be necessary to send "silence" packets - I would have to
check.  Then start transmission, with the tx timestamps being determined
from the timestamp queue and using a fixed offset as explained earlier.  I
would have to look up my old code to determine exactly how this worked in
practice, but it was stable and is a whole lot simpler than messing with
DLLs and other similar synchronisation mechanisms.

Another general comment about the MOTU streaming: when shutting streaming
down it is necessary to send a series of "silence" packets to the device
before disabling streaming.  If this is not done the device can end up in a
state where it outputs high amplitude oscillations (around 1-2 KHz) across
random channels.  I have comments within the FFADO driver source which refer
to this issue.

I don't have time to look through the rest of the patch right now but I will
try to do so in the next few days.

Regards
  jonathan
