From: "Wischer, Timo (ADITG/ESB)" <twischer@de.adit-jv.com>
Subject: Re: [PATCH - JACK plugin 4/4] jack: Support
 snd_pcm_drain()
Date: Fri, 16 Mar 2018 14:44:28 +0000
Message-ID: <B0FB33DC1499054591F62C0EF1E013D7684FDEA1@HI2EXCH01.adit-jv.com>
References: <s5hd10qyg05.wl-tiwai@suse.de>
 <1519910048-19732-1-git-send-email-twischer@de.adit-jv.com>
 <1519910048-19732-5-git-send-email-twischer@de.adit-jv.com>,
 <3f0f0873-9544-050d-ef69-35d4b23e8c6c@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.de.adit-jv.com (smtp1.de.adit-jv.com [62.225.105.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 618FD267505
 for <alsa-devel@alsa-project.org>; Fri, 16 Mar 2018 15:44:36 +0100 (CET)
In-Reply-To: <3f0f0873-9544-050d-ef69-35d4b23e8c6c@perex.cz>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello Jaroslav

> Do you handle the non-blocking mode correctly here? It seems that this
> mode is completely ignored.

You are right. The non-blocking mode flag will be ignored here.
But this case is also not covered by the IO plug API.
snd_pcm_drop() is called immediately after the IO plugin drain callback ret=
urns [1].
The return value of the drain callback will be ignored.

Therefore the IO plug API has to be changed to support this.
But I do not really see a use case for it.
If you want to drain you also want to wait/block your application until all=
 frames were played.

If you think it is required to change anything in this patch
we have to clarify when drop should be called and when not.
What is the sequence which the user would expect?
Does the user need to call drop after drain is done or would it be called b=
y snd_pcm_wait/snd_pcm_drain when it is not returning -EAGAIN?

[1] http://git.alsa-project.org/?p=3Dalsa-lib.git;a=3Dblob;f=3Dsrc/pcm/pcm_=
ioplug.c;h=3D8c0ed4836365afb53c0cbce796a5d39c2d05a3d7;hb=3D07a17bd5a50289e2=
fdb2714a4e39f38f41811558#l504

Best regards

Timo Wischer

Advanced Driver Information Technology GmbH
Engineering Software Base (ADITG/ESB)
Robert-Bosch-Str. 200
31139 Hildesheim
Germany

Tel. +49 5121 49 6938
Fax +49 5121 49 6999
twischer@de.adit-jv.com

ADIT is a joint venture company of Robert Bosch GmbH/Robert Bosch Car Multi=
media GmbH and DENSO Corporation
Sitz: Hildesheim, Registergericht: Amtsgericht Hildesheim HRB 3438
Gesch=E4ftsf=FChrung: Wilhelm Grabow, Ken Yaguchi

________________________________________
From: Jaroslav Kysela [perex@perex.cz]
Sent: Thursday, March 01, 2018 2:42 PM
To: Wischer, Timo (ADITG/ESB)
Cc: ALSA development; Takashi Iwai
Subject: Re: [alsa-devel] [PATCH - JACK plugin 4/4] jack: Support snd_pcm_d=
rain()

Dne 1.3.2018 v 14:14 twischer@de.adit-jv.com napsal(a):
> From: Timo Wischer <twischer@de.adit-jv.com>
>
> Block on drain till available samples played

Do you handle the non-blocking mode correctly here? It seems that this
mode is completely ignored.

                                        Jaroslav

--
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
