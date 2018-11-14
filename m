From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [RFC PATCH] cplay: Always write frag *
	fragment_size
Date: Wed, 14 Nov 2018 08:59:27 +0200
Message-ID: <CAEnQRZCj=jRRr1-r_nGpToigLpR4UASBwXuU32P9tq4K8M0P7Q@mail.gmail.com>
References: <1541427790-27876-1-git-send-email-daniel.baluta@nxp.com>
 <20181113145221.GC3060@vkoul-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com
 [209.85.208.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F786267A61
 for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2018 07:59:40 +0100 (CET)
Received: by mail-ed1-f66.google.com with SMTP id b14so10154741edt.6
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2018 22:59:40 -0800 (PST)
In-Reply-To: <20181113145221.GC3060@vkoul-mobl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: vkoul@kernel.org
Cc: "S.j. Wang" <shengjiu.wang@nxp.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Daniel Baluta <daniel.baluta@nxp.com>, vinod.koul@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Hi Vinod,

Thanks a lot for having a look at this. Please check my comments inline:

<snip>
> > -     size = config.fragment_size;
> > -     buffer = malloc(size * config.fragments);
> > +     size = config.fragments * config.fragment_size;
> > +     buffer = malloc(size);
>
> net result of this change is no change. Leaving alone the variable names
> from this discussion, we allocate memory for size of config.fragments * config.fragment_size

Yes, you are right on this. There is no change here. But notice that we change
the value of size to config.fragments * config.fragment_size;

Now, please take a look at the inner loop at:

https://github.com/alsa-project/tinycompress/blob/master/src/utils/cplay.c#L382

num_read = fread(buffer, 1, size, file);

So, now instead of reading config.fragment_size we read
config.fragments * config.fragment_size
thus we fully utilize the buffer.

I'm pretty sure this is the correct fix. See also crecord fix from Charles:

http://git.alsa-project.org/?p=tinycompress.git;a=commit;h=e8e36567438c
16a5121943205a0cd8c63924d0d8

thanks,
daniel.
