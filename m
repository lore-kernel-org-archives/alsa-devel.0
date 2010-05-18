From: "Candelaria Villarreal, Jorge" <jorge.candelaria@ti.com>
Subject: Re: ASoC: OMAP4: Add support for Earphone speaker
Date: Tue, 18 May 2010 10:41:14 -0500
Message-ID: <2256F256009DAA4CBE661E9F41EAC84B9145E75D@dlee01.ent.ti.com>
References: <1274192636-1430-1-git-send-email-jorge.candelaria@ti.com>
	<20100518150052.GA27313@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id DA46524967
	for <alsa-devel@alsa-project.org>;
	Tue, 18 May 2010 17:41:17 +0200 (CEST)
In-Reply-To: <20100518150052.GA27313@opensource.wolfsonmicro.com>
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
Cc: "Olaya, Margarita" <magi.olaya@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

alsa-devel-bounces@alsa-project.org wrote:
> On Tue, May 18, 2010 at 09:23:56AM -0500, Jorge Eduardo
> Candelaria wrote:
>> Add control to enable earphone driver in TWL6040 codec. This driver
>> is connected to HSDAC Left. 
>> 
>> Also enable earphone speaker in sdp4430 machine driver.
> 
> Please don't merge patches like this - you should patch the machine
> driver separately to the CODEC driver unless required for building.
> This helps reduce merge problems, makes the changelogs easier
> to follow
> and makes it easier to apply patches if there's review issues with
> one part of them. 
> 
>> Signed-off-by: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
>> Signed-off-by: Margarita Olaya Cabrera <magi.olaya@ti.com>
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

I'll split this in two patches and add your Acked-by. Thanks.

> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
