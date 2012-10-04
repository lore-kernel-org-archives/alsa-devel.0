From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: twl6040: Fix Stream DAPM mapping
Date: Thu, 4 Oct 2012 18:45:17 +0100
Message-ID: <20121004174517.GP4360@opensource.wolfsonmicro.com>
References: <1349349302-8053-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D345326160D
 for <alsa-devel@alsa-project.org>; Thu,  4 Oct 2012 19:45:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1349349302-8053-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 04, 2012 at 02:15:02PM +0300, Peter Ujfalusi wrote:
> Fixes commit: 805238b ASoC: twl6040: Convert to use DAI DAPM widgets
> where the connection between the stream widgets and the ADC widgets was
> reversed and because of this on capture the DAPM is not powering up the
> codec.

Applied, thanks.
