From: Caleb Crome <caleb@crome.org>
Subject: Re: Imx6 i2s master driver without i2c
Date: Fri, 6 May 2016 08:38:03 -0700
Message-ID: <CAG5mAdzJyTdsBTnz8FZ8Ay278j1bYJHHqkOTGY+_Ck9sSPhQoQ@mail.gmail.com>
References: <CABPh3UNhKMGUoiDvHn9paXVNvtpwzbzkbCwBhtSCm72jxkh3CA@mail.gmail.com>
 <CABPh3UMMvVKvHL0g52NqP-E8dpxoZHfwgR_t1WY08OFMSYt9tg@mail.gmail.com>
 <CABPh3UMJ4gOtNN3FJg0fF7Mm+Lpw0=jXGk_+ejsHaGLG9UvWAQ@mail.gmail.com>
 <CABPh3UNi79pMZPgJBisaq9Qo847MV-6riCEQ=Akt_RoLdqeVpw@mail.gmail.com>
 <CABPh3UPLR20WbV0NuYLA4RZ7XB-0+RdFrB-SpDLa0T+wOxqQ+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f44.google.com (mail-oi0-f44.google.com
 [209.85.218.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 428F526154C
 for <alsa-devel@alsa-project.org>; Fri,  6 May 2016 17:39:28 +0200 (CEST)
Received: by mail-oi0-f44.google.com with SMTP id x201so143143705oif.3
 for <alsa-devel@alsa-project.org>; Fri, 06 May 2016 08:39:28 -0700 (PDT)
In-Reply-To: <CABPh3UPLR20WbV0NuYLA4RZ7XB-0+RdFrB-SpDLa0T+wOxqQ+g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: nick83ola <nick83ola@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi there,
   Arnaud had a neat patch here that lets you set up a dummy sound
card from the DTS.

http://mailman.alsa-project.org/pipermail/alsa-devel/2015-November/100896.html

With that patch, you can set up your DTS to simply start streaming, no
codec or anything required, which should work for a codec with no I2C.


Hope that helps,
  -Caleb


On Thu, May 5, 2016 at 12:56 PM, nick83ola <nick83ola@gmail.com> wrote:
> Hello Alsa dev!
>
> Anyone have an example of an i2s only driver for imx6 solo? I need a driver
> without i2c....
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
