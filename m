From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: ERROR messages when PROBE_DEFER ?
Date: Mon, 16 May 2016 17:37:09 +0200
Message-ID: <alpine.DEB.2.02.1605161729240.31333@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
 by alsa0.perex.cz (Postfix) with ESMTP id 042ED266040
 for <alsa-devel@alsa-project.org>; Mon, 16 May 2016 17:37:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by bes.se.axis.com (Postfix) with ESMTP id 93BAD2E18D
 for <alsa-devel@alsa-project.org>; Mon, 16 May 2016 17:37:15 +0200 (CEST)
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
 by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id prM2tGcsuLhi for <alsa-devel@alsa-project.org>;
 Mon, 16 May 2016 17:37:15 +0200 (CEST)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
 by bes.se.axis.com (Postfix) with ESMTP id 123392E1A6
 for <alsa-devel@alsa-project.org>; Mon, 16 May 2016 17:37:15 +0200 (CEST)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
 by postfix.imss71 (Postfix) with ESMTP id E01A116EA
 for <alsa-devel@alsa-project.org>; Mon, 16 May 2016 17:37:14 +0200 (CEST)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
 by boulder.se.axis.com (Postfix) with ESMTP id D55F51666
 for <alsa-devel@alsa-project.org>; Mon, 16 May 2016 17:37:14 +0200 (CEST)
Received: from XBOX03.axis.com (xbox03.axis.com [10.0.5.17])
 by seth.se.axis.com (Postfix) with ESMTP id D3D39FC6
 for <alsa-devel@alsa-project.org>; Mon, 16 May 2016 17:37:14 +0200 (CEST)
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


In sound/soc/soc-core.c:snd_bind_dai_link() (and a couple of other =

places), there are a number of dev_err printouts followed by return =

-EPROBE_DEFER. Should these really be ERROR messages, as a probe deferral =

is not an error?

Admittedly, if there really is a problem, it's nice to get some =

information about it, so perhaps the error level should be relaxed =

somewhat?

A case in point would be a SOC machine driver which needs a GPIO which is =

not loaded until after the kernel has booted.

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
