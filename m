From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 0/8] ASoC: TWL4030: DAPM implementation for
	outputs (playback)
Date: Mon, 8 Dec 2008 13:20:41 +0000
Message-ID: <20081208132040.GJ5159@sirena.org.uk>
References: <1228723748-22911-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id ED77524377
	for <alsa-devel@alsa-project.org>; Mon,  8 Dec 2008 14:20:42 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1228723748-22911-1-git-send-email-peter.ujfalusi@nokia.com>
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

On Mon, Dec 08, 2008 at 10:09:00AM +0200, Peter Ujfalusi wrote:

> Based on the output routing selections all the corresponding DAC and
> analog PGA on the chain will be powered on.

One other question: how does this all interact with the existing power
control in set_bias_level()?
