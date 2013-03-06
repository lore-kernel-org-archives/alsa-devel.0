From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: How to send non-SysEx system messages via ALSA?
Date: Wed, 06 Mar 2013 09:22:01 +0100
Message-ID: <5136FCA9.1060806@ladisch.de>
References: <8E4C156DA5797D418DBFADFD8CE655A422BA54AFBB@HE113481.emea1.cds.t-internal.com>
 <5135DC3C.20706@ladisch.de>
 <CAG7zqTpP84eitHHguZiDnfT8qp4Z9BWiKYpGa8h6BNu654vRVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id C956526030A
 for <alsa-devel@alsa-project.org>; Wed,  6 Mar 2013 09:22:12 +0100 (CET)
In-Reply-To: <CAG7zqTpP84eitHHguZiDnfT8qp4Z9BWiKYpGa8h6BNu654vRVQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Devin Anderson <surfacepatterns@gmail.com>
Cc: alsa-devel@alsa-project.org, Joerg-Cyril.Hoehle@t-systems.com
List-Id: alsa-devel@alsa-project.org

Devin Anderson wrote:
> On Tue, Mar 5, 2013 at 3:51 AM, Clemens Ladisch <clemens@ladisch.de> wrote:
>> Joerg-Cyril.Hoehle@t-systems.com wrote:
>>> B. Use SND_SEQ_EVENT_TICK
>>
>> This is not a MIDI message.  (In fact, this message is not used at all.
>> Er, and don't believe what its comment says.)
>
> I thought SND_SEQ_EVENT_TICK corresponded to a non-standard (formerly
> standard?) MIDI message:
>
>     http://www.blitter.com/~russtopia/MIDI/~jglatt/tech/midispec/tick.htm

SND_SEQ_EVENT_TICK doesn't correspond to anything.  It's unused.

And F9 has never been standardized.


Regards,
Clemens
