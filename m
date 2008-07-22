From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH v3 0/3] ALSA SoC: MPC5200 audio driver
Date: Tue, 22 Jul 2008 10:52:20 -0400
Message-ID: <9e4733910807220752o4d220f90o770d55e70f493642@mail.gmail.com>
References: <fa686aa40807212358p17c824ia1d6516a87a7aac1@mail.gmail.com>
	<20080722092646.GA7251@sirena.org.uk>
	<9e4733910807220638u5cf48424l92ba780ecd9e3d9d@mail.gmail.com>
	<20080722141027.GB12555@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yx-out-1718.google.com (yx-out-1718.google.com [74.125.44.153])
	by alsa0.perex.cz (Postfix) with ESMTP id B17612437C
	for <alsa-devel@alsa-project.org>;
	Tue, 22 Jul 2008 16:52:26 +0200 (CEST)
Received: by yx-out-1718.google.com with SMTP id 36so315064yxh.2
	for <alsa-devel@alsa-project.org>; Tue, 22 Jul 2008 07:52:25 -0700 (PDT)
In-Reply-To: <20080722141027.GB12555@sirena.org.uk>
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
To: Grant Likely <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, liam.girdwood@wolfsonmicro.com, timur@freescale.com, Mark Brown <broonie@opensourc>
List-Id: alsa-devel@alsa-project.org

On 7/22/08, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Jul 22, 2008 at 09:38:11AM -0400, Jon Smirl wrote:
>
>  > These drivers are going to get hit with immediate patches.  The DMA is
>  > not broken out so that AC97 support can be fixed for the Efika.
>
> Further updates shouldn't present a problem - if anything, it should be
>  easier easier to review incremental patches.

I'm just going to ignore 2.6.27 and wait for 2.6.28.  This driver only
partially implement i2s support and assumes external clocking. There's
no way to add a ASOC machine driver. It's not a general purpose
driver. Adding the rest of the features probably means device tree
changes.

-- 
Jon Smirl
jonsmirl@gmail.com
