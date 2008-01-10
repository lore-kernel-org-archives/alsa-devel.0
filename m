From: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
Date: Thu, 10 Jan 2008 09:01:04 -0700
Message-ID: <fa686aa40801100801p3da98eecn44401b17fe652da8@mail.gmail.com>
References: <9e4733910801010925j67192427o4e0e824b9d7e0ad0@mail.gmail.com>
	<20080103235156.GE12883@localhost.localdomain>
	<477EEDFA.9010205@freescale.com>
	<20080106004637.GJ4326@localhost.localdomain>
	<47824AA3.5070808@freescale.com>
	<20080107182853.GA17312@sirena.org.uk>
	<20080110034919.GI17816@localhost.localdomain>
	<9e4733910801092141m5d4476d0l1c081307fd5c1969@mail.gmail.com>
	<1199961015.19903.270.camel@localhost.localdomain>
	<47863C31.50309@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.250])
	by alsa0.perex.cz (Postfix) with ESMTP id E304D245F1
	for <alsa-devel@alsa-project.org>; Thu, 10 Jan 2008 17:01:05 +0100 (CET)
Received: by an-out-0708.google.com with SMTP id c36so174247ana.80
	for <alsa-devel@alsa-project.org>; Thu, 10 Jan 2008 08:01:04 -0800 (PST)
In-Reply-To: <47863C31.50309@freescale.com>
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
Cc: alsa-devel@alsa-project.org, linuxppc-dev@ozlabs.org, Olof Johansson <olof@lixom.net>, david@gibson.dropbear.id.au
List-Id: alsa-devel@alsa-project.org

On 1/10/08, Timur Tabi <timur@freescale.com> wrote:
> Liam Girdwood wrote:
>
> > I think we are probably looking at submission in the next 8 - 10 weeks.
> > Currently most of the core code is complete, however some platforms and
> > codecs still need porting.
>
> With that in mind, can I get some kind of consensus from the PPC side as to
> whether this ASoC V1 driver is okay?  I want to get it into 2.6.25.
>
> Keep in mind:
>
> 1) ASoC V1 is not PowerPC-friendly, so it's impossible to make an ASoC V1
> PowerPC driver "100% correct".

The driver doesn't need to be 100% correct.  Drivers are easy to
change if they aren't quite right.  There are no long term
consequences.

However, the device tree issues must be addressed before it is merged
and deployed.  Otherwise we end up having to support poorly designed
trees over the long term.

So, I'm okay with merging the driver *minus* the .dts and
booting-without-of.txt changes.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
