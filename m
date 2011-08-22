From: kuldeep ghan <ghankp@gmail.com>
Subject: Re: ALSA underruns for S32_LE format
Date: Mon, 22 Aug 2011 11:51:07 +0530
Message-ID: <CAL5CBv+vndvMub3Psgo=zPUzYPQ1yNjOTf-1pZFZS65VLhRGuw@mail.gmail.com>
References: <CAL5CBvJBrk=euqXgOK=QWP4NC5yYKsm92Y+vC4dJiirgW1o_+A@mail.gmail.com>
	<CABb+yY2SnCwoHANNPiekz0TqqV2L=gzz2mk_6tvC-VYDtmEJtg@mail.gmail.com>
	<CAL5CBvLB8QJdH0m_SqpZRAY6ka279akzKdoUS6naPCEWPYh4cA@mail.gmail.com>
	<CABb+yY2-TxP6K+OkbkM0CgY5uW8tTi1CHH5Cv9vz3PAYLdEBoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 489DD10386D
	for <alsa-devel@alsa-project.org>;
	Mon, 22 Aug 2011 08:21:08 +0200 (CEST)
Received: by wwi18 with SMTP id 18so3509305wwi.20
	for <alsa-devel@alsa-project.org>; Sun, 21 Aug 2011 23:21:08 -0700 (PDT)
In-Reply-To: <CABb+yY2-TxP6K+OkbkM0CgY5uW8tTi1CHH5Cv9vz3PAYLdEBoA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, Aug 20, 2011 at 12:40 AM, Jassi Brar <jassisinghbrar@gmail.com>wrote:

> On Sat, Aug 20, 2011 at 12:03 AM, kuldeep ghan <ghankp@gmail.com> wrote:
> > Hi,
> >  Thanks Jassi, I dont my System is too slow, I have dual core processor,
> > 1.5GHz. no CPU consuming process running on it.
> It sure is not slow. Most probably I can't help anyways.
>
> >  I Shall confirm if it does not support S32_LE.. Is  there any means by
> > which I can confirm the same without
> >  going through Codec Driver??
> Generally, if the following works fine
>  $ speaker-test -Dhw -c 2 -t sine -f 200 -r 48000 -F S32_LE
>
Speaker-test mentioned above results into write error -32. I tried googling
it but did not get the right reason yet.
what does the write error -32. error imply?

*#  speaker-test -Dhw -c 2 -t sine -f 200 -r 48000 -F S32_LE*
*
*
*speaker-test 1.0.23*
*
*
*Playback device is hw*
*Stream parameters are 48000Hz, S32_LE, 2 channels*
*Sine wave rate is 200.0000Hz*
*Rate set to 48000Hz (requested 48000Hz)*
*Buffer size range from 1024 to 6144*
*Period size range from 512 to 3072*
*Using max buffer size 6144*
*Periods = 4*
*was set period_size = 3072*
*was set buffer_size = 6144*
* 0 - Front Left*
*Write error: -32,Broken pipe*
*Write error: -32,Broken pipe*
*Write error: -32,Broken pipe*
*Write error: -32,Broken pipe*


> >> > *underrun!!! (at least 0.055 ms long)*
> >> > *underrun!!! (at least 0.043 ms long)*
> >> > *underrun!!! (at least 0.040 ms long)*
> >> > *underrun!!! (at least 0.043 ms long)*
> >> > *underrun!!! (at least 0.043 ms long)*
> >> > *underrun!!! (at least 0.043 ms long)*
> >> > *underrun!!! (at least 0.040 ms long)*
> Btw, these uniform skips seem interesting. Some expert might dissect
> better.
>
