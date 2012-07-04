From: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Subject: Re: How to handle parameter variation across different
 boards but same platform
Date: Wed, 4 Jul 2012 14:17:48 +0000
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EA35B10@DBDE01.ent.ti.com>
References: <1BAFE6F6C881BF42822005164F1491C33EA3532A@DBDE01.ent.ti.com>
	<20120704131749.GZ4111@opensource.wolfsonmicro.com>
	<1BAFE6F6C881BF42822005164F1491C33EA35456@DBDE01.ent.ti.com>
	<20120704140118.GA4111@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 4347910441F
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Jul 2012 16:17:56 +0200 (CEST)
In-Reply-To: <20120704140118.GA4111@opensource.wolfsonmicro.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Nori,
	Sekhar" <nsekhar@ti.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "'sudhakar.raj@ti.com" <'sudhakar.raj@ti.com>, "alsa-user@lists.sourceforge.net" <alsa-user@lists.sourceforge.net>, "Girdwood, Liam" <lrg@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 04, 2012 at 19:31:18, Mark Brown wrote:
> On Wed, Jul 04, 2012 at 01:43:12PM +0000, Hebbar, Gururaja wrote:
> > On Wed, Jul 04, 2012 at 18:47:50, Mark Brown wrote:
> 
> > > What do you mean by "board"?  If these are plugin modules for your
> > > platform you need to either identify this at runtime and register a
> > > different machine driver or select at compile time.
> 
> > By board I mean a new development board. 
> 
> > New board
> > sysclk = 24MHz
> > codec_name = "tlv320aic3x-codec.1-001b"
> 
> > Previous Board
> > sysclk = 12MHz
> > .codec_name = "tlv320aic3x-codec.2-001b",
> 
> > Both boards share the same machine is API (machine_is_am33xx()).
> 
> > So, is there any mechanism/api to differentiate these 2 boards inside 
> > Code?
> 
> > Has anyone else faced such situation?
> 
> If these are totally different boards they should have different machine
> IDs set so machine_is_() should identify.  If that isn't there then you
> need to do something custom to your products to identify the boards
> further.

They are different boards with same SoC (AM33xx). So they both are true for
machine_is_am33xx().

We have a means to detect the type of board but in arch/arm/mach-omap2/ 
board file. However, I believe it is not recommended to call boards api
inside drivers.

Can you give me more info about the "custom option" you suggested? 


> 


Regards, 
Gururaja
