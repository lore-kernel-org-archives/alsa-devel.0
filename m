From: Devin Anderson <surfacepatterns@gmail.com>
Subject: Re: How to send non-SysEx system messages via ALSA?
Date: Tue, 5 Mar 2013 21:09:53 -0800
Message-ID: <CAG7zqTpP84eitHHguZiDnfT8qp4Z9BWiKYpGa8h6BNu654vRVQ@mail.gmail.com>
References: <8E4C156DA5797D418DBFADFD8CE655A422BA54AFBB@HE113481.emea1.cds.t-internal.com>
 <5135DC3C.20706@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ia0-f182.google.com (mail-ia0-f182.google.com
 [209.85.210.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 433E2265312
 for <alsa-devel@alsa-project.org>; Wed,  6 Mar 2013 06:09:54 +0100 (CET)
Received: by mail-ia0-f182.google.com with SMTP id w21so723090iac.41
 for <alsa-devel@alsa-project.org>; Tue, 05 Mar 2013 21:09:53 -0800 (PST)
In-Reply-To: <5135DC3C.20706@ladisch.de>
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
Cc: alsa-devel@alsa-project.org, Joerg-Cyril.Hoehle@t-systems.com
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 5, 2013 at 3:51 AM, Clemens Ladisch <clemens@ladisch.de> wrote:
> Joerg-Cyril.Hoehle@t-systems.com wrote:
>> B. Use SND_SEQ_EVENT_TICK
>
> This is not a MIDI message.  (In fact, this message is not used at all.
> Er, and don't believe what its comment says.)

I thought SND_SEQ_EVENT_TICK corresponded to a non-standard (formerly
standard?) MIDI message:

    http://www.blitter.com/~russtopia/MIDI/~jglatt/tech/midispec/tick.htm

-- 
Devin Anderson
surfacepatterns (at) gmail (dot) com

blog - http://surfacepatterns.blogspot.com/
midisnoop - http://midisnoop.googlecode.com/
psinsights - http://psinsights.googlecode.com/
synthclone - http://synthclone.googlecode.com/
