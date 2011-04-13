From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/5] ASoC: Make struct snd_soc_card's
 dapm_widgets and dapm_routes const
Date: Wed, 13 Apr 2011 10:36:00 -0700
Message-ID: <20110413173559.GD18008@opensource.wolfsonmicro.com>
References: <1302629465-21315-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 09764103834
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Apr 2011 19:35:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1302629465-21315-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 12, 2011 at 07:31:01PM +0200, Lars-Peter Clausen wrote:
> Those should not be modified (and are not) by the core code, so make them const.
> This also makes them consistent with the same members of snd_soc_codec.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Applied 1, 3-5.
