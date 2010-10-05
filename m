From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/1] ALSA: ASoc: DaVinci Delay start of ASP
	to trigger
Date: Tue, 5 Oct 2010 01:55:20 +0100
Message-ID: <20101005005519.GB20773@sirena.org.uk>
References: <1286142259-6625-1-git-send-email-martin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 285DF103810
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Oct 2010 02:55:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1286142259-6625-1-git-send-email-martin@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: martin@ti.com
Cc: alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com, Troy Kisky <troy.kisky@boundarydevices.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Oct 03, 2010 at 04:44:19PM -0500, martin@ti.com wrote:
> From: Troy Kisky <troy.kisky@boundarydevices.com>
> 
> Since only 4 mainline ASoC codecs support the trigger
> callback, we cannot rely upon them stopping the frame clock
> if they are master and must assume it is running even if the
> sound is paused. Thus we cannot start the ASP until the trigger
> method.

Applied, thanks.
