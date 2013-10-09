From: Uli Franke <uli.franke@weiss.ch>
Subject: firewire amdtp details
Date: Wed, 9 Oct 2013 17:14:45 +0200
Message-ID: <525572E5.3040600@weiss.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from zhhdzmsp-mail16.bluewin.ch (zhhdzmsp-mail16.bluewin.ch
 [195.186.227.122])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E5512654EB
 for <alsa-devel@alsa-project.org>; Wed,  9 Oct 2013 17:14:46 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Daniel Weiss <weiss@weiss.ch>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Rolf Anderegg <Rolf.Anderegg@weiss.ch>
List-Id: alsa-devel@alsa-project.org

Hi Clemens

One of the reasons why we are working on snd_dice is because we
experienced (rare but unacceptable nevertheless) audio dropouts with the
original driver. The DICE PLL lost lock in such cases. Investigations
showed that this varies with the hardware/temperature/sun
spots/snowfall. This led me to the conclusion that the device
buffering/SYT-timing must be somehow close to its limits (late/early).
In such a case just little node clock differences (induced by
temperature and alike) can cause the system to drop out of the PLL's
locking range.

During capture mode SYT implementation/review I re-read the SYT code and
found the following:

from amdtp_stream_set_parameters:

  /* default buffering in the device */
  s->transfer_delay = TRANSFER_DELAY_TICKS - TICKS_PER_CYCLE;
  if (s->flags & CIP_BLOCKING)
      /* additional buffering needed to adjust for no-data packets */
      s->transfer_delay += TICKS_PER_SECOND * amdtp_syt_intervals[sfc] /
                           rate;

which sets a global transfer delay. But later in calculate_syt I get the
impression that (not exactly) the same operations are performed again
accidentally:

  if (syt_offset < TICKS_PER_CYCLE) {
      syt_offset += TRANSFER_DELAY_TICKS - TICKS_PER_CYCLE;
      if (s->flags & CIP_BLOCKING)
          syt_offset += s->transfer_delay;
      syt = (cycle + syt_offset / TICKS_PER_CYCLE) << 12;
      syt += syt_offset % TICKS_PER_CYCLE;

      return syt & 0xffff;
  }

When I interpret the code from set_parameters as some sort of
precomputation, the code in calculate_syt should be something like this:

  if (syt_offset < TICKS_PER_CYCLE) {
      syt_offset += s->transfer_delay;
      syt = (cycle + syt_offset / TICKS_PER_CYCLE) << 12;
      syt += syt_offset % TICKS_PER_CYCLE;

      return syt & 0xffff;
  }

This could explain that the stream gets delayed too much - resulting in
late timing (to be verified though).

Therefore I'm a bit curious if you could enlighten me about this as
s->transfer_delay isn't used in any other place.

Additionally I appreciate any justifications for the subtraction of
TICKS_PER_CYCLE from the global transfer delay. This would help me to
get a better understanding of snd_dice's SYT mechanics.

Regards
Uli
