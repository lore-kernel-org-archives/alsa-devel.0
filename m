From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: ADAU1761 default register value problem
Date: Thu, 21 Apr 2016 16:01:35 +0200
Message-ID: <alpine.DEB.2.02.1604211547540.31333@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
 by alsa0.perex.cz (Postfix) with ESMTP id 65ADD2612CC
 for <alsa-devel@alsa-project.org>; Thu, 21 Apr 2016 16:01:46 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


Hi Lars,

A while ago I posted a question to the list regarding the default values =

set up for the ADAU1761 (and similar CODECs), but I didn't get a response. =

I really need to try and figure out a way forward here though so I'll =

bring this up again.

The problem I have is that the driver assumes that the CODEC has been =

initialized with the default register settings when the system boots. =

However, if the system has not been power cycled but just rebooted, this =

is not necessarily the case, as the CODEC has no external reset pin but =

derives its reset signal internally from the power level.

Furthermore, if the system upon reboot tries to set a register value to =

one of the default settings (for example as the result of a hw_params() =

call), then the regcache mechanism will disregard the write as it assumes =

the default value is already set, which is not necessarily the case.

As I see it the solution to this problem is simply not to assume anything =

about the register settings, so that the first write to a given register =

always takes effect.

I can work on a patch to accomplish this, however, since so much work =

apparently has been laid down in getting the default values into the =

driver in the first place, I'm assuming there's something more to the =

story that I'm missing, so I'd like to get a better grip on this before I =

dive in.

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
