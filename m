From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Master Plan on rewinding
Date: Thu, 18 Sep 2014 09:15:42 +0800
Message-ID: <CAN8cciaXvOyEN8U6mG-1OYLOBQ9-9i030smaqbQz2zvqBnnKjQ@mail.gmail.com>
References: <540C76E0.9050808@gmail.com> <54148E72.2050903@gmail.com>
 <CAN8cciYj4fo01XZwJ-NhFQDNv6Ua5mqaAEq1zU7PYxHkJyOQ5A@mail.gmail.com>
 <541584FB.2030208@gmail.com> <s5hiokpw89h.wl-tiwai@suse.de>
 <5416B852.6080406@gmail.com> <s5hd2axw60j.wl-tiwai@suse.de>
 <54171B66.3010705@linux.intel.com> <54171E81.2090302@gmail.com>
 <s5hzje0ah94.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f43.google.com (mail-qa0-f43.google.com
 [209.85.216.43])
 by alsa0.perex.cz (Postfix) with ESMTP id A02CE261600
 for <alsa-devel@alsa-project.org>; Thu, 18 Sep 2014 03:15:43 +0200 (CEST)
Received: by mail-qa0-f43.google.com with SMTP id x12so219065qac.30
 for <alsa-devel@alsa-project.org>; Wed, 17 Sep 2014 18:15:42 -0700 (PDT)
In-Reply-To: <s5hzje0ah94.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, "Alexander E. Patrakov" <patrakov@gmail.com>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

> > >
> > >>> What remains not fully understood for me is the claim that the
> > >>> information already exposed by every driver (in the form of the
minimal
> > >>> period size) is not useful. I understand that two people are against
> > >>> this idea, so it must be bad. But I must understand why. Is it
because
> > >>> the minimum period size reported by some drivers (which ones are
> > >>> suspected, if any?) may be a lie?

Does this mean the granularity of most drivers are only one period since
most of them cannot reporte the dma position in realtime  ?

(e.g. pointer callback of Intel8x0 use a timeout loop to read the last
valid index)

  The safeguard will be two periods

If some HDA have FIFO size of 192 bytes which is more than the minimum
period bytes

Should we limit the start threshold to FIFO threshold or FIFO size ?

Does it need Brust length = 1 for those hda controller to support arbitrary
period size ?

Seem only some hda controller can trigger DMA transfer at 1/3 or 2/3 FIFO
buffer at different power states and report the dma position in pointer
callback

Does snd-oxygen provide this position with granularity which is less than
the minimum period size ?
