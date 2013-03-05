From: "Demian Martin" <demianm_1@yahoo.com>
Subject: Re: ALSA: usb: Work around CM6631 sample
Date: Tue, 5 Mar 2013 15:37:39 -0800
Message-ID: <001f01ce19fa$6d770c80$48652580$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm29.bullet.mail.bf1.yahoo.com (nm29.bullet.mail.bf1.yahoo.com
 [98.139.212.188])
 by alsa0.perex.cz (Postfix) with ESMTP id 2B2102652FD
 for <alsa-devel@alsa-project.org>; Wed,  6 Mar 2013 00:37:45 +0100 (CET)
Content-Language: en-us
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: hegge@resisty.net
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Date: Tue, 5 Mar 2013 23:03:03 +0100
From: Torstein Hegge <hegge@resisty.net>
To: alsa-devel@alsa-project.org
Subject: [alsa-devel] [PATCH v3] ALSA: usb: Work around CM6631 sample
	rate	change bug
Message-ID: <20130305220303.GD20417@pvv.ntnu.no>
Content-Type: text/plain; charset=utf-8
The C-Media CM6631 USB-to-S/PDIF receiver doesn't respond to changes in
sample rate while the interface is active.

Reset the interface after setting the sampling frequency on sample rate
changes, to ensure that the sample rate set by snd_usb_init_sample_rate() is
used. Otherwise, the device will try to use the sample rate of the previous
stream, causing distorted sound on sample rate changes.

The reset is performed for all current C-Media UAC V2.0 devices, including
CM6610, CM6620 and CM6631, but has only been tested with CM6631.

Signed-off-by: Torstein Hegge <hegge@resisty.net>

I met with the CMedia team late last year. They told me that the chips are
different and they were showing me a CM6631a that has some key differences
from the CM6631. The two are pin compatible. I got the impression that the
driver requirements are different.

I asked about Linux support and what the problem was. First, on UAC2 Their
software wizard dug deep into the problem with their CM6631 and ALSA. He
concluded that there is a sequence problem between setting sample rate and
sending the "play' command. Something about UAC1 method not being the same
as UAC2. He indicated that the ALSA driver handles this differently from the
OSX and their Windows drivers. I may well have this description confused. In
any case he has a revised firmware for the new CM6631A chip that addresses
this in ALSA. I asked them to contribute the change but they seemed to get
distracted with other projects. Needless to say for them the volume on these
chips has been small.

I just requested that they contribute to this effort again. I don't know if
it will happen.
                              Demian
