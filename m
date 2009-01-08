From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 3/3] ASoC: TWL4030: Module unloading fix
Date: Thu, 8 Jan 2009 14:02:04 +0000
Message-ID: <20090108140204.GD25876@sirena.org.uk>
References: <1231422763-13659-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id ADD1324447
	for <alsa-devel@alsa-project.org>; Thu,  8 Jan 2009 15:02:05 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1231422763-13659-1-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: sakoman@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 08, 2009 at 03:52:43PM +0200, Peter Ujfalusi wrote:
> Call the snd_soc_free_pcm and snd_soc_dapm_free when the
> codec driver is unloaded.

> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>

Applied, thanks.  Might be worth having a look at the logging too...
