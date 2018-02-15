From: "Wischer, Timo (ADITG/ESB)" <twischer@de.adit-jv.com>
Subject: Re: [PATCH - JACK PCM plugin] jack: Use boundary as
 hw_ptr wrap around
Date: Thu, 15 Feb 2018 10:36:21 +0000
Message-ID: <B0FB33DC1499054591F62C0EF1E013D7684F9297@HI2EXCH01.adit-jv.com>
References: <1516794545-9868-1-git-send-email-twischer@de.adit-jv.com>,
 <s5hd1183jq3.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.de.adit-jv.com (smtp1.de.adit-jv.com [62.225.105.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 81B46266EB0
 for <alsa-devel@alsa-project.org>; Thu, 15 Feb 2018 11:36:29 +0100 (CET)
In-Reply-To: <s5hd1183jq3.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello Takashi,

> This happens only when the application uses periods=3D1,

It can also happen with 2 periods per buffer e.g. when the user application=
 is too late.
I will try to illustrate the use case with the following time line:

Time line: 0--R1-W1-R2--R3-W2-W3-...

0 buffer is full (2 periods)
R1 JACK daemon reads 1 period (1 period left in the buffer)
W1 User application writes 1 period (2 periods in the buffer)
R2 JACK daemon reads 1 period (1 period left in the buffer)
R3 JACK daemon reads 1 period (buffer empty)
But it is not yet an under run because JACK has not yet read invalid data.
Due to the blocked user application (e.g low scheduling priority) the point=
er() callback was not called before the second read.
In this case the next pointer() call has to result in a delta of 2 periods.
But this is not possible if pointer() is not allowed to return >=3Dbuffer_s=
ize.

W2 User application writes 1 period (1 periods in the buffer)
W3 User application writes 1 period (2 periods in the buffer)
Continue with 0

> It notifies the period elapse via file-descriptor
But this notification will be processed later if the user application is bl=
ocked at the moment (e.g. by higher priority tasks).

Do you also see my problem, now?

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
