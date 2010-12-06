From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: dapm: Add speaker driver widget.
Date: Mon, 6 Dec 2010 23:38:55 +0000
Message-ID: <8C6859A9-36EF-4016-822B-DA67D7147E28@opensource.wolfsonmicro.com>
References: <1889FA7136B567478A67D4B0F85B0CCEA4C52E7E@dlee06.ent.ti.com>
	<20101206224359.GB2862@opensource.wolfsonmicro.com>
	<1291676132.3281.116.camel@odin>
	<20101206230948.GH2862@opensource.wolfsonmicro.com>
	<1291678207.3281.152.camel@odin>
	(sfid-20101206_233011_917022_3EC062E3)
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 33410103942
	for <alsa-devel@alsa-project.org>; Tue,  7 Dec 2010 00:38:59 +0100 (CET)
In-Reply-To: <1291678207.3281.152.camel@odin>
	(sfid-20101206_233011_917022_3EC062E3)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: "Olaya, Margarita" <magi.olaya@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 6 Dec 2010, at 23:30, Liam Girdwood wrote:
> On Mon, 2010-12-06 at 23:09 +0000, Mark Brown wrote:
>> 

>> Sure, but it's fulfiling the same role in the system - it's just that
>> these days a lot more CODECs are pulling speaker drivers directly into
>> the CODEC die.  Mostly these have worked well handled as PGAs so it's
>> not been an issue.

> In this case as we need to enable the PGA before the driver and disable
> the driver before the PGA for pop reduction. Hence the current ordering
> needs an addition/refactoring to deal with the newer generation of
> CODECs here.

Well, what I'm saying is that...

>> I'd certainly expect to see it handled the same way from a DAPM
>> sequencing point of view as it's fulfilling the same role in the system
>> (so in the same slot rather than separately as the patch was doing).  Do
>> we just need to refactor the existing external widgets to be able to
>> exist in either register or GPIO based versions?

...we don't need to change the ordering at all, we've already got a
sequence point for this sort of widget we can use. We should just make
the existing speaker and headphone widgets be in terms of one, I think.

The only reason it's not come up before is that everything so far has been
able to power up cleanly without splitting from the PGAs.
