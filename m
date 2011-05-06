From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/6] OMAP4: HDMI: Add OMAP device for HDMI
	audio CPU DAI
Date: Fri, 6 May 2011 14:16:58 +0100
Message-ID: <20110506131658.GL23729@opensource.wolfsonmicro.com>
References: <1304580113-24819-1-git-send-email-ricardo.neri@ti.com>
	<1304580113-24819-2-git-send-email-ricardo.neri@ti.com>
	<20110505081759.GD11744@opensource.wolfsonmicro.com>
	<1304623451.1900.32.camel@sagan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 07EDC243A9
	for <alsa-devel@alsa-project.org>;
	Fri,  6 May 2011 15:17:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1304623451.1900.32.camel@sagan>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ricardo Neri <ricardo.neri@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
	Liam" <lrg@ti.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, May 05, 2011 at 02:24:11PM -0500, Ricardo Neri wrote:

> Do you think I should use cpu_is_omap44xx() instead? In that case, the
> hdmi-audio-dai will be built even if HDMI audio option is not selected.

That doesn't seem like a real problem.
