From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ASoC: twl6040: Workaround for headset
 DC offset caused pop noise
Date: Wed, 12 Oct 2011 13:12:06 +0100
Message-ID: <20111012121205.GL3647@opensource.wolfsonmicro.com>
References: <1318419962-1516-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8053310393A
	for <alsa-devel@alsa-project.org>;
	Wed, 12 Oct 2011 14:12:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1318419962-1516-1-git-send-email-peter.ujfalusi@ti.com>
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

On Wed, Oct 12, 2011 at 02:46:02PM +0300, Peter Ujfalusi wrote:
> Both Headset DAC need to be turned on/off at the same time before
> any of the output drivers are enabled (HS Left/Right, Earpiece).
> Move the HS DAC enable code to sequenced DAPM_SUPPLY, and attach
> it to the DACs.

Applied, thanks.
