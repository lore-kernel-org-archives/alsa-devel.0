From: "Adrian McMenamin" <lkmladrian@gmail.com>
Subject: Re: can not access the alsa driver
Date: Sat, 5 Jan 2008 14:47:59 +0000
Message-ID: <8b67d60801050647i4e3ba87fp82e635114272c83c@mail.gmail.com>
References: <48a1cba90801050642s47db1bcbj6c6624536eda5949@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.182])
	by alsa0.perex.cz (Postfix) with ESMTP id 9345424606
	for <alsa-devel@alsa-project.org>; Sat,  5 Jan 2008 15:48:01 +0100 (CET)
Received: by py-out-1112.google.com with SMTP id w49so3148922pyg.36
	for <alsa-devel@alsa-project.org>; Sat, 05 Jan 2008 06:48:00 -0800 (PST)
In-Reply-To: <48a1cba90801050642s47db1bcbj6c6624536eda5949@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ning Zhang <ning.zhang06@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 05/01/2008, Ning Zhang <ning.zhang06@gmail.com> wrote:
> Dear all,
> I wrote an alsa device driver for my arm_based platform. Then I cross
> compiled the alsa-lib-1.0.15, and build an application (static) with the
> lib.
> I build the driver in the kernel, so after the kernel booted, I can get
> these information:
>
I am having much the same problem!

You can test that the driver works by loading the oss emulation eg
(one your module is loaded)

modprobe snd-pcm-oss
cat /dev/urandom > /dev/dsp

You should then get continuous white noise.

I'd be very interested in the answer to your other questions though -
this aspect of writing and installing a driver doesn't appear to be
(well) documented anywhere.
