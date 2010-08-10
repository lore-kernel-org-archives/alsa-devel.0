From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: amp power down event (resend with the
	correct	email)
Date: Tue, 10 Aug 2010 12:53:07 +0100
Message-ID: <20100810115306.GB4020@sirena.org.uk>
References: <4C604381.2080000@gandalf.sssup.it>
	<20100810103120.GA4020@sirena.org.uk>
	<4C613073.80508@gandalf.sssup.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 34A9E245D7
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Aug 2010 13:53:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4C613073.80508@gandalf.sssup.it>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Michael Trimarchi <trimarchi@gandalf.sssup.it>
Cc: alsa-devel@alsa-project.org, peter.ujfalusi@nokia.com
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 10, 2010 at 12:56:51PM +0200, Michael Trimarchi wrote:
> Mark Brown wrote:

> I have fixed change to SND_SOC_DAPM_PRE("Front Speaker", amp_event),

This is not a good fix, you've totally misunderstood what that widget
does and it won't be sequenced in the expected fashion.  You should use
a speaker widget for a speaker.
