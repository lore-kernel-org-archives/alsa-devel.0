From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: mackie onyx 400F works
Date: Thu, 25 Sep 2014 06:25:53 +0900
Message-ID: <542336E1.6020307@sakamocchi.jp>
References: <DUB120-W2040183D678A7C95B7169BA9B30@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 73AA4264F1D
 for <alsa-devel@alsa-project.org>; Wed, 24 Sep 2014 23:26:00 +0200 (CEST)
In-Reply-To: <DUB120-W2040183D678A7C95B7169BA9B30@phx.gbl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?windows-1252?Q?Jos=E9_Razafindranaly?= <kingjob@msn.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "ffado-devel@lists.sf.net" <ffado-devel@lists.sf.net>
List-Id: alsa-devel@alsa-project.org

Hi,
(C.C.ed to alsa-devel and ffado-devel, fot information to the others)

On 23 Sep 2014 00:42, Jos=E9 Razafindranaly wrote:
> Hi,
> =

> I own a mackie Onyx 400F that works very well with your driver (and which=
 was not supported by ffado).
> So I'm very happy with it now: thank you so much!
> It works for playing and recording sound.
> My computer runs linux Mint Petra, with a 3.10.0-20 lowlatency kernel
> =

> Few monthes ago, when I first installed your driver I had some minor issu=
es:
> =

> - with the alsa-loop-jack bridge of "cadence" (weird sound after several =
minutes of video playback or gaming for example), but It may not be your dr=
iver's fault. It worked again after stopping and restarting jack.
> - some sampling frequencies didn't work with the jack server.
> =

> I recently reinstalled the driver, and these issues seem fixed.
> I still have to do further recording tests with my new setup.
> I'm ready to do more state of the art bug reporting if you want me to. Ju=
st keep in mind that I'm quite a rookie regarding command lines.
> =

> =

> In conclusion, I'm really impressed by your work and I think you can writ=
e that the onyx 400F is reported to work with your driver.
> =

> Kind regards.

Thanks for your report. It's pretty nice to hear that your 400F works
with my drivers.

Here I have a question. Have you evet tried with FFADO to drive your
400F? If so and FFADO doesn't drive, I want to clear the reason. I would
like you to get teminal dumps of "ffado-debug ffado-test Discover -v 8"
and send it to me. I reccomend to redirect stdout to file by using ">",
like:
 $ ffado-debug ffado-test Discover -v 8 > dump_file_name


Regards

Takashi Sakamoto
o-takashi@sakamocchi.jp
