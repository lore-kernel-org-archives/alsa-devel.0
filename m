From: "Austin, Brian" <Brian.Austin@cirrus.com>
Subject: Re: [PATCH] ASoC: cs42l52: Remove duplicate module
	exit code
Date: Mon, 30 Apr 2012 11:08:42 +0000
Message-ID: <0B44ECC9-2DEA-4C85-9070-1D893326071E@cirrus.com>
References: <1335780850-2902-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db3outboundpool.messaging.microsoft.com
	(db3ehsobe005.messaging.microsoft.com [213.199.154.143])
	by alsa0.perex.cz (Postfix) with ESMTP id 06DDF24483
	for <alsa-devel@alsa-project.org>;
	Mon, 30 Apr 2012 13:08:54 +0200 (CEST)
In-Reply-To: <1335780850-2902-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "joe@nucleusys.com" <joe@nucleusys.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org



On Apr 30, 2012, at 5:14 AM, "Mark Brown" <broonie@opensource.wolfsonmicro.com> wrote:

> In the conversion to module_init_i2c() the original open coded module
> exit function was left. 

Thanks Mark,

Brian
