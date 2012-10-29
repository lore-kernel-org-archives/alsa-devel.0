From: Paolo Doz <paolo.doz@gmail.com>
Subject: Re: [PATCH 1/4] ASoC: ak5702: add support for ak5702
 -- 4ch ADC
Date: Mon, 29 Oct 2012 18:49:18 +0100
Message-ID: <CAFsPKCUXU6OYWQNGy8VOuG-Z=tB81CVbfQtbhq35N2gf4PkX2w@mail.gmail.com>
References: <CAFsPKCXpZ43SBXyPTJnXR9mUgXyLK0T=JBiQrkBWGzSJOuLptA@mail.gmail.com>
 <20121029160450.GB4511@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f179.google.com (mail-ie0-f179.google.com
 [209.85.223.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 46C8C265D28
 for <alsa-devel@alsa-project.org>; Mon, 29 Oct 2012 18:49:20 +0100 (CET)
Received: by mail-ie0-f179.google.com with SMTP id c10so6639108ieb.38
 for <alsa-devel@alsa-project.org>; Mon, 29 Oct 2012 10:49:19 -0700 (PDT)
In-Reply-To: <20121029160450.GB4511@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

Hi,
@Lars-Peter: thanks for the code review
@Mark: You're right. The original source code (that I found on the web)
was for kernel 2.6.35, and then I adapted it to work with kernel 3.2 series.
Can you suggest me a "state of the art" codec driver where can
I have a look at best practice?
In the end the codec should work with alsa infrastructure available in
kernel 3.2 so I can test it's correctness directly on my hw.

Thanks in advance,
Paolo

On Mon, Oct 29, 2012 at 5:04 PM, Mark Brown <
broonie@opensource.wolfsonmicro.com> wrote:

> On Mon, Oct 29, 2012 at 09:43:57AM +0100, Paolo Doz wrote:
> > This codec driver adds support for Asahi Kasei AK5702.
> >
> > Signed-off-by: Paolo Doz <paolo.doz@gmail.com>
>
> Lars-Peter already went through most of this so I'll not follow up in
> detail.  One overall comment which Lars-Peter didn't make but which it's
> worth bearing in mind was that your driver looks like it was written
> several years ago, it'd probably help a lot if you were to look at more
> modern drivers and make sure what you're doing resembles them
> stylistically.
>
