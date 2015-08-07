From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 00/42] ASoC: Replace users of
	TLV_DB_RANGE_HEAD
Date: Fri, 7 Aug 2015 09:26:05 +0100
Message-ID: <20150807082605.GE25225@opensource.wolfsonmicro.com>
References: <1438528810-23498-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D8BDD26041F
 for <alsa-devel@alsa-project.org>; Fri,  7 Aug 2015 10:26:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1438528810-23498-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Oder Chiou <oder_chiou@realtek.com>, Brian Austin <brian.austin@cirrus.com>, Support Opensource <support.opensource@diasemi.com>, alsa-devel@alsa-project.org, Anish Kumar <yesanishhere@gmail.com>, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Aug 02, 2015 at 05:19:28PM +0200, Lars-Peter Clausen wrote:
> Usage of TLV_DB_RANGE_HEAD() is deprecated in favor of
> DECLARE_TLV_DB_RANGE(). The reason for this is that the former requires to
> specify the number of items inside the range container while the later is
> able to calculate this automatically and hence leaves less room for error.
> 
> While non of the current users of TLV_DB_RANGE_HEAD() gets it wrong it
> still makes sense to clean this up since existing drivers are often used as
> templates for new drivers. As an added bonus the code is also slightly
> shorter.
> 
> There are also a few drivers which use TLV_DB_RANGE_HEAD() with only a
> single sub-item. Those are updated to not use a range container at all
> since it is not necessary.
> 
> Most of the conversion was auto-generated using the following coccinelle
> script:
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
> - Lars
> 

For the Wolfson parts:

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
