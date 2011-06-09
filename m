From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: core - PCM mutex per rtd
Date: Thu, 9 Jun 2011 20:06:25 +0100
Message-ID: <20110609190624.GA2821@opensource.wolfsonmicro.com>
References: <1307635479-3586-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DC6E5103BE1
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Jun 2011 21:06:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1307635479-3586-1-git-send-email-lrg@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 09, 2011 at 05:04:39PM +0100, Liam Girdwood wrote:
> In preparation for the new ASoC Dynamic PCM support (AKA DSP support).
> 
> The new ASoC Dynamic PCM core allows DAIs to be dynamically re-routed
> at runtime between the PCM device end (or Frontend - FE) and the physical DAI
> (Backend - BE) using regular kcontrols (just like a hardware CODEC routes
> audio in the analog domain). The Dynamic PCM core therefore must be
> able to call PCM operations for both the Frontend and Backend(s) DAIs at
> the same time.

Applied, thanks.
