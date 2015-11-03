From: Caleb Crome <caleb@crome.org>
Subject: Re: fsl_ssi.c: Roberto's problem: ssi hangs after some
 number of samples
Date: Mon, 2 Nov 2015 16:56:07 -0800
Message-ID: <CAG5mAdzB52323JCvrOPj1Dr0zg4-SJM7gw-qmtqp1QZAEr5+yg@mail.gmail.com>
References: <CAG5mAdxYEL22o=9AKQefb-vkf8KATEojH0qgPWzfAim+5fm5vQ@mail.gmail.com>
 <5634870A.4080206@tekno-soft.it> <5637A288.4080807@tekno-soft.it>
 <5637A56C.5030103@tekno-soft.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f42.google.com (mail-wm0-f42.google.com [74.125.82.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 17FB5264F19
 for <alsa-devel@alsa-project.org>; Tue,  3 Nov 2015 01:56:27 +0100 (CET)
Received: by wmeg8 with SMTP id g8so2889278wme.1
 for <alsa-devel@alsa-project.org>; Mon, 02 Nov 2015 16:56:26 -0800 (PST)
In-Reply-To: <5637A56C.5030103@tekno-soft.it>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Roberto Fichera <kernel@tekno-soft.it>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Shengjiu Wang <shengjiu.wang@freescale.com>, Nicolin Chen <nicoleotsuka@gmail.com>, "arnaud.mouiche@invoxia.com" <arnaud.mouiche@invoxia.com>, Markus Pargmann <mpa@pengutronix.de>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 2, 2015 at 10:03 AM, Roberto Fichera <kernel@tekno-soft.it> wrote:
> On 11/02/2015 06:51 PM, Roberto Fichera wrote:
>>>> >> Overall, I don't see an obvious defect from you SSI side, but you
>>>> >> may also try to toggle TDMAE and RDMAE at the point that callback
>>>> >> stops -- re-raise the DMA requests by disabling and enabling TDMAE
>>>> >> and RDMAE again and see if it works. I think either something did
>>>> >> intervene register controls of SDMA or SSI,
>>> > I will try this one.
>> I will go over this tomorrow morning.
>>
>
> I've tried it just now but doesn't work at all! I'm getting only 2 sdma transfers.

Heh, now I'm getting perhaps a similar issue -- transfers just stop
for no good reason.

I can use aplay all day long, and the transfers work great.  Even
arecord + aplay together seem to work fine.

However, when I use my portaudio based ramp checker, it runs from
between 1 frame and several thousand, then the callbacks stop.  I
don't know if this is a portaudio problem or an alsa problem -- i
don't think I've seen the issue outside portaudio.

Jackd seems to run okay too (I'm running an overnight full duplex test now).

roberto, what user space library are you using?  Alsa directly, or
portaudio, or something else? it looks like your data rate is quite
manageable, right?  8kHz, 8 slots, 8 bits?  For me, it's a little
better at 16kHz than 48kHz, but still just quits working after a
while.

What's your experience of play vs. record, vs. full duplex?


-Caleb
