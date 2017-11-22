From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Disable DAPM for click avoidance ?
Date: Wed, 22 Nov 2017 13:33:37 +0100
Message-ID: <alpine.DEB.2.11.1711221315370.27895@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D4BE267758
 for <alsa-devel@alsa-project.org>; Wed, 22 Nov 2017 13:33:44 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by bastet.se.axis.com (Postfix) with ESMTP id 10398183EA
 for <alsa-devel@alsa-project.org>; Wed, 22 Nov 2017 13:33:44 +0100 (CET)
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
 by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id gOsKBy1sYSHk for <alsa-devel@alsa-project.org>;
 Wed, 22 Nov 2017 13:33:43 +0100 (CET)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
 by bastet.se.axis.com (Postfix) with ESMTPS id 72BAD185B3
 for <alsa-devel@alsa-project.org>; Wed, 22 Nov 2017 13:33:43 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 346171E072
 for <alsa-devel@alsa-project.org>; Wed, 22 Nov 2017 13:33:43 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 28E8D1E054
 for <alsa-devel@alsa-project.org>; Wed, 22 Nov 2017 13:33:43 +0100 (CET)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
 by boulder03.se.axis.com (Postfix) with ESMTP
 for <alsa-devel@alsa-project.org>; Wed, 22 Nov 2017 13:33:43 +0100 (CET)
Received: from XBOX03.axis.com (xbox03.axis.com [10.0.5.17])
 by thoth.se.axis.com (Postfix) with ESMTP id 1CFF017A9
 for <alsa-devel@alsa-project.org>; Wed, 22 Nov 2017 13:33:43 +0100 (CET)
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


I'm having an issue with a codec where the normal DAPM procedure of =

disabling most of the codec when there is no stream ongoing results in =

large clicks when a playback stream starts and stops, because the output =

jumps from 0V when the output is disabled to over a volt when the output =

is enabled. =


There appears to be a 'slow stop/start' feature in the codec, however, it =

takes about one second to ramp up and down the output voltage, and that is =

too long a delay when starting a stream.

In our usecase the power consumtion of the codec is negligable =

compared to the rest of the electronics, so leaving the codec running at =

all times is perfectly feasible.

Is there any way from a machine driver to disable the DAPM switching, i.e. =

leave parts of the codec running at all times? In this specific case, =

there are two internal PM controls which enable the output. One of them is =

controlled by an output mixer element (SND_SOC_DAPM_MIXER_E), and the =

other one from set_bias_level().

I've had a look in the core code, but it seems that the whole business of =

changing the bias level when a stream is started is always performed and =

that there is no way to say "Set the bias level to ON and leave it there".

An alternative would be to augment the codec driver with an 'always on' =

feature, which effectively always enables PM for certain parts of the =

chip. But it seems like the wrong place to do this type of thing.

Another use for this feature is that we have had a lot of problems over =

the years with buggy I2S interfaces misbehaving when streams are started =

and stopped, and there would be an advantage to letting the AIF run the =

whole time after startup.

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
