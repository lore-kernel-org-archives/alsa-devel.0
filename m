From: Tanu Kaskinen <tanuk@iki.fi>
Subject: Re: Alsa-Plugin 1.0.25 License
Date: Tue, 06 Aug 2019 18:27:10 +0300
Message-ID: <9579b65b633a4199e7728f68968c669cb8390302.camel@iki.fi>
References: <CAM+cExGffwFD7U--tZqd_PxFwgdy6YA_tZHvw6B3au9KNygEhA@mail.gmail.com>
 <CAM+cExEBpgWctFLKcVej9UnLS2VVx9CoaOigu9y3BvYGNOi1zA@mail.gmail.com>
 <5e969a5245d6922d28d71a7c453dd6e3f5fd2228.camel@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 355E2F8011B
 for <alsa-devel@alsa-project.org>; Tue,  6 Aug 2019 17:27:17 +0200 (CEST)
In-Reply-To: <5e969a5245d6922d28d71a7c453dd6e3f5fd2228.camel@iki.fi>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: karina filer <kafiler0911@gmail.com>, alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On Tue, 2019-08-06 at 16:20 +0300, Tanu Kaskinen wrote:
> On Mon, 2019-08-05 at 22:44 +0530, karina filer wrote:
> > Hi Team,
> > 
> > Greetings !!
> > 
> > I am facing difficulty to understand the Alsa-Plugin Licensing, Could you
> > please help me to make understand?, Is it under GPL 2.0 or LGPL 2.1 because
> > after extracting the folder I can see 2 copying file one for GPL and other
> > for LGPL.
> > 
> > https://repology.org/project/alsa-plugins/packages
> 
> alsa-plugins seems to lack a README or other overview document about
> the licensing... alsa-plugins is primarily licensed under LGPL 2.1, and
> to my knowledge the only exception is the libsamplerate based rate
> plugin.

I now had a look at the link you provided, and there I saw that BSD-3-
Clause and MIT were also mentioned. I had a closer look at the code,
and I found two more exceptions: the libspeexdsp based rate plugin
(under the pph directory) seems to be licensed under BSD-3-Clause, and
rate-lav/gcd.h is licensed under MIT (rate-lav/rate_lavrate.c is LGPL,
however).

> The licensing is explained here:
> 
> https://git.alsa-project.org/?p=alsa-plugins.git;a=blob;f=rate/rate_samplerate.c
> 
> So this particluar rate plugin is licensed under GPL 2.0 "to follow the
> license of libsamplerate", unless you have a commercial license to
> libsamplerate. I don't think the rationale for that exception makes
> much sense (LGPL would have worked just fine, as far as I can tell),
> but at this point relicensing may be very difficult due to many
> contributors.
> 
> libsamplerate was relicensed under the 2-clause BSD license in 2016[1],
> which may or may not allow you to apply LGPL to the rate plugin (my
> guess would be that it doesn't allow you to do that, but IANAL).
> 
> [1] http://www.mega-nerd.com/SRC/license.html

-- 
Tanu

https://www.patreon.com/tanuk
https://liberapay.com/tanuk
