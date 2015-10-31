From: Caleb Crome <caleb@crome.org>
Subject: Re: fsl_ssi.c: Getting channel slips with fsl_ssi.c in
 TDM (network) mode.
Date: Sat, 31 Oct 2015 09:12:21 -0700
Message-ID: <CAG5mAdwQsu5Y0jHsd7W=Rg4V7MT+-jG5TZvOQzcrkfSsGekmSw@mail.gmail.com>
References: <CAG5mAdwQd3ep7ZSNHDEni6caKeFPyvXhM0g=BjqPFA_gDSU1DQ@mail.gmail.com>
 <20151029171936.GA3492@Asurada-CZ80>
 <CAG5mAdzci2hPUBzFo+k3+CorfzQZD9_knQ2TXw1db1KoBL5Eyw@mail.gmail.com>
 <20151029192816.GA43706@Asurada-CZ80>
 <CAG5mAdzJ2_MizAq2ACXwnA=wfO=xujGbUdB2OvcDi=7fHQfyBQ@mail.gmail.com>
 <20151029224713.GA44369@Asurada-CZ80>
 <CAG5mAdwnjLdxNNgC3go_NDERUSDxem9ZQFigyF5yaEWuXV2r4g@mail.gmail.com>
 <20151030012934.GA5456@Asurada-GSX>
 <CAG5mAdwUKwzGvpO3ckKZWfE+oKXHK7umT5Z3Ru3Oyq8AD7gNMg@mail.gmail.com>
 <CAG5mAdxNPKZw1_9HSKA0HrgzpZKOhq8dy2TZi095M9AibdcNCQ@mail.gmail.com>
 <20151031013205.GA3525@Asurada-CZ80>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f43.google.com (mail-wm0-f43.google.com [74.125.82.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 812B1260513
 for <alsa-devel@alsa-project.org>; Sat, 31 Oct 2015 17:12:41 +0100 (CET)
Received: by wmff134 with SMTP id f134so31397559wmf.0
 for <alsa-devel@alsa-project.org>; Sat, 31 Oct 2015 09:12:41 -0700 (PDT)
In-Reply-To: <20151031013205.GA3525@Asurada-CZ80>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Roberto Fichera <kernel@tekno-soft.it>, "arnaud.mouiche@invoxia.com" <arnaud.mouiche@invoxia.com>, Markus Pargmann <mpa@pengutronix.de>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 30, 2015 at 6:32 PM, Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> On Fri, Oct 30, 2015 at 03:35:17PM -0700, Caleb Crome wrote:
>
>> > **********************
>> > ** Problem 2 *******
>> > **********************
>
>> I realized the problem with the dual fifo mode:  it's that you had set
>> the maxburst to 16 in your patch.  I guess this must be the maxburst
>> to a single fifo maybe?  When I set the fual fifo maxburst back to 8,
>> I get perfection again!
>
> I actually set 16 for dual FIFO and tested with 2-channel playback.
> Since you have dual FIFO right now, burst 8 doesn't hurt a lot as
> SPBA should be a pretty dedicated bus from SDMA point of view. As
> long as you don't have too many SPBA modules working with SDMA. It
> should work for you.

But did check for bit perfect playback from start to end of your file?
 Or simply that it sounded right?  it appears that with maxburst=16,
after about 30 samples, the data plays out without further slipping.
This would appear 'working' without careful analysis because it could
slip an even number of samples and each channel would end up in the
right slot after a few frames.  maxbust=16 *definitely* does not work
for me.

-Caleb


> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
