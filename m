From: "Laurent ." <sid6582@msn.com>
Subject: Help with multichannel High Speed USB audio device
Date: Thu, 23 Jul 2009 17:54:36 -0700
Message-ID: <SNT121-W363BA2CA76A9BB36ABA8A6B2190@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from snt0-omc3-s34.snt0.hotmail.com (snt0-omc3-s34.snt0.hotmail.com
	[65.55.90.173]) by alsa0.perex.cz (Postfix) with ESMTP id C2827103A41
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Jul 2009 02:54:38 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org








Dear list,

I made an embedded device that has a CODEC with 6 inputs connected to an AR=
M9
micro-controller that has an integrated high-speed USB controller.
Now, I need to write the USB code on that micro-controller so that i can ca=
pture those
channels in real-time at 24bits / 48 KHz with low latency (ie. sub 10ms), o=
n a computer.

I only need my device to work with Linux, and if possible, I would like to =
avoid writing a device
driver on the Linux-side.

Is there already such a USB audio driver available that I could nearly use =
"as is" and to which
i would conform ?

Would you have some general guideline on how to write the high-speed USB de=
vice code ?

Would you have any comment on the following :

For simplicity, my device is going to be the "clock master" of the system s=
ince it is already has
the exact clock that drives the CODEC.
I will maintain a circular buffer of samples (well, frames of samples) comi=
ng from the CODEC.
Each time a new frame arrives, i put the samples in the buffer and increase=
 a counter so
i know how many frames of samples I have in the buffer, ready to be sent.
Each USB micro-frame (125ms/8000Hz), I send all the bytes corresponding to =
the frames that
I have in the circular buffer.
In average, 6*3*48000/8000 =3D 108, but I presume that could jitter slightl=
y, which should not
be a problem at all.

Thanks in advance,
Laurent

_________________________________________________________________
Windows Live=99 Hotmail=AE: Celebrate the moment with your favorite sports =
pics. Check it out.
http://www.windowslive.com/Online/Hotmail/Campaign/QuickAdd?ocid=3DTXT_TAGL=
M_WL_QA_HM_sports_photos_072009&cat=3Dsports
