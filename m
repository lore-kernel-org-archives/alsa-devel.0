From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: Master Plan on rewinding
Date: Sun, 21 Sep 2014 15:22:42 +0600
Message-ID: <541E98E2.3090205@gmail.com>
References: <540C76E0.9050808@gmail.com>	<54148E72.2050903@gmail.com>	<CAN8cciYj4fo01XZwJ-NhFQDNv6Ua5mqaAEq1zU7PYxHkJyOQ5A@mail.gmail.com>	<541584FB.2030208@gmail.com>	<s5hiokpw89h.wl-tiwai@suse.de>	<5416B852.6080406@gmail.com>	<s5hd2axw60j.wl-tiwai@suse.de>	<54171B66.3010705@linux.intel.com>	<54171E81.2090302@gmail.com>	<s5hzje0ah94.wl-tiwai@suse.de>
 <CAN8cciaXvOyEN8U6mG-1OYLOBQ9-9i030smaqbQz2zvqBnnKjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f53.google.com (mail-la0-f53.google.com
 [209.85.215.53])
 by alsa0.perex.cz (Postfix) with ESMTP id BB448261A28
 for <alsa-devel@alsa-project.org>; Sun, 21 Sep 2014 11:22:45 +0200 (CEST)
Received: by mail-la0-f53.google.com with SMTP id ge10so5281233lab.12
 for <alsa-devel@alsa-project.org>; Sun, 21 Sep 2014 02:22:45 -0700 (PDT)
In-Reply-To: <CAN8cciaXvOyEN8U6mG-1OYLOBQ9-9i030smaqbQz2zvqBnnKjQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>, Takashi Iwai <tiwai@suse.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, David Henningsson <david.henningsson@canonical.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

18.09.2014 07:15, Raymond Yau wrote:
>
>  > > >
>  > > >>> What remains not fully understood for me is the claim that the
>  > > >>> information already exposed by every driver (in the form of the
> minimal
>  > > >>> period size) is not useful. I understand that two people are
> against
>  > > >>> this idea, so it must be bad. But I must understand why. Is it
> because
>  > > >>> the minimum period size reported by some drivers (which ones are
>  > > >>> suspected, if any?) may be a lie?
>
> Does this mean the granularity of most drivers are only one period since
> most of them cannot reporte the dma position in realtime  ?

I guess you are right.

>
> (e.g. pointer callback of Intel8x0 use a timeout loop to read the last
> valid index)
>
>    The safeguard will be two periods

Here I don't see how that can be right. Even if the position is updated 
at each period interrupt, we always know which period is currently 
playing. So the theoretical minimum safeguard is exactly one period. Add 
1 ms on top if you want to account for scheduler glitches.

>
> If some HDA have FIFO size of 192 bytes which is more than the minimum
> period bytes
>
> Should we limit the start threshold to FIFO threshold or FIFO size ?

I think that in this case it is a bug to report such small minimum 
period size.

> Does it need Brust length = 1 for those hda controller to support
> arbitrary period size ?
>
> Seem only some hda controller can trigger DMA transfer at 1/3 or 2/3
> FIFO buffer at different power states and report the dma position in
> pointer callback

I am not a specialist in HDA hardware.

> Does snd-oxygen provide this position with granularity which is less
> than the minimum period size ?

I have a friend with a Xonar card, will ask him to perform a test for 
you when he appears online.

-- 
Alexander E. Patrakov
