From: Jonathan Woithe <jwoithe@just42.net>
Subject: Re: [FFADO-devel] [RFC][PATCH 06/37] ALSA:
 firewire-lib: add throttle for MIDI data rate
Date: Sun, 12 Jul 2015 18:01:27 +0930
Message-ID: <20150712083127.GA30791@marvin.atrad.com.au>
References: <1436623968-10780-1-git-send-email-o-takashi@sakamocchi.jp>
 <1436623968-10780-7-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.atrad.com.au (server.atrad.com.au [150.101.241.2])
 by alsa0.perex.cz (Postfix) with ESMTP id E1A1D260687
 for <alsa-devel@alsa-project.org>; Sun, 12 Jul 2015 10:31:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1436623968-10780-7-git-send-email-o-takashi@sakamocchi.jp>
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

Hi again Takashi

On Sat, Jul 11, 2015 at 11:12:17PM +0900, Takashi Sakamoto wrote:
> Typically, the target devices has internal buffer to adjust output of
> received MIDI messages for MIDI serial bus. The capacity of the buffer
> is limited, while IEEE 1394 transactions can transfer more MIDI messages
> than MIDI serial bus can. For this reason, the MIDI transmission rate
> should be constrained.

It is good that the core has rate throttling.  I haven't looked at the code
in enough detail but it is important for MOTU devices that it is possible to
make the throttling code do the right thing on the assumption that the
firewire device does not actually have a buffer at all.  Experiments done in
the past have shown that at least some MOTU models are not able to cope with
MIDI data that is sent any faster than the literal line rate of 31250 bps. 
That is, if the bytes of even a single MIDI message are sent faster than
31250 bps then the MIDI bitstream output by the device will be corrupted due
to the dropping of one or more bytes from the message (or other random
creative changes to the data bytes).

In other words, it will need to be possible to tell the throttling code that
the buffer size in the device is 1 byte long and have the code only send to
the MOTU at 31250 bps.  MOTUs cannot be assumed to have any internal buffer
for MIDI bytes.

Obviously software is very likely to send MIDI bytes faster than 31250 bps,
so in the FFADO MOTU MIDI code I needed to implement a short circular buffer
in FFADO in order to match these two rates.  In FFADO this buffer is sized
at 2^10 bytes and this seems to work reliably: so long as the average rate
sent by software stays below 31250 bps, everything is ok.  The relatively
large size is required in order to deal with sysex messages.  I imagine it
will be necessary to provide similar functionality in this implementation of
that driver in ALSA.

Regards
  jonathan
