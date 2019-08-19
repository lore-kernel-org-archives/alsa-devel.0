From: Paul Pawlowski <mrarmdev@gmail.com>
Subject: Re: What to do when a device clears the buffer in the
 start trigger?
Date: Mon, 19 Aug 2019 18:39:37 +0200
Message-ID: <CAKSqxP95DEsO_qdffUmA6_yn1FGwgkeYmo8Z65k0v9kheOtjqg@mail.gmail.com>
References: <CAKSqxP_po3DRQvhqb-VrwD_NitzSRa0a+28NNA8SajUaZN+qbQ@mail.gmail.com>
 <s5hwofqmui6.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 879A6F800BF
 for <alsa-devel@alsa-project.org>; Mon, 19 Aug 2019 18:39:53 +0200 (CEST)
Received: by mail-ed1-x52c.google.com with SMTP id a21so2274517edt.11
 for <alsa-devel@alsa-project.org>; Mon, 19 Aug 2019 09:39:52 -0700 (PDT)
In-Reply-To: <s5hwofqmui6.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,
I have implemented that today, and it seems that it takes 30ms to
memcpy() the data from the buffer to the host memory. Other than this
is works well. Source available at:
https://github.com/MCMrARM/mbp2018-bridge-drv/blob/65a09949c2d7343a073d92e4d4c24c5effa420c5/audio/pcm.c#L148

Do you think this is acceptable? Is there a better way to handle this?

Thank you,
Paul Pawlowski


On Tue, Aug 6, 2019 at 12:57 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Wed, 31 Jul 2019 19:48:13 +0200,
> Paul Pawlowski wrote:
> >
> > Hello,
> > I have a device which clears the DMA buffer when I command it to start the
> > playback. How can this be workarounded?
>
> So it clears the DMA buffer at start, then you need to put the data on
> the DMA buffer again on the running stream?  What a weird chip.
>
> > I found the SNDRV_PCM_INFO_DOUBLE flag, but it doesn't seem that it changes
> > alsa/alsa-lib behaviour. I wasn't able to find any drivers which shared
> > this quirk.
> > I'd like to avoid double buffering if possible, as once the stream is
> > actually started it's not required.
>
> The PCM_INFO_DOUBLE flag has no effect for anything like that.  It's
> merely a information bit exposed to the user-space as a hint.
>
> In such a case, you need to implement some ugly workaround in the
> driver side.  Since the double-buffer is needed only at start, you can
> save the whole content (up to appl_ptr) and write back after starting
> the stream.
>
>
> Takashi
