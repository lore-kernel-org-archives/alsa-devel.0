From: Yoichi Yuasa <yuasa@linux-mips.org>
Subject: Re: [PATCH 02/19] ALSA: ymu831: add device register
	definitions
Date: Thu, 17 Jan 2013 19:33:28 +0900
Message-ID: <20130117193328.40837481c7805922897f2c93@linux-mips.org>
References: <20130116172530.857b627ef3303fb6fe43f603@linux-mips.org>
 <20130116172704.256eccbb8412439455df14e7@linux-mips.org>
 <s5hhamhpczv.wl%tiwai@suse.de>
 <20130117145937.528c2e7df224c8924cda8031@linux-mips.org>
 <s5hboco2tpn.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mo.iij4u.or.jp (mo11.iij4u.or.jp [210.138.174.79])
 by alsa0.perex.cz (Postfix) with ESMTP id A4DA22615F7
 for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2013 11:33:34 +0100 (CET)
In-Reply-To: <s5hboco2tpn.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, yuasa@linux-mips.org
List-Id: alsa-devel@alsa-project.org

On Thu, 17 Jan 2013 07:45:40 +0100
Takashi Iwai <tiwai@suse.de> wrote:

> At Thu, 17 Jan 2013 14:59:37 +0900,
> Yoichi Yuasa wrote:
> > 
> > On Wed, 16 Jan 2013 12:45:56 +0100
> > Takashi Iwai <tiwai@suse.de> wrote:
> > 
> > > At Wed, 16 Jan 2013 17:27:04 +0900,
> > > Yoichi Yuasa wrote:
> > > > 
> > > > 
> > > > Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
> > > > ---
> > > >  sound/soc/codecs/ymu831/mcdefs.h | 4303 ++++++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 4303 insertions(+)
> > > >  create mode 100644 sound/soc/codecs/ymu831/mcdefs.h
> > > > 
> > > > diff --git a/sound/soc/codecs/ymu831/mcdefs.h b/sound/soc/codecs/ymu831/mcdefs.h
> > > > new file mode 100644
> > > > index 0000000..fbd2008
> > > > --- /dev/null
> > > > +++ b/sound/soc/codecs/ymu831/mcdefs.h
> > > > @@ -0,0 +1,4303 @@
> > > > +/****************************************************************************
> > > > + *
> > > > + * Copyrightc 2012 Yamaha Corporation. All rights reserved.
> > > > + *
> > > > + * Module	: mcdefs.h
> > > > + * Description	: MC device definitions
> > > > + * Version	: 1.0.1	Dec 18 2012
> > > > + *
> > > > + * This software is provided 'as-is', without any express or implied
> > > > + * warranty.	In no event will the authors be held liable for any damages
> > > > + * arising from the use of this software.
> > > > + *
> > > > + * Permission is granted to anyone to use this software for any purpose,
> > > > + * including commercial applications, and to alter it and redistribute it
> > > > + * freely, subject to the following restrictions:
> > > > + *
> > > > + * 1. The origin of this software must not be misrepresented; you must not
> > > > + *	claim that you wrote the original software. If you use this software
> > > > + *	in a product, an acknowledgment in the product documentation would be
> > > > + *	appreciated but is not required.
> > > > + * 2. Altered source versions must be plainly marked as such, and must not be
> > > > + *	misrepresented as being the original software.
> > > > + * 3. This notice may not be removed or altered from any source distribution.
> > > > + *
> > > > + ****************************************************************************
> > > /
> > > 
> > > So you need to keep zlib license instead of the standard GPLv2?
> > 
> > The base codes license is zlib license.
> > It is not so easy to change.
> 
> Then it's another good reason to rewrite the driver from scratch.
> 
> The code with zlib license in kernel is taken from zlib itself.
> Keeping it as is had merit from maintenance POV, as well.
> 
> But in your case, 99% of the whole code would have to be either
> rewritten or strip as a binary blob.  Why sticking with it at all?
> 
> As Mark already suggested, consider to start writing from scratch.
> Then you'll get much more maintainable driver code.

I don't have the sufficient information for rewriting the driver.
I'll try to get more information.

Thanks,

Yoichi



Yoichi
