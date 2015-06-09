From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Softvol only after device has opened
Date: Tue, 9 Jun 2015 13:08:26 +0200
Message-ID: <alpine.DEB.2.02.1506091304020.15001@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
 by alsa0.perex.cz (Postfix) with ESMTP id BFD4D265173
 for <alsa-devel@alsa-project.org>; Tue,  9 Jun 2015 13:08:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by bes.se.axis.com (Postfix) with ESMTP id 62C662E086
 for <alsa-devel@alsa-project.org>; Tue,  9 Jun 2015 13:08:28 +0200 (CEST)
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
 by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id L4jBB0csFBpS for <alsa-devel@alsa-project.org>;
 Tue,  9 Jun 2015 13:08:27 +0200 (CEST)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
 by bes.se.axis.com (Postfix) with ESMTP id 933FA2E085
 for <alsa-devel@alsa-project.org>; Tue,  9 Jun 2015 13:08:27 +0200 (CEST)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
 by postfix.imss71 (Postfix) with ESMTP id 7B600100C
 for <alsa-devel@alsa-project.org>; Tue,  9 Jun 2015 13:08:27 +0200 (CEST)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
 by boulder.se.axis.com (Postfix) with ESMTP id 6FA82208
 for <alsa-devel@alsa-project.org>; Tue,  9 Jun 2015 13:08:27 +0200 (CEST)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
 by seth.se.axis.com (Postfix) with ESMTP id 6DB083E049
 for <alsa-devel@alsa-project.org>; Tue,  9 Jun 2015 13:08:27 +0200 (CEST)
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


I'm working on implementing support for a MEMS microphone with an I2S =

connection. Since the microphone has no controls but simply outputs I2S =

data from the word go, this means that any gain must be applied later. =

(Microphones of this type are generally specified at outputting 0 dB FS at =

some rediculously high SPL, 120 dB SPL being typical). =


Since we use 16 bit audio in our (SOC) system, I'm trying to apply gain =

using the softvol ALSA plugin, before converting to 16 bit audio (the =

microphone outputs 24 bit audio).

One thing though, the 'softvol' plugin very correctly creates a mixer
control and it all works fine, but only after the device has been opened.
Before that the mixer control doesn't seem to exist, which means that we
cannot adjust the gain until the device is opened by some application.

Is this intentional, a bug, or something that is misconfigured on my part?

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
