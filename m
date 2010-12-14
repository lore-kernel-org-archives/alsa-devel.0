From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: TWL4030: Fix 24bit support
Date: Tue, 14 Dec 2010 12:35:04 +0000
Message-ID: <20101214123504.GD5723@sirena.org.uk>
References: <1292327129-19417-1-git-send-email-peter.ujfalusi@nokia.com>
	<20101214114914.GB13649@rakim.wolfsonmicro.main>
	<201012141411.00740.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 754CF1038EE
	for <alsa-devel@alsa-project.org>; Tue, 14 Dec 2010 13:35:05 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <201012141411.00740.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 14, 2010 at 02:11:00PM +0200, Peter Ujfalusi wrote:

> AFAIK this constraint is for applications to know, that only the 24 bit MSB is 
> valid in S32_LE (for example the ice1712 also sets this constraint to let 
> application know).

Hrm, yeah.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
