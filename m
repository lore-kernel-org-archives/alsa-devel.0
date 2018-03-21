From: "Wischer, Timo (ADITG/ESB)" <twischer@de.adit-jv.com>
Subject: Re: [PATCH - JACK plugin 4/4] jack: Support
 snd_pcm_drain()
Date: Wed, 21 Mar 2018 16:22:27 +0000
Message-ID: <B0FB33DC1499054591F62C0EF1E013D7684FE16C@HI2EXCH01.adit-jv.com>
References: <s5hd10qyg05.wl-tiwai@suse.de>
 <1519910048-19732-1-git-send-email-twischer@de.adit-jv.com>
 <1519910048-19732-5-git-send-email-twischer@de.adit-jv.com>
 <3f0f0873-9544-050d-ef69-35d4b23e8c6c@perex.cz>
 <B0FB33DC1499054591F62C0EF1E013D7684FDEA1@HI2EXCH01.adit-jv.com>,
 <07334145-d1f1-54b4-84d0-eacbea0a3987@perex.cz>,
 <B0FB33DC1499054591F62C0EF1E013D7684FDF04@HI2EXCH01.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.de.adit-jv.com (smtp1.de.adit-jv.com [62.225.105.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 6030A267282
 for <alsa-devel@alsa-project.org>; Wed, 21 Mar 2018 17:22:37 +0100 (CET)
In-Reply-To: <B0FB33DC1499054591F62C0EF1E013D7684FDF04@HI2EXCH01.adit-jv.com>
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
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Jaroslav and Takashi,

What do you think about my "ugly" solution?
Should I provide a patch for it or do we want to keep snd_pcm_drain() block=
ing as all other IO plugins it do?

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
