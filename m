From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: TWL4030: Modify codec default
	settings
Date: Fri, 29 Jan 2010 10:17:09 +0000
Message-ID: <20100129101708.GB3201@rakim.wolfsonmicro.main>
References: <1264687024-7241-1-git-send-email-peter.ujfalusi@nokia.com>
	<20100128143424.GA10637@rakim.wolfsonmicro.main>
	<201001290901.30102.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 18CCB1038CE
	for <alsa-devel@alsa-project.org>; Fri, 29 Jan 2010 11:17:10 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <201001290901.30102.peter.ujfalusi@nokia.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 29, 2010 at 09:01:30AM +0200, Peter Ujfalusi wrote:

> What I have found out is that after boot these bits were set (obviously), after 
> the audio activity, they were cleared (not all, since if the given DAPM control 
> was not in the path, it was left enabled either way).
> Now these bits are 0 after boot, and only enabled, when a certain path needs it.
> In short: the overall power consumption was higher after boot, than what was 
> after for example the playback was stopped...

Hrm, that shouldn't happen - DAPM should be syncing during startup which
will turn off anything that's left turned on.  I'll have to fake up a
test for this, I'd not notice problems normally since all the devices I
start with power everything off by default.
