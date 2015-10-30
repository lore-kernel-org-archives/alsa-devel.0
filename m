From: Caleb Crome <caleb@crome.org>
Subject: Re: fsl_ssi.c: Getting channel slips with fsl_ssi.c in
 TDM (network) mode.
Date: Fri, 30 Oct 2015 15:35:17 -0700
Message-ID: <CAG5mAdxNPKZw1_9HSKA0HrgzpZKOhq8dy2TZi095M9AibdcNCQ@mail.gmail.com>
References: <20151027201101.GA9527@Asurada-CZ80>
 <CAG5mAdz=TKSmXBOqKfSj0FYfk3c6syBa87OazyGRRF0NU4snXA@mail.gmail.com>
 <20151029045350.GA3374@Asurada-CZ80>
 <CAG5mAdwQd3ep7ZSNHDEni6caKeFPyvXhM0g=BjqPFA_gDSU1DQ@mail.gmail.com>
 <20151029171936.GA3492@Asurada-CZ80>
 <CAG5mAdzci2hPUBzFo+k3+CorfzQZD9_knQ2TXw1db1KoBL5Eyw@mail.gmail.com>
 <20151029192816.GA43706@Asurada-CZ80>
 <CAG5mAdzJ2_MizAq2ACXwnA=wfO=xujGbUdB2OvcDi=7fHQfyBQ@mail.gmail.com>
 <20151029224713.GA44369@Asurada-CZ80>
 <CAG5mAdwnjLdxNNgC3go_NDERUSDxem9ZQFigyF5yaEWuXV2r4g@mail.gmail.com>
 <20151030012934.GA5456@Asurada-GSX>
 <CAG5mAdwUKwzGvpO3ckKZWfE+oKXHK7umT5Z3Ru3Oyq8AD7gNMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f51.google.com (mail-wm0-f51.google.com [74.125.82.51])
 by alsa0.perex.cz (Postfix) with ESMTP id F1AB4260449
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2015 23:35:37 +0100 (CET)
Received: by wmff134 with SMTP id f134so21624116wmf.1
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2015 15:35:37 -0700 (PDT)
In-Reply-To: <CAG5mAdwUKwzGvpO3ckKZWfE+oKXHK7umT5Z3Ru3Oyq8AD7gNMg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Markus Pargmann <mpa@pengutronix.de>, "arnaud.mouiche@invoxia.com" <arnaud.mouiche@invoxia.com>, Roberto Fichera <kernel@tekno-soft.it>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 30, 2015 at 3:04 PM, Caleb Crome <caleb@crome.org> wrote:
> On Thu, Oct 29, 2015 at 6:29 PM, Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>> On Thu, Oct 29, 2015 at 04:33:26PM -0700, Caleb Crome wrote:
>>
>> Waiting for TFCNT0 sounds reasonable to me as long as the code is
>> well commented.
>
> Okay, so I tried out your patch and it has 2 separate issues:  the
> first related to missing samples (even when I enabled the SSIEN), and
> the second relating to the dual fifo.
> So, first the missing samples.
>
>
> **********************
> ** Problem 2 *******
> **********************
> When the dual fifo mode is enabled, the data comes in the following order:
> 0000,1000,2000,3000,4000,5000,6000,7000,8000,9000,a000,b000,c000,d000,e000,f000
> 0001,1001,2001,3001,4001,5001,6001,7001,8001,9001,a001,b001,c001,d001,e001,1002
> 0002,3002,2002,5002,4002,7002,6002,9002,8002,b002,a002,d002,c002,f002,e002,1003
> 0003,3003,2003,5003,4003,7003,6003,9003,8003,b003,a003,d003,c003,f003,e003,1004
>
> Strange, right?  Frame 0 is perfect, however after the first frame,
> the data gets scrambled and from then on is wrong.
> The pattern stays consistent after frame 2.
>
>
> Looks like I need to stick with single fifo for now.
>
> So, bottom line is:  single fifo seems to work perfectly with my
> proposed fix above.  Dual fifo doesn't seem to work.
>

I realized the problem with the dual fifo mode:  it's that you had set
the maxburst to 16 in your patch.  I guess this must be the maxburst
to a single fifo maybe?  When I set the fual fifo maxburst back to 8,
I get perfection again!

So, now bottom line is:  both single and dual ffio modes work :-)

So, with this patch (I'll send separately as a proper patch), Tx will
work perfectly.

Next thing to tackle is:  doing starts/stops on Tx/Rx in different orders:

So far, I've only verified:
TxStart - TxEnd

Next is:
RxStart - RxEnd

And the combinations:
TxStart - RxStart - TxEnd - RxEnd
TxStart - RxStart - RxEnd - TxEnd
RxStart - TxStart - RxEnd - TxEnd
RxStart - TxStart - TxEnd - RxEnd

Maybe the rest won't be as difficult :-/


> -caleb
