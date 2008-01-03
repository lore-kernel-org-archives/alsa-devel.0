From: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
Date: Thu, 3 Jan 2008 11:38:39 -0700
Message-ID: <fa686aa40801031038v65b86934i99de48187f2a67b7@mail.gmail.com>
References: <11981089894052-git-send-email-timur@freescale.com>
	<9e4733910801012027p4be16b92r43af773f4e5ae531@mail.gmail.com>
	<477BADF5.9060003@freescale.com>
	<fa686aa40801020828u5103d09cn2aa5eab7dda2fcff@mail.gmail.com>
	<477D25F4.6020700@freescale.com>
	<fa686aa40801031025r10c31ce6x203755fe532f0c88@mail.gmail.com>
	<477D296A.6040202@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.248])
	by alsa0.perex.cz (Postfix) with ESMTP id 0AED42462A
	for <alsa-devel@alsa-project.org>; Thu,  3 Jan 2008 19:38:40 +0100 (CET)
Received: by an-out-0708.google.com with SMTP id c36so1454801ana.80
	for <alsa-devel@alsa-project.org>; Thu, 03 Jan 2008 10:38:39 -0800 (PST)
In-Reply-To: <477D296A.6040202@freescale.com>
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
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 1/3/08, Timur Tabi <timur@freescale.com> wrote:
> Grant Likely wrote:
>
> > Make the compatible property tell you!  :-)  If it's connected to an
> > I2S codec, then it could be compatible = "fsl,mpc8610-ssi,i2s".  Or
> > for AC7, compatible = "fsl,mpc8610-ssi,ac97"
>
> That won't work.  There are too many variations.  I think a separate property
> just makes more sense.  Frankly, I don't see what's wrong with it.

Sure it will, that's exactly what I'm doing with the 5200, but I won't
argue the point.  My *opinion* is that using compatible is a more
elegant approach for this type of multifunction device, but using a
mode property is neither wrong or bad.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
