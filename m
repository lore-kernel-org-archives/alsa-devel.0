Return-Path: <SRS0=HcWj=ED=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D8FC4363A
	for <alsa-devel@archiver.kernel.org>; Wed, 28 Oct 2020 08:15:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51D6122447
	for <alsa-devel@archiver.kernel.org>; Wed, 28 Oct 2020 08:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="YSe632Nu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51D6122447
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 99E5D16BB;
	Wed, 28 Oct 2020 09:14:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 99E5D16BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603872908;
	bh=VwXQIPyhnJqiuGO/bb6tq2616xG+K8NJ1F/wXTWfVVg=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YSe632NuacGh0JFeGtIHCDM9jESVvExgj0s6G+apT4Rr5zJx5PBbnT1W1WBxHDF11
	 okRZ7/X40ZpW4QvxFDDlqhkNXooGYeI1C7tUZbIxbF2DUORjoGNxiO44lsfuutqtpP
	 aLGK7J0MPjWE5YYHyYYp7poI3fr90zWjj38gwxTE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F17C5F80558;
	Wed, 28 Oct 2020 09:07:16 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4EDE6F8020D; Tue, 27 Oct 2020 18:08:19 +0100 (CET)
Received: from smtprelay.hostedemail.com (smtprelay0077.hostedemail.com
 [216.40.44.77])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 15E02F8019D
 for <alsa-devel@alsa-project.org>; Tue, 27 Oct 2020 18:08:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 15E02F8019D
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay08.hostedemail.com (Postfix) with ESMTP id 45489182CED2A;
 Tue, 27 Oct 2020 17:08:10 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: rake71_590ddfb2727d
X-Filterd-Recvd-Size: 4916
Received: from XPS-9350.home (unknown [47.151.133.149])
 (Authenticated sender: joe@perches.com)
 by omf05.hostedemail.com (Postfix) with ESMTPA;
 Tue, 27 Oct 2020 17:08:04 +0000 (UTC)
Message-ID: <2767969b94fd66db1fb0fc13b5783ae65b7deb2f.camel@perches.com>
Subject: Re: [PATCH 3/8] vhost: vringh: use krealloc_array()
From: Joe Perches <joe@perches.com>
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Tue, 27 Oct 2020 10:08:02 -0700
In-Reply-To: <CAMpxmJU0C84DjPmqmWvPgv0zwgGLhkpKLRDuKkZHAa=wi+LvBA@mail.gmail.com>
References: <20201027121725.24660-1-brgl@bgdev.pl>
 <20201027121725.24660-4-brgl@bgdev.pl>
 <20201027112607-mutt-send-email-mst@kernel.org>
 <685d850347a1191bba8ba7766fc409b140d18f03.camel@perches.com>
 <CAMpxmJU0C84DjPmqmWvPgv0zwgGLhkpKLRDuKkZHAa=wi+LvBA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 28 Oct 2020 09:06:30 +0100
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, David Airlie <airlied@linux.ie>,
 Gustavo Padovan <gustavo@padovan.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 linux-drm <dri-devel@lists.freedesktop.org>, linux-mm@kvack.org,
 Christoph Lameter <cl@linux.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bartosz Golaszewski <brgl@bgdev.pl>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 David Rientjes <rientjes@google.com>,
 virtualization@lists.linux-foundation.org, Jason Wang <jasowang@redhat.com>,
 linux-media <linux-media@vger.kernel.org>, Robert Richter <rric@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, linaro-mm-sig@lists.linaro.org,
 linux-gpio <linux-gpio@vger.kernel.org>, Borislav Petkov <bp@alien8.de>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-edac@vger.kernel.org,
 Tony Luck <tony.luck@intel.com>, netdev <netdev@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.com>, LKML <linux-kernel@vger.kernel.org>,
 Pekka Enberg <penberg@kernel.org>, James Morse <james.morse@arm.com>,
 Daniel Vetter <daniel@ffwll.ch>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Tue, 2020-10-27 at 17:58 +0100, Bartosz Golaszewski wrote:
> On Tue, Oct 27, 2020 at 5:50 PM Joe Perches <joe@perches.com> wrote:
> > 
> > On Tue, 2020-10-27 at 11:28 -0400, Michael S. Tsirkin wrote:
> > > On Tue, Oct 27, 2020 at 01:17:20PM +0100, Bartosz Golaszewski wrote:
> > > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > > 
> > > > Use the helper that checks for overflows internally instead of manually
> > > > calculating the size of the new array.
> > > > 
> > > > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > 
> > > No problem with the patch, it does introduce some symmetry in the code.
> > 
> > Perhaps more symmetry by using kmemdup
> > ---
> >  drivers/vhost/vringh.c | 23 ++++++++++-------------
> >  1 file changed, 10 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> > index 8bd8b403f087..99222a3651cd 100644
> > --- a/drivers/vhost/vringh.c
> > +++ b/drivers/vhost/vringh.c
> > @@ -191,26 +191,23 @@ static int move_to_indirect(const struct vringh *vrh,
> >  static int resize_iovec(struct vringh_kiov *iov, gfp_t gfp)
> >  {
> >         struct kvec *new;
> > -       unsigned int flag, new_num = (iov->max_num & ~VRINGH_IOV_ALLOCATED) * 2;
> > +       size_t new_num = (iov->max_num & ~VRINGH_IOV_ALLOCATED) * 2;
> > +       size_t size;
> > 
> >         if (new_num < 8)
> >                 new_num = 8;
> > 
> > -       flag = (iov->max_num & VRINGH_IOV_ALLOCATED);
> > -       if (flag)
> > -               new = krealloc(iov->iov, new_num * sizeof(struct iovec), gfp);
> > -       else {
> > -               new = kmalloc_array(new_num, sizeof(struct iovec), gfp);
> > -               if (new) {
> > -                       memcpy(new, iov->iov,
> > -                              iov->max_num * sizeof(struct iovec));
> > -                       flag = VRINGH_IOV_ALLOCATED;
> > -               }
> > -       }
> > +       if (unlikely(check_mul_overflow(new_num, sizeof(struct iovec), &size)))
> > +               return -ENOMEM;
> > +
> 
> The whole point of using helpers such as kmalloc_array() is not doing
> these checks manually.

Tradeoffs for in readability for overflow and not mistyping or doing
the multiplication of iov->max_num * sizeof(struct iovec) twice.

Just fyi:

the realloc doesn't do a multiplication overflow test as written so the
suggestion is slightly more resistant to defect.

   

