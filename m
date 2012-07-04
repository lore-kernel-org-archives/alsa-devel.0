From: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Subject: Re: How to handle parameter variation across different
 boards but same platform
Date: Wed, 4 Jul 2012 13:43:12 +0000
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EA35456@DBDE01.ent.ti.com>
References: <1BAFE6F6C881BF42822005164F1491C33EA3532A@DBDE01.ent.ti.com>
	<20120704131749.GZ4111@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 7CD84104419
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Jul 2012 15:43:19 +0200 (CEST)
In-Reply-To: <20120704131749.GZ4111@opensource.wolfsonmicro.com>
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

On Wed, Jul 04, 2012 at 18:47:50, Mark Brown wrote:
> On Wed, Jul 04, 2012 at 12:45:03PM +0000, Hebbar, Gururaja wrote:
> 
> You should fix your mailer to word wrap at less than 80 columns.

Sorry. Stupid outlook. Will take care of it manually.

> 
> > Using machine_is_xxx() is not sufficient because there are 2 other
> > boards on same Platform/machine but with different values.
> 
> > So, how to specify these parameters for the new board?
> 
> What do you mean by "board"?  If these are plugin modules for your
> platform you need to either identify this at runtime and register a
> different machine driver or select at compile time.
> 

By board I mean a new development board. 

New board
sysclk = 24MHz
codec_name = "tlv320aic3x-codec.1-001b"

Previous Board
sysclk = 12MHz
.codec_name = "tlv320aic3x-codec.2-001b",

Both boards share the same machine is API (machine_is_am33xx()).

So, is there any mechanism/api to differentiate these 2 boards inside 
Code?

Has anyone else faced such situation?

Regards, 
Gururaja
