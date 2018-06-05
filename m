From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Control that can't be set on Arturia AudioFuse
Date: Tue, 5 Jun 2018 15:45:59 +0200
Message-ID: <alpine.DEB.2.11.1806051540050.2601@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id A036B267909
 for <alsa-devel@alsa-project.org>; Tue,  5 Jun 2018 15:46:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by bastet.se.axis.com (Postfix) with ESMTP id C72AF18378
 for <alsa-devel@alsa-project.org>; Tue,  5 Jun 2018 15:46:07 +0200 (CEST)
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
 by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 9y2-M9H7Juz8 for <alsa-devel@alsa-project.org>;
 Tue,  5 Jun 2018 15:46:05 +0200 (CEST)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
 by bastet.se.axis.com (Postfix) with ESMTPS id 9114D183E1
 for <alsa-devel@alsa-project.org>; Tue,  5 Jun 2018 15:46:05 +0200 (CEST)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4FD1A1E09A
 for <alsa-devel@alsa-project.org>; Tue,  5 Jun 2018 15:46:05 +0200 (CEST)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 447031E09D
 for <alsa-devel@alsa-project.org>; Tue,  5 Jun 2018 15:46:05 +0200 (CEST)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
 by boulder03.se.axis.com (Postfix) with ESMTP
 for <alsa-devel@alsa-project.org>; Tue,  5 Jun 2018 15:46:05 +0200 (CEST)
Received: from XBOX03.axis.com (xbox03.axis.com [10.0.5.17])
 by thoth.se.axis.com (Postfix) with ESMTP id 3848F28D1
 for <alsa-devel@alsa-project.org>; Tue,  5 Jun 2018 15:46:05 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


Hi,

We recently purchased an Arturia AudioFuse USB sound card, and one thing =

is strange on this device. It exposes a single mixer control called
'ARTURIA Clock Selector Clock Source':

$ amixer -c 4

Simple mixer control 'ARTURIA Clock Selector Clock Source',0
  Capabilities: enum
  Items: 'ARTURIA Internal Clock' 'ARTURIA S/PDIF Clock' 'ARTURIA ADAT Cloc=
k' 'ARTURIA WORD Clock'
  Item0: 'ARTURIA Internal Clock'

However, attempting to set the control to any value has no effect; when =

reading using sget the original value is always returned. =


$ amixer -c 4 sset 'ARTURIA Clock Selector Clock Source' 'ARTURIA S/PDIF Cl=
ock'

Simple mixer control 'ARTURIA Clock Selector Clock Source',0
  Capabilities: enum
  Items: 'ARTURIA Internal Clock' 'ARTURIA S/PDIF Clock' 'ARTURIA ADAT Cloc=
k' 'ARTURIA WORD Clock'
  Item0: 'ARTURIA Internal Clock'

There is no error message (which there is if for instance attempting to =

set the control to an invalid value), it just doesn't 'stick'.

By using the proprietary configuration software in [a virtual] MS Windows =

I can change the value and also see the new value in Linux using amixer.

I've had the same problem with a completely different USB soundcard =

(minidsp USB streamer), so I'm suspecting it's a Linux thing rather than =

something specific for this soundcard.

Is there something I'm missing here from a Linux point of view?

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
