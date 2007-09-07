From: Krzysztof Helt <krzysztof.h1@gmail.com>
Subject: Re: full duplex AD1848 (was SC-6000 driver)
Date: Fri, 7 Sep 2007 10:34:47 +0200
Message-ID: <20070907103447.226b5ae3.krzysztof.h1@gmail.com>
References: <46dfa2e7d6be4@wp.pl> <46DFD29A.6020601@gmail.com>
	<46DFE268.7080404@gmail.com> <46e008be72b6c@wp.pl>
	<46E01A2F.2080106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.187])
	by alsa0.perex.cz (Postfix) with ESMTP id E33001037FB
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Sep 2007 10:28:19 +0200 (CEST)
Received: by nf-out-0910.google.com with SMTP id d21so442861nfb
	for <alsa-devel@alsa-project.org>; Fri, 07 Sep 2007 01:28:19 -0700 (PDT)
In-Reply-To: <46E01A2F.2080106@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 06 Sep 2007 17:18:07 +0200
Rene Herman <rene.herman@gmail.com> wrote:

> On 09/06/2007 04:03 PM, Krzysztof Helt wrote:
> =

> > Dnia 6-09-2007 o godz. 13:20 Rene Herman napisa=B3(a):
> =

> >> Sorry, incorrect -- the cs4231 is full duplex. It's only the cs4248
> >> (ad1848) which is not. Need to figure out how to do full duplex on a =

> >> sound galaxy; old driver didn't do so.
> >>

According to a datasheet, the AD1848K (which was a popular version of AD184=
8)
is full-duplex (can work in single-dma mode or with two dma channels).

The AD1848 in my SC-6000 is not the K version (at least it is not marked on
the chip) but I saw a photo on the net with SC-6000 and AD1848K (it had no
YMF-262 chip but a different one).

I am looking for the AD1848 datasheet  for the pre-K version (or list of
differences between K and earlier versions).

Also, I would like to know how you put your SG card into full-duplex mode.

It seems that hardware of AD1848/CS4231 was not used to its full potential
(SB compatibility was more important).

Regards,
Krzysztof
