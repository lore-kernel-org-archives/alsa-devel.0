From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
Date: Thu, 10 Jan 2008 15:39:57 -0500
Message-ID: <9e4733910801101239n539507a8sb23d1a2177e69bd9@mail.gmail.com>
References: <9e4733910801010925j67192427o4e0e824b9d7e0ad0@mail.gmail.com>
	<20080107182853.GA17312@sirena.org.uk>
	<20080110034919.GI17816@localhost.localdomain>
	<9e4733910801092141m5d4476d0l1c081307fd5c1969@mail.gmail.com>
	<1199961015.19903.270.camel@localhost.localdomain>
	<47863C31.50309@freescale.com>
	<fa686aa40801100801p3da98eecn44401b17fe652da8@mail.gmail.com>
	<478641E3.5070404@freescale.com>
	<9e4733910801101210w5846bb4ds38a603a489ef0522@mail.gmail.com>
	<47867C80.4050408@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.181])
	by alsa0.perex.cz (Postfix) with ESMTP id C0C482470A
	for <alsa-devel@alsa-project.org>; Thu, 10 Jan 2008 21:39:59 +0100 (CET)
Received: by wa-out-1112.google.com with SMTP id m33so1394170wag.8
	for <alsa-devel@alsa-project.org>; Thu, 10 Jan 2008 12:39:58 -0800 (PST)
In-Reply-To: <47867C80.4050408@freescale.com>
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
Cc: alsa-devel@alsa-project.org, Grant Likely <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org, Olof Johansson <olof@lixom.net>, david@gibson.dropbear.id.au
List-Id: alsa-devel@alsa-project.org

On 1/10/08, Timur Tabi <timur@freescale.com> wrote:
> Jon Smirl wrote:
>
> > Isn't your codec is i2c controlled? Where does the main node for the
> > code live, i2c bus or ssi bus? What does the link between the buses
> > look like for pointing to the codec entry?
>
> The CS4270 driver is "old style", which means it probes all possible I2C
> addresses until it finds a hit, and then stops.  This has all the obvious
> drawbacks, but I'm stuck with that design for now.

So the codec is controlled from the i2c bus and SSI is used to supply
it with data. Based on what has been said on this list, the device
tree node for the codec should be on the i2c bus with a link from the
ssi bus to it.

>
> > What about fsl,ssi being too generic for a compatible type?
>
> Already fixed:
>
>                 ssi@16000 {
>                         compatible = "fsl,mpc8610-ssi";
> --
> Timur Tabi
> Linux kernel developer at Freescale
>


-- 
Jon Smirl
jonsmirl@gmail.com
