From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: alsa-lib and floating point support
Date: Wed, 20 Sep 2017 12:55:30 +0200
Message-ID: <alpine.DEB.2.11.1709201244490.14549@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F16D266B21
 for <alsa-devel@alsa-project.org>; Wed, 20 Sep 2017 12:55:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by bastet.se.axis.com (Postfix) with ESMTP id 0A3A5181C4
 for <alsa-devel@alsa-project.org>; Wed, 20 Sep 2017 12:55:38 +0200 (CEST)
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
 by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id K08wwBAkTUzj for <alsa-devel@alsa-project.org>;
 Wed, 20 Sep 2017 12:55:37 +0200 (CEST)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
 by bastet.se.axis.com (Postfix) with ESMTPS id 518A3189FF
 for <alsa-devel@alsa-project.org>; Wed, 20 Sep 2017 12:55:37 +0200 (CEST)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 415A91A09B
 for <alsa-devel@alsa-project.org>; Wed, 20 Sep 2017 12:55:37 +0200 (CEST)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 36AEB1A09A
 for <alsa-devel@alsa-project.org>; Wed, 20 Sep 2017 12:55:37 +0200 (CEST)
Received: from seth.se.axis.com (unknown [10.0.2.172])
 by boulder02.se.axis.com (Postfix) with ESMTP
 for <alsa-devel@alsa-project.org>; Wed, 20 Sep 2017 12:55:37 +0200 (CEST)
Received: from XBOX03.axis.com (xbox03.axis.com [10.0.5.17])
 by seth.se.axis.com (Postfix) with ESMTP id 2A6F9183F
 for <alsa-devel@alsa-project.org>; Wed, 20 Sep 2017 12:55:37 +0200 (CEST)
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
Cc: Mersad Jelacic <mersad@axis.com>
List-Id: alsa-devel@alsa-project.org


We recently came across an issue with the alsa-lib softvol plugin, which =

requires hardware floating-point (i.e. --with-softfloat not enabled during =

build) support in order to use anything but a set of default values (min =

gain -51 dB, max 0 dB, and 256 gain steps). With no hardware floating =

point support, the plugin just prints an error message when loaded.

static int softvol_load_control(snd_pcm_t *pcm, snd_pcm_softvol_t *svol,
 ...
#ifndef HAVE_SOFT_FLOAT
 ...
                        double v =3D (pow(10.0, db / 20.0) * (double)(1 << =

VOL_SCALE_SHIFT));
 ...
#else
                SNDERR("Cannot handle the given dB range and resolution");
                return -EINVAL;
#endif
        }
 ...

I'm trying to understand why it is critical to have hardware floating =

point support in this case. The pow() function is very resource hungry, =

true, but the function is only called when the plugin is loaded, and not =

for instance on every sample while the stream is running, so on the whole =

I would expect the impact to be minimal. Is there some other rationale =

that I'm missing?

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
