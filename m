From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: mcbsp: Add McBSP support for OMAP4
Date: Tue, 21 Dec 2010 10:17:12 +0000
Message-ID: <1292926632.3296.1.camel@odin>
References: <1889FA7136B567478A67D4B0F85B0CCEA4F6D3A7@dlee06.ent.ti.com>
	<20101220173612.GC2531@rakim.wolfsonmicro.main>
	<20101221114858.0e29e684.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 588E92441C
	for <alsa-devel@alsa-project.org>; Tue, 21 Dec 2010 11:17:17 +0100 (CET)
Received: by wyi11 with SMTP id 11so3649601wyi.38
	for <alsa-devel@alsa-project.org>; Tue, 21 Dec 2010 02:17:16 -0800 (PST)
In-Reply-To: <20101221114858.0e29e684.jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: "Olaya, Margarita" <magi.olaya@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2010-12-21 at 11:48 +0200, Jarkko Nikula wrote:
> On Mon, 20 Dec 2010 17:36:13 +0000
> Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> 
> > On Mon, Dec 20, 2010 at 11:32:47AM -0600, Olaya, Margarita wrote:
> > > From: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
> > > 
> > > This patch adds McBSP support for the OMAP4 CPU
> > 
> > Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> 
> Have my ack too
> Acked-by: Jarkko Nikula <jhnikula@gmail.com>
> 
> Out of curiosity: can the McBSP interface to be used as a simple
> alternative to OMAP4 ABE centric audio on existing platfroms like Panda?
> 

McBSP, McPDM and DMIC can all be used without the ABE in legacy mode on
OMAP4. 

Liam

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
