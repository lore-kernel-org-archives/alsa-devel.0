From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: DaVinci: Fix divide by
	zero	error during 1st execution
Date: Wed, 23 Sep 2009 18:10:39 +0100
Message-ID: <20090923171039.GB3457@sirena.org.uk>
References: <1252704543-25580-1-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 3CD48103891
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Sep 2009 19:10:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1252704543-25580-1-git-send-email-troy.kisky@boundarydevices.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 11, 2009 at 02:29:02PM -0700, Troy Kisky wrote:
> When both playback and capture stream were open
> davinci_i2s_hw_params was setting parameters for
> the wrong stream. The fix for davinci_i2s_hw_params
> is sufficient, but it looks like a race still happens
> in davici_pcm_open. This patch also makes the race smaller
> but the next patch provides a better fix.

> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>

Applied both, thanks.  Sorry about the delay in applying these - not
sure what I was waiting for there.
