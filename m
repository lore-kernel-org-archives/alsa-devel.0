From: Arnout Engelen <alsalist@bzzt.net>
Subject: HD Audio with 'mute light'
Date: Sat, 22 Sep 2012 20:54:11 +0200
Message-ID: <20120922185411.GE2822@bzzt.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="QxN5xOWGsmh5a4wb"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-6.concepts.nl (smtp-6.concepts.nl [213.197.30.114])
 by alsa0.perex.cz (Postfix) with ESMTP id 909122602AE
 for <alsa-devel@alsa-project.org>; Sat, 22 Sep 2012 20:54:15 +0200 (CEST)
Received: from 5ee5397b.ftth.concepts.nl
 ([94.229.57.123] helo=mail.bzzt.net ident=Debian-exim)
 by smtp-4.concepts.nl with esmtps (TLSv1:AES256-SHA:256) (Exim 4.72)
 (envelope-from <arnouten@bzzt.net>) id 1TFUqB-00059y-6c
 for alsa-devel@alsa-project.org; Sat, 22 Sep 2012 20:54:11 +0200
Received: from arnouten by localhost with local (Exim 4.72)
 (envelope-from <arnouten@bzzt.net>) id 1TFUqB-0002bj-Tx
 for alsa-devel@alsa-project.org; Sat, 22 Sep 2012 20:54:11 +0200
Content-Disposition: inline
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


--QxN5xOWGsmh5a4wb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I've got a laptop with a HD Audio onboard sound card: the CX20590.

It seems like this card has a sort of 'hardware mute state': the 'mute button'
has a light, and when this light is on, no sound is heard, regardless of
whether or not the channel is muted in the ALSA mixer.

The hardware mute button switches the 'hardware mute state', and also sends a
keyboard event which I can use to also update the ALSA mixer mute.

This doesn't, however, work the other way around: I haven't found any way yet
to manipulate the 'hardware mute state' from software.

Looking with hda_analyzer, I notice this card has a 'Vendor Defined Widget'.
Might this be something that could be used to manipulate the hardware mute
state? I can use hda-verb but I wouldn't know how to discover which verb to
use. Anything else to try?

Attached is the codec info.


Kind regards,

Arnout

--QxN5xOWGsmh5a4wb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="codecdescription.txt"


--QxN5xOWGsmh5a4wb
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--QxN5xOWGsmh5a4wb--
