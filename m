From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [alsa-devel] [PATCH] ALSA SOC driver for s3c24xx with uda1341
Date: Mon, 10 Nov 2008 22:10:44 +0000
Message-ID: <20081110221044.GI22835@trinity.fluff.org>
References: <12261302352402-git-send-email-chripell@gmail.com>
	<20081110133451.GD12804@sirena.org.uk>
	<20081110185800.42b6c198.kristoffer.ericson@gmail.com>
	<cabda6420811101108od6fe848qc291135a2ba9d819@mail.gmail.com>
	<20081110212233.3d3bcc7c.kristoffer.ericson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <20081110212233.3d3bcc7c.kristoffer.ericson@gmail.com>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Cc: chri <chripell@gmail.com>, Mark Brown <broonie@sirena.org.uk>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.arm.linux.org.uk, zdevai@gmail.com
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 10, 2008 at 09:22:33PM +0100, Kristoffer Ericson wrote:
> On Mon, 10 Nov 2008 20:08:00 +0100
> chri <chripell@gmail.com> wrote:
> 
> > On Mon, Nov 10, 2008 at 6:58 PM, Kristoffer Ericson
> > <kristoffer.ericson@gmail.com> wrote:
> > > On Mon, 10 Nov 2008 13:34:52 +0000
> > 
> > > I'm equally interested in this patch, seeing as I
> > > got an hp jornada 7xx with uda1344 waiting.
> > >
> > > Have you any plans on creating an 134x seeing as there
> > > is very little difference between chipsets?
> > >
> > 
> > Hi,
> > 
> > I had a quick look at the UDA1344 data sheet. When operated in L3-mode
> > it's basically a subset of the UDA1341 so I can do the changes. Anyway
> > I'm not able to test them so could you give me a hand testing? Anyway
> > if you won't use special mixer settings the patch I sent should work
> > since the important configuration registers and the volume are the
> > same for both chips.
> 
> It would be good if the driver could be used for both 1341/1344.
> Some minor ifdef's should sort it out. 
> Please drop me a mail with the patches (missed the old one) and I'll start
> testing them them out.

eww, ifdefs... 
 
> > 
> > -- 
> > Christian Pellegrin, see http://www.evolware.org/chri/
> > "Real Programmers don't play tennis, or any other sport which requires
> > you to change clothes. Mountain climbing is OK, and Real Programmers
> > wear their climbing boots to work in case a mountain should suddenly
> > spring up in the middle of the computer room."
> 
> 
> -- 
> Kristoffer Ericson <kristoffer.ericson@gmail.com>



> -------------------------------------------------------------------
> List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
> FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
> Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.


-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
