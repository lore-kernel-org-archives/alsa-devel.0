From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: dapm: Ensure power gets managed for
	line widgets
Date: Mon, 16 Apr 2012 16:01:08 +0100
Message-ID: <1334588468.2255.3.camel@odin>
References: <1334248206-17959-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog118.obsmtp.com (na3sys009aog118.obsmtp.com
	[74.125.149.244])
	by alsa0.perex.cz (Postfix) with ESMTP id C8B581041B6
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Apr 2012 17:01:14 +0200 (CEST)
Received: by wgbfg15 with SMTP id fg15so646696wgb.11
	for <alsa-devel@alsa-project.org>; Mon, 16 Apr 2012 08:01:10 -0700 (PDT)
In-Reply-To: <1334248206-17959-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Thu, 2012-04-12 at 17:30 +0100, Mark Brown wrote:
> Line widgets had not been included in either the power up or power down
> sequences so if a widget had an event associated with it that event would
> never be run. Fix this minimally by adding them to the sequences, we
> should probably be doing away with the specific widget types as they all
> have the same priority anyway.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Acked-by: Liam Girdwood <lrg@ti.com>
