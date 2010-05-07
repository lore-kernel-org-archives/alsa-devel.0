From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH RFC v1] ASoC: core: Support for
	limiting	the volume
Date: Fri, 7 May 2010 10:56:15 +0100
Message-ID: <20100507095614.GA27795@sirena.org.uk>
References: <1273212185-7129-1-git-send-email-peter.ujfalusi@nokia.com>
	<201005071026.35702.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 41287244E9
	for <alsa-devel@alsa-project.org>;
	Fri,  7 May 2010 11:56:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201005071026.35702.peter.ujfalusi@nokia.com>
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
Cc: alsa-devel@alsa-project.org, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, May 07, 2010 at 10:26:35AM +0300, Peter Ujfalusi wrote:

> Probably it would be better to return with 0 only, if we _changed_ the maximum.
> I'll resend after the comments.

No, I think it's fine to report success so long as the requested change
can be implemented - if it's a noop it might be worth printing a warning
but the requested setting is in effect.
