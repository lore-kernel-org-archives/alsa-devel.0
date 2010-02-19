From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH v3 3/3] ASoC: OMAP4: Add McPDM platform
	driver
Date: Fri, 19 Feb 2010 11:00:48 +0000
Message-ID: <1266577248.3236.31.camel@odin>
References: <2256F256009DAA4CBE661E9F41EAC84B8F94A4F1@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f213.google.com (mail-ew0-f213.google.com
	[209.85.219.213])
	by alsa0.perex.cz (Postfix) with ESMTP id 8AF7A10393B
	for <alsa-devel@alsa-project.org>; Fri, 19 Feb 2010 12:00:53 +0100 (CET)
Received: by ewy5 with SMTP id 5so2001227ewy.32
	for <alsa-devel@alsa-project.org>; Fri, 19 Feb 2010 03:00:52 -0800 (PST)
In-Reply-To: <2256F256009DAA4CBE661E9F41EAC84B8F94A4F1@dlee01.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Candelaria Villareal, Jorge" <jorge.candelaria@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-02-18 at 18:32 -0600, Candelaria Villareal, Jorge wrote:
> From: Misael Lopez Cruz <x0052729@ti.com>
> 
> McPDM platform driver is configured to use sDMA in order to transfer
> to/from memory. Support for interfacing with ABE will be added later.
> 
> McPDM dai currently supports up to 4 downlink channels and 2 uplink
> channels simultaneously, as well as 88.2 and 96 KHz, and a sample
> size of 32 bits.
> 
> Signed-off-by: Misael Lopez Cruz <x0052729@ti.com>
> Signed-off-by: Margarita Olaya <x0080101@ti.com>
> Signed-off-by: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>

This one is good. Can you fix the other two and re-submit.

Thanks

Liam

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
