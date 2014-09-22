From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Master Plan on rewinding
Date: Mon, 22 Sep 2014 11:27:17 +0800
Message-ID: <CAN8cciYHG9t8mNYUa9Zt4rbRqb7MCk2MxyZcwi0tAVJZYzbfQQ@mail.gmail.com>
References: <540C76E0.9050808@gmail.com> <54148E72.2050903@gmail.com>
 <CAN8cciYj4fo01XZwJ-NhFQDNv6Ua5mqaAEq1zU7PYxHkJyOQ5A@mail.gmail.com>
 <541584FB.2030208@gmail.com> <s5hiokpw89h.wl-tiwai@suse.de>
 <5416B852.6080406@gmail.com> <s5hd2axw60j.wl-tiwai@suse.de>
 <54171B66.3010705@linux.intel.com> <54171E81.2090302@gmail.com>
 <s5hzje0ah94.wl-tiwai@suse.de>
 <CAN8cciaXvOyEN8U6mG-1OYLOBQ9-9i030smaqbQz2zvqBnnKjQ@mail.gmail.com>
 <541EA036.5010707@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f49.google.com (mail-qg0-f49.google.com
 [209.85.192.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 8BFDC265005
 for <alsa-devel@alsa-project.org>; Mon, 22 Sep 2014 05:27:18 +0200 (CEST)
Received: by mail-qg0-f49.google.com with SMTP id q107so2302178qgd.36
 for <alsa-devel@alsa-project.org>; Sun, 21 Sep 2014 20:27:17 -0700 (PDT)
In-Reply-To: <541EA036.5010707@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, "Alexander E. Patrakov" <patrakov@gmail.com>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

> > Does snd-oxygen provide this position with granularity which is less
than
> > the minimum period size ?
>
> Yes.  Its DMA controller uses a burst size of 32 bytes.  The pointer
registers
> are documented as reporting the position with 4-byte accuracy, but there
were
> problems when the period/buffer sizes were not aligned to 32 bytes.  I've
set
> the minimum period size to 64 bytes, just to be safe.
>
>

The brust size is usually added to the constriants but the application
cannot deduce this value

err = snd_pcm_hw_constraint_step(runtime, 0,
SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 32);

For those audio controllers have FIFO buffer, the application must keep the
FIFO buffer full at any time for glitch free.

Someone may argue that keeping at least one frame above FIFO threshold is
just enough

http://mailman.alsa-project.org/pipermail/alsa-devel/2014-September/081509.html

I don't understand why the minimum buffer size can be less than FIFO size
