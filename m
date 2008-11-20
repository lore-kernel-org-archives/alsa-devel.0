From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] Remove unused variable from tlv320aic23
	codec
Date: Thu, 20 Nov 2008 18:56:16 +0000
Message-ID: <20081120185616.GA8761@sirena.org.uk>
References: <1227204203-32112-1-git-send-email-aciddeath@gmail.com>
	<1227204203-32112-2-git-send-email-aciddeath@gmail.com>
	<1227204203-32112-3-git-send-email-aciddeath@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 9DD73103800
	for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2008 19:56:28 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1227204203-32112-3-git-send-email-aciddeath@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Richard A. Holden III" <aciddeath@gmail.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 20, 2008 at 11:03:23AM -0700, Richard A. Holden III wrote:

> Remove codec var from tlv320aic23_set_dai_sysclk, it is assigned to
> but never read.

This does not apply - it looks like you've generated it against code
from before commit 26df91c3 (ASoC: TLV320AIC23B Support more sample
rates) from 5th November which rewrote all this code.
