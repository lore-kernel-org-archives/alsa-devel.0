From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH resend] ASoC: sdp4430: Fix string for FM
	input name
Date: Fri, 30 Sep 2011 12:56:24 +0100
Message-ID: <20110930115624.GH5366@opensource.wolfsonmicro.com>
References: <1317371990-5499-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 618AB103B69
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Sep 2011 13:56:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1317371990-5499-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 30, 2011 at 11:39:50AM +0300, Peter Ujfalusi wrote:
> From: "Ujfalusi, Peter" <peter.ujfalusi@ti.com>
> 
> The name contains invalid valid character (/), which
> causes problems when trying to create the debugfs
> directory structure:
> ASoC: Failed to create Aux/FM Stereo In debugfs file

Applied, thanks.

> Acked-by: Liam Girdwood <lrg@ti.com>

Are you sure...  Liam would've applied it rather than acking it.
