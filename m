From: Ricardo Neri <ricardo.neri@ti.com>
Subject: Re: [PATCH 1/6] OMAP4: HDMI: Add OMAP device for HDMI
	audio CPU DAI
Date: Sat, 07 May 2011 19:09:12 -0500
Message-ID: <1304813352.11941.200.camel@sagan>
References: <1304580113-24819-1-git-send-email-ricardo.neri@ti.com>
	<1304580113-24819-2-git-send-email-ricardo.neri@ti.com>
	<20110505081759.GD11744@opensource.wolfsonmicro.com>
	<1304623451.1900.32.camel@sagan>
	<20110506131658.GL23729@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id EFCA5103835
	for <alsa-devel@alsa-project.org>;
	Sun,  8 May 2011 02:16:06 +0200 (CEST)
In-Reply-To: <20110506131658.GL23729@opensource.wolfsonmicro.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
	Liam" <lrg@ti.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hi Mark,
Am Freitag, den 06.05.2011, 08:16 -0500 schrieb Mark Brown:
> On Thu, May 05, 2011 at 02:24:11PM -0500, Ricardo Neri wrote:
> 
> > Do you think I should use cpu_is_omap44xx() instead? In that case, the
> > hdmi-audio-dai will be built even if HDMI audio option is not selected.
> 
> That doesn't seem like a real problem.
OK, in that case I will remove the #if conditional and all the audio
devices will be created as whole when the SND_SOC config is selected.
