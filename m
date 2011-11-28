From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Staticise and constify
 cs42l73_reg_defaults
Date: Mon, 28 Nov 2011 21:30:38 +0000
Message-ID: <20111128213037.GA11252@opensource.wolfsonmicro.com>
References: <1321974896-11286-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<alpine.DEB.2.02.1111281514430.8911@heelrod.ad.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 408A710395B
	for <alsa-devel@alsa-project.org>; Mon, 28 Nov 2011 22:30:40 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1111281514430.8911@heelrod.ad.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 28, 2011 at 03:26:53PM -0600, Brian Austin wrote:

> Shouldn't this require struct reg_default *reg_defaults;
> be const as well?

> sound/soc/codecs/cs42l73.c:1327: warning: initialization discards
> qualifiers from pointer target type

It'll all be fine in -next, the regmap header has changed there.
