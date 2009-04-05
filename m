From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] ASoC: fsl_dma: Pass the proper device for
	dma mapping routines
Date: Sun, 5 Apr 2009 14:18:20 -0500
Message-ID: <ed82fe3e0904051218i60edfe42o879ee5f7063a2e4c@mail.gmail.com>
References: <20090404183319.GA22203@oksana.dev.rtsoft.ru>
	<fa686aa40904042259h4c69e632x47a9e82393e8faef@mail.gmail.com>
	<20090405085243.GA16005@oksana.dev.rtsoft.ru>
	<fa686aa40904050739g219a9143v7bbc8cd673e52f4e@mail.gmail.com>
	<85829FCA-D181-4992-9889-640B3329D023@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f132.google.com (mail-qy0-f132.google.com
	[209.85.221.132])
	by alsa0.perex.cz (Postfix) with ESMTP id 709342415F
	for <alsa-devel@alsa-project.org>;
	Sun,  5 Apr 2009 21:18:21 +0200 (CEST)
Received: by qyk38 with SMTP id 38so3210928qyk.16
	for <alsa-devel@alsa-project.org>; Sun, 05 Apr 2009 12:18:20 -0700 (PDT)
In-Reply-To: <85829FCA-D181-4992-9889-640B3329D023@kernel.crashing.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kumar Gala <galak@kernel.crashing.org>
Cc: Becky Bruce <Becky.Bruce@freescale.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Grant Likely <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sun, Apr 5, 2009 at 9:59 AM, Kumar Gala <galak@kernel.crashing.org> wrot=
e:

> No, I think we should just fix drivers. =A0There aren't that many SoC dri=
vers
> and once they are fixed this will resolve itself.

I agree.  The only reason I passed NULL when I wrote the drivers was
because I was too lazy to figure out what the right dev pointer was.
ASoC is kinda screwy in that many fields are not initialized when you
think they should be.  More than once I passed a pointer to a wrong
object without realizing it, even though the code worked.

I'll check out these two patches on Monday.

-- =

Timur Tabi
Linux kernel developer at Freescale
