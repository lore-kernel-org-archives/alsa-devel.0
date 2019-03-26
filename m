From: Phil Burk <philburk@google.com>
Subject: Re: [PATCH 0/2 v4] ALSA: pcm: anonymous dup
	implementation
Date: Tue, 26 Mar 2019 07:27:37 -0700
Message-ID: <CACL=Q7we61BwO81W7tQFvb9ohkBZkk34DSXL2B-Ky2B6zfWk1A@mail.gmail.com>
References: <20190204093910.23878-1-perex@perex.cz>
 <20190326140928.GC10898@sirena.org.uk>
 <s5hva0567vs.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it1-x142.google.com (mail-it1-x142.google.com
 [IPv6:2607:f8b0:4864:20::142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1131FF801D8
 for <alsa-devel@alsa-project.org>; Tue, 26 Mar 2019 15:27:50 +0100 (CET)
Received: by mail-it1-x142.google.com with SMTP id u65so10887752itc.2
 for <alsa-devel@alsa-project.org>; Tue, 26 Mar 2019 07:27:50 -0700 (PDT)
In-Reply-To: <s5hva0567vs.wl-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>, Baolin Wang <baolin.wang@linaro.org>, Zach Riggle <riggle@google.com>, Mark Brown <broonie@kernel.org>, Leo Yan <leo.yan@linaro.org>
List-Id: alsa-devel@alsa-project.org

Hello,

Thanks for keeping this moving forward.

Any suggestions for testing this? We can try to test it here in Android. It
may be tricky because your patches may conflict with some proprietary
Qualcomm changes in the kernel we are currently using.

Can I get a summary list of the patches required for kernel and tinyalsa?

Thanks,
Phil Burk


On Tue, Mar 26, 2019 at 7:13 AM Takashi Iwai <tiwai@suse.de> wrote:

> On Tue, 26 Mar 2019 15:09:28 +0100,
> Mark Brown wrote:
> >
> > On Mon, Feb 04, 2019 at 10:39:08AM +0100, Jaroslav Kysela wrote:
> > > This patchset contains the anonymous dup implementation with
> permissions
> > > checking for the ALSA's PCM interface in kernel to enable the
> restricted
> > > DMA sound buffer sharing for the restricted tasks.
> >
> > Is there any news on merging this during the current development cycle,
> > or anything else needed to move this forwards?
>
> I've seen no reaction whether the patch really tested, worked or
> helped in the real scenario...
>
>
> Takashi
>
