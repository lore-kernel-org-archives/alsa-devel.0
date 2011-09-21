From: Leo Yan <leoy@marvell.com>
Subject: Questions for dummy codec driver
Date: Wed, 21 Sep 2011 10:23:18 +0800
Message-ID: <4E794A96.9040206@marvell.com>
References: <1316502540.4269.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1316502540.4269.1.camel@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

hi all,

I have a question for the dummy codec.

As you know, sometimes maybe we only need set the timing from the 
processor, and codec just only need tx/rx data; So there do not need the 
codec driver.

After browser the code, there have NO such a dummy codec driver; and for 
soc-core, there have not such flags to support this situation.
Only what i get is sound/soc/codecs/spdif_transciever.c, but it's 
specific for TI's DaVinci platform.

I want to get the right direction, so here have some works or discussing 
for that?

Thx,
Leo Yan
