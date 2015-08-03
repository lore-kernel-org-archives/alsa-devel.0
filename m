From: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Subject: Re: [PATCH 11/42] ASoC: da9055: Replace
 TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
Date: Mon, 3 Aug 2015 14:47:35 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337AB569098@SW-EX-MBX01.diasemi.com>
References: <1438528810-23498-1-git-send-email-lars@metafoo.de>
 <1438528810-23498-12-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta5.messagelabs.com (mail1.bemta5.messagelabs.com
 [195.245.231.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 9124926517A
 for <alsa-devel@alsa-project.org>; Mon,  3 Aug 2015 16:47:37 +0200 (CEST)
In-Reply-To: <1438528810-23498-12-git-send-email-lars@metafoo.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, Brian Austin <brian.austin@cirrus.com>, Support Opensource <Support.Opensource@diasemi.com>, Anish Kumar <yesanishhere@gmail.com>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Bard Liao <bardliao@realtek.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On August 2, 2015 16:20, Lars-Peter Clausen wrote:

> DECLARE_TLV_DB_RANGE() has the advantage over using TLV_DB_RANGE_HEAD()
> that it automatically calculates the number of items in the TLV and is
> hence less prone to manual error.
> 
> Generate using the following coccinelle script
> 
> // <smpl>
> @@
> declarer name DECLARE_TLV_DB_RANGE;
> identifier tlv;
> constant x;
> @@
> -unsigned int tlv[] = {
> -	TLV_DB_RANGE_HEAD(x),
> +DECLARE_TLV_DB_RANGE(tlv,
> 	...
> -};
> +);
> // </smpl>
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Acked-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
