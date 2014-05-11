From: Adam Goode <agoode@chromium.org>
Subject: Support for getting "manufacturer" from
	snd_seq_client_info and/or snd_ctl_card_info
Date: Sat, 10 May 2014 21:18:20 -0400
Message-ID: <CAOf41NnbBTYrfN10GUcxzdHmKZJj0YT=DC3ntfjuhpb=fa+o=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f173.google.com (mail-ie0-f173.google.com
 [209.85.223.173])
 by alsa0.perex.cz (Postfix) with ESMTP id C6ED8261A2B
 for <alsa-devel@alsa-project.org>; Sun, 11 May 2014 03:18:21 +0200 (CEST)
Received: by mail-ie0-f173.google.com with SMTP id rp18so5617002iec.4
 for <alsa-devel@alsa-project.org>; Sat, 10 May 2014 18:18:20 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I am doing a bit of work on the Alsa Web MIDI implementation in Chrome:
https://code.google.com/p/chromium/issues/detail?id=344410

Web MIDI likes to know the "manufacturer" field as part of its API:
http://webaudio.github.io/web-midi-api/#attributes-3

The current implementation in Chrome uses rawmidi, and then tries to parse
out the manufacturer from the longname of the card. This works reasonably
well, but is brittle and results in a lot of code.

I am working on a seq implementation for Chrome, to replace the rawmidi
implementation. I can retain the manufacturer extraction hack on the card,
but seq requires yet another hack to guess the card for a particular seq
client.

Any suggestions on how to extract the manufacturer more easily? The best
solution would be to add a manufacturer (or vendor) field to the
snd_seq_client_info ioctl struct. This would likely require a new ioctl,
since there is only 64 bytes reserved in the current struct. I am guessing
this is not too likely to be accepted. (I would want to also add the same
manufacturer field to the snd_ctl_card_info.)

The next best solution would be to add a card field to snd_seq_client_info,
which could be optionally populated with the card that is associated to the
client.

A completely different solution would be to add all this info to sysfs
which is easier to extend dynamically and won't require any ioctl changes
at all. (I kind of like this solution the best, but it would be a change
from the ioctl-based mechanisms done so far.)

Ultimately, if I am stuck guessing and parsing, that will work as long as
the underlying implementation doesn't change. But I would rather have a
more reliable solution going forward.

Any thoughts?


Thanks,

Adam Goode
