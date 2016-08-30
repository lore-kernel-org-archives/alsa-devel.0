From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Range of pitchbend MIDI events
Date: Tue, 30 Aug 2016 10:15:41 +0200
Message-ID: <61c9fbcc-221d-bc63-0ba3-4977b67d31a7@ladisch.de>
References: <CAPn+-XSsDEe3ruu7vYmdNgneLpK13VxYVm860JAt4cwFe86soQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 5DDC926670B
 for <Alsa-devel@alsa-project.org>; Tue, 30 Aug 2016 10:15:42 +0200 (CEST)
In-Reply-To: <CAPn+-XSsDEe3ruu7vYmdNgneLpK13VxYVm860JAt4cwFe86soQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Maurizio Berti <maurizio.berti@gmail.com>
Cc: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Maurizio Berti wrote:
> I was playing with pyalsa and I realized an unexpected behavior with
> pitchbend events.
> The pitchbend range should be, by MIDI standard, between -8192 and +8191,
> or 0-16384. Being a 3 byte event, it should ignore any subsequent byte
> received.
>
> Using pyalsa I'm able to create events with values greater than 127

The ALSA sequencer does not use the MIDI byte format for its events.

Sequencer events use a 32-bit field for controller values:
http://www.alsa-project.org/alsa-doc/alsa-lib/structsnd__seq__ev__ctrl__t.html
and the entire structure is delivered unchanged to the receiving
sequencer client.

Events get converted into actual MIDI bytes only when they end up at
a real MIDI port.  In that case, only the lowest 14 bits of the value
are put into the two data bytes of the pitchbend event.


Regards,
Clemens
