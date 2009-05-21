From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/2] ASoC: TWL4030: DAPM restructuring	and
	Headset pop-attenuation fix
Date: Thu, 21 May 2009 12:06:52 +0100
Message-ID: <20090521110651.GA31524@rakim.wolfsonmicro.main>
References: <1242651725-15001-1-git-send-email-peter.ujfalusi@nokia.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB03057419D3@dbde02.ent.ti.com>
	<20090520085121.GA11459@rakim.wolfsonmicro.main>
	<200905201212.52380.peter.ujfalusi@nokia.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0305741EC9@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AFAFE1038AA
	for <alsa-devel@alsa-project.org>;
	Thu, 21 May 2009 13:06:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0305741EC9@dbde02.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Cc: "sakoman@gmail.com" <sakoman@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, "getarunks@gmail.com" <getarunks@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, May 21, 2009 at 04:17:45PM +0530, Aggarwal, Anuj wrote:

> [Aggarwal, Anuj] I tried to look into the soc-dapm.h for the
> appropriate platform/machine-domain specific widget which could do the
> needful but could not find any. What is the correct way of handling
> this? I want to pass the correct ramp value for my platform.

Provide standard platform data for the twl4030, which would need the
driver patching to use that (and hopefully converted to the standard
device model).  Or for the time being you can do a register write in the
DAI init function, but the way forward is the platform data.
