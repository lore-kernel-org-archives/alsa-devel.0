From: "Jie, Yang" <yang.jie@intel.com>
Subject: Re: Audio Mini Summit 2015, 8th October, Dublin
Date: Thu, 15 Oct 2015 13:06:22 +0000
Message-ID: <E7B1D079BA13FB44A978CC8F69C7D6A9229C6AA6@SHSMSX101.ccr.corp.intel.com>
References: <20151004231752.GA22609@sirena.org.uk>
 <20151007152047.GQ12635@sirena.org.uk> <561679FE.3060809@metafoo.de>
 <56167DBF.9090106@metafoo.de> <5617C133.1080006@metafoo.de>
 <s5hlhb8lbi7.wl-tiwai@suse.de> <561BD7BB.2090200@metafoo.de>
 <561BDE02.9070709@perex.cz>
 <E7B1D079BA13FB44A978CC8F69C7D6A9229C56E0@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 20E16260462
 for <alsa-devel@alsa-project.org>; Thu, 15 Oct 2015 15:07:08 +0200 (CEST)
In-Reply-To: <E7B1D079BA13FB44A978CC8F69C7D6A9229C56E0@SHSMSX101.ccr.corp.intel.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: 'Jaroslav Kysela' <perex@perex.cz>, "'alsa-devel@alsa-project.org'" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi all,

I have done some investigation on LTO usage and current status, summarize as below:

1. LTO is still only an experimental feature and not accepted by upstream yet;
2. to enable LTO, we need apply 20+ patches from Andi Kleen's github repo;
3. we need at least 4GB(8GB+ may be better) RAM for LTO kernel building, and using gcc 4.9+(maybe gcc rebuild needed);
4. kernel building may take much longer time, A few kernel features are currently incompatible with LTO.

So my conclusion on this is: LTO is still on experimental stage, we can try use it for specific customer project but not the goal of upstream yet; 
BTW, LTO is a kernel general feature, there is no help for upstream ALSA specific tinification to try on it. 

References:
https://github.com/andikleen/linux-misc/blob/lto-4.0/Documentation/lto-build
http://www.halobates.de/kernel-lto.pdf

thanks,
~Keyon

> -----Original Message-----
> From: Jie, Yang
> Sent: Tuesday, October 13, 2015 9:34 AM
> To: Jaroslav Kysela; alsa-devel@alsa-project.org
> Subject: RE: [alsa-devel] Audio Mini Summit 2015, 8th October, Dublin
> 
> 
> Thanks for pointing out this, Takashi, Lars, and Jaroslav.
> 
> I will try this LTO firstly and see what will happen.
> 
> Thanks,
> ~Keyon
> 
> 
> > -----Original Message-----
> > From: alsa-devel-bounces@alsa-project.org [mailto:alsa-devel-
> > bounces@alsa-project.org] On Behalf Of Jaroslav Kysela
> > Sent: Tuesday, October 13, 2015 12:21 AM
> > To: alsa-devel@alsa-project.org
> > Subject: Re: [alsa-devel] Audio Mini Summit 2015, 8th October, Dublin
> >
> > Dne 12.10.2015 v 17:54 Lars-Peter Clausen napsal(a):
> >
> > > E.g. I'd consider parameter refining a vital part of ALSA and the
> > > core functionality of it is rather compact. But it provides a lot of
> > > helper functions of which only some are going to be used if you
> > > built a reduced kernel. So rather then completely disabling
> > > parameter refining use LTO to remove the unused helper functions.
> >
> > I agree. It sounds like perfect solution for optimized kernel builds.
> >
> > 					Jaroslav
> >
> > --
> > Jaroslav Kysela <perex@perex.cz>
> > Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
