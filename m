From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 0/6] ASoC: TWL4030: Cleanups and analog
	loopback support
Date: Tue, 27 Jan 2009 11:38:42 +0000
Message-ID: <20090127113840.GB1794@sirena.org.uk>
References: <1233048584-29662-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id A21261037EC
	for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2009 12:38:43 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1233048584-29662-1-git-send-email-peter.ujfalusi@nokia.com>
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

On Tue, Jan 27, 2009 at 11:29:38AM +0200, Peter Ujfalusi wrote:

> [1] ANAMICL register self cleaning bit handling
> [2] Simplified power up/down function
> [3] Move the Headset anti-pop/bias ramp enabling to be happend only if the
>     headset is actually in use
> [4] Change the place for the DAC power switch
> [5] Preparation for the loopback implementation
> [6] Analog loopback/bypass implementation

Applied 1-5 - some comments on 6 in followup to that.
