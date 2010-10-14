From: Ryan Mallon <ryan@bluewatersys.com>
Subject: Re: [PATCH v3 2/3] ARM: ep93xx: add AC97 platform
	support
Date: Fri, 15 Oct 2010 10:57:47 +1300
Message-ID: <4CB77CDB.6050908@bluewatersys.com>
References: <cover.1287066937.git.mika.westerberg@iki.fi>
	<14a8c7ea0482375fa32a022ea7e318ea4feae6f1.1287066937.git.mika.westerberg@iki.fi>
	<0D753D10438DA54287A00B02708426976450C42B0E@AUSP01VMBX24.collaborationhost.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hayes.bluewaternz.com (mail.bluewatersys.com [202.124.120.130])
	by alsa0.perex.cz (Postfix) with ESMTP id C6D8D1037F9
	for <alsa-devel@alsa-project.org>;
	Thu, 14 Oct 2010 23:57:11 +0200 (CEST)
In-Reply-To: <0D753D10438DA54287A00B02708426976450C42B0E@AUSP01VMBX24.collaborationhost.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: H Hartley Sweeten <hartleys@visionengravers.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mika Westerberg <mika.westerberg@iki.fi>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "martinwguy@gmail.com" <martinwguy@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 10/15/2010 10:46 AM, H Hartley Sweeten wrote:
> On Thursday, October 14, 2010 7:49 AM, Mika Westerberg wrote:

>> +void __init ep93xx_register_ac97(void)
>> +{
>> +	/*
>> +	 * Make sure that the AC97 pins are not used by I2S.
>> +	 */
>> +	ep93xx_devcfg_clear_bits(EP93XX_SYSCON_DEVCFG_I2SONAC97);
> 
> This is fine for now.
> 
> Eventually some thought should go into a proper iomux to prevent
> loading drivers with conflicting pin requirements.  Currently, depending
> on the configuration, this could break if a user should try to use the
> ac97 and i2s audio at the same time (I2SONAC97 mode).  But, the same
> problem already exists if a user tries using spi and i2s audio (I2SONSSP
> mode).

I initially suggested this also, since we have acquire/release functions
for some other drivers, but I now think this is fine as is. It's highly
unlikely that a board is going to have both I2S and AC97 audio. We can
change this later if such a board shows up, no need to make the code
more complicated for hypothetical boards :-).

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan@bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
