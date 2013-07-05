From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: ak4554: add DT support
Date: Fri, 05 Jul 2013 11:37:25 +0200
Message-ID: <51D693D5.3080307@metafoo.de>
References: <87wqp5wwuy.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-102.synserver.de (smtp-out-102.synserver.de
 [212.40.185.102])
 by alsa0.perex.cz (Postfix) with ESMTP id 2787E2658ED
 for <alsa-devel@alsa-project.org>; Fri,  5 Jul 2013 11:36:53 +0200 (CEST)
In-Reply-To: <87wqp5wwuy.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Stephen Warren <swarren@nvidia.com>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org

> +  - compatible : "asahi-kasei,ak4554"

The vendor prefix for Asahi Kasei is documented as "ak" in
Documentation/devicetree/bindings/vendor-prefixes.txt. But it doesn;t seem
to be used in any upstream drivers, Stephen add that prefix maybe he knows
if it is used. If it is unused you should probably send a patch updating the
Documentation.

- Lars
