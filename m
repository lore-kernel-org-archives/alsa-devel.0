From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ASoC: DaVinci: i2s,
	reduce underruns	by combining into 1 element
Date: Tue, 1 Sep 2009 11:53:02 +0100
Message-ID: <20090901105302.GD18651@sirena.org.uk>
References: <1251761505-11353-1-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 13C642445C
	for <alsa-devel@alsa-project.org>;
	Tue,  1 Sep 2009 12:53:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1251761505-11353-1-git-send-email-troy.kisky@boundarydevices.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Troy Kisky <troy.kisky@boundarydevices.com>
Cc: avm@ti.com, davinci-linux-open-source@linux.davincidsp.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 31, 2009 at 04:31:43PM -0700, Troy Kisky wrote:

> +	/*
> +	 * Allowing this is more efficient and eliminates left and right swaps
> +	 * caused by underruns, but will swap the left and right channels
> +	 * when compared to previous behavior.
> +	 */
> +	unsigned disable_channel_combine:1;

Last time you submitted this I suggested changing this to make the
default the other way round so that there's no breakage on existing
boards which aren't designed for this channel swap behaviour.  Is there
some reason not to do that?
