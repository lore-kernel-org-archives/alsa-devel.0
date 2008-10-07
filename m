From: "Jesslyn Abdul Salam" <jesslyn.abdulsalam@gmail.com>
Subject: Fwd:  AIC23 SOC Driver on OSK5912
Date: Tue, 7 Oct 2008 17:36:38 +0530
Message-ID: <e762f7a90810070506x9c26ecfh6fa68a833c2ae98b@mail.gmail.com>
References: <e762f7a90810070448g6eb4545ay340e6be8de775133@mail.gmail.com>
	<20081007115450.GD19835@sirena.org.uk>
	<dfeb90390810070502x42ec3d85heb87f21d5c3074ec@mail.gmail.com>
	<e762f7a90810070506q2d4e299eqe2d6d9bc515aeec0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.171])
	by alsa0.perex.cz (Postfix) with ESMTP id E0E7A24557
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Oct 2008 14:06:52 +0200 (CEST)
Received: by wf-out-1314.google.com with SMTP id 24so3235662wfg.23
	for <alsa-devel@alsa-project.org>; Tue, 07 Oct 2008 05:06:38 -0700 (PDT)
In-Reply-To: <e762f7a90810070506q2d4e299eqe2d6d9bc515aeec0@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

---------- Forwarded message ----------
From: Jesslyn Abdul Salam <jesslyn.abdulsalam@gmail.com>
Date: Tue, Oct 7, 2008 at 5:36 PM
Subject: Re: [alsa-devel] AIC23 SOC Driver on OSK5912
To: Arun KS <arunks@mistralsolutions.com>


Yes, it is there. but it shows as "tlv320aic23b" instead of "tlv320aic" Will
that be the reason ????




On Tue, Oct 7, 2008 at 5:32 PM, Arun KS <arunks@mistralsolutions.com> wrote:

> On Tue, Oct 7, 2008 at 5:24 PM, Mark Brown <broonie@sirena.org.uk> wrote:
> > On Tue, Oct 07, 2008 at 05:18:55PM +0530, Jesslyn Abdul Salam wrote:
> >
> >> I have been trying to use the AIC23 ALSA SoC driver for OSK5912 for the
> past
> >> few days. I got the driver patch from the linux-omap/alsa-devel mailing
> >> lists. The driver got compiled along just fine. But when the kernel
> boots,
> >> no sound cards have been listed.
> >
> > CCing in Arun KS <arunks@mistralsolutions.com> who contributed that
> > support.
> >
> >> Advanced Linux Sound Architecture Driver Version 1.0.17.
> >
> >> ASoC version
> >> 0.13.2
> >> AIC23 Audio Codec
> >> 0.1
> >> MCLK = 12000000 [12000000], usecount =
> >> 0
> >> ALSA device
> >> list:
> >>     No soundcards
> >> found.
> >
> >> Any one have tested this before ?
>
> Can you check i2c?
>
> # cat /sys/bus/i2c/devices/1-001b/name
> tlv320aic23
>
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> >
>
