From: Christian Gruber <christian.gruber@voiceinterconnect.de>
Subject: Buffer underrun in a not empty playback buffer
Date: Wed, 25 Jul 2012 08:33:05 +0200
Message-ID: <500F9321.30305@voiceinterconnect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dd14716.kasserver.com (dd14716.kasserver.com [85.13.136.34])
 by alsa0.perex.cz (Postfix) with ESMTP id 500BE2652AF
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2012 08:29:06 +0200 (CEST)
Received: from server-a.vic.site (146-52-60-185-dynip.superkabel.de
 [146.52.60.185])
 by dd14716.kasserver.com (Postfix) with ESMTPSA id 0DCE566C23B
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2012 08:29:08 +0200 (CEST)
Received: from kepler.vic.site ([192.168.13.149])
 by server-a.vic.site with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.72) (envelope-from <gruber@voiceinterconnect.de>)
 id 1Stv5l-0000N0-3K
 for alsa-devel@alsa-project.org; Wed, 25 Jul 2012 08:29:07 +0200
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

I had a problem with an ALSA-driver, which causes an underrun in the playba=
ck stream =

before the playback buffer was completely empty (snd_pcm_avail() < playback=
 buffer size). =

The driver developer told me, that this is correct, since for correct DMA t=
ransfer a =

minimum buffer filling level is required.

Is this an allowed ALSA-driver behaviour or does the ALSA-driver developer =
has to hide all =

DMA internals to the application developer so that an underrun just occurs,=
 when the =

playback buffer is empty? If yes, how can I get to know about the required =
minimum buffer =

filling level before an underrun occurs?

Regards,
Christian

-- =

---------------------------------------------------------------
Dipl.-Ing. Christian Gruber
voiceINTERconnect GmbH
Ammonstra=DFe 35
01067 Dresden
Germany

Tel.:   +49 (0) 351 - 407 526 67
Fax.:   +49 (0) 351 - 407 526 55
---------------------------------------------------------------
www.voiceinterconnect.de
... smart signal processing for electronic devices

Gesch=E4ftsf=FChrung:               Eingetragen im Handelsregister:
Dr.-Ing. Diane Hirschfeld,      Amtsgericht Dresden HRB 19466
Ludwig Linkenheil
