From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: fsl_ssi.c: Getting channel slips with fsl_ssi.c in
 TDM (network) mode.
Date: Mon, 2 Nov 2015 09:22:48 -0800
Message-ID: <20151102172247.GA4068@Asurada-CZ80>
References: <20151029171936.GA3492@Asurada-CZ80>
 <CAG5mAdzci2hPUBzFo+k3+CorfzQZD9_knQ2TXw1db1KoBL5Eyw@mail.gmail.com>
 <20151029192816.GA43706@Asurada-CZ80>
 <CAG5mAdzJ2_MizAq2ACXwnA=wfO=xujGbUdB2OvcDi=7fHQfyBQ@mail.gmail.com>
 <20151029224713.GA44369@Asurada-CZ80>
 <CAG5mAdwnjLdxNNgC3go_NDERUSDxem9ZQFigyF5yaEWuXV2r4g@mail.gmail.com>
 <20151030012934.GA5456@Asurada-GSX>
 <CAG5mAdwUKwzGvpO3ckKZWfE+oKXHK7umT5Z3Ru3Oyq8AD7gNMg@mail.gmail.com>
 <20151031014845.GB3525@Asurada-CZ80>
 <CAG5mAdztDH3V1Q1Y2RQpeHoNWJPa9X9KGFhCw3zirh_-_v4ruw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f50.google.com (mail-pa0-f50.google.com
 [209.85.220.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C54B2618ED
 for <alsa-devel@alsa-project.org>; Mon,  2 Nov 2015 18:22:54 +0100 (CET)
Received: by pabfh17 with SMTP id fh17so30187637pab.0
 for <alsa-devel@alsa-project.org>; Mon, 02 Nov 2015 09:22:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAG5mAdztDH3V1Q1Y2RQpeHoNWJPa9X9KGFhCw3zirh_-_v4ruw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Caleb Crome <caleb@crome.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Markus Pargmann <mpa@pengutronix.de>, "arnaud.mouiche@invoxia.com" <arnaud.mouiche@invoxia.com>, Roberto Fichera <kernel@tekno-soft.it>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Sat, Oct 31, 2015 at 09:22:54AM -0700, Caleb Crome wrote:
 
> > But I would like to see how the change will be after merging the
> > simultaneous TE/RE work around.
> 
> I'm not sure I understand this statement.  What's the simultaneous
> TE/RE work around?  It appears that the trigger function *only* does
> either one or the other, and not simultaneously. Is there a patch in
> the works to make tx/rx happen simultaneously?

I mean those problems Arnaud mentioned.
