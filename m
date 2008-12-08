From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 5/8] ASoC: TWL4030: DAPM mapping of the
	PreDriv outputs
Date: Mon, 8 Dec 2008 13:50:26 +0000
Message-ID: <20081208135025.GK5159@sirena.org.uk>
References: <1228723748-22911-1-git-send-email-peter.ujfalusi@nokia.com>
	<1228723748-22911-6-git-send-email-peter.ujfalusi@nokia.com>
	<20081208112847.GE5159@sirena.org.uk>
	<200812081340.05602.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 1DF6C24396
	for <alsa-devel@alsa-project.org>; Mon,  8 Dec 2008 14:50:27 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <200812081340.05602.peter.ujfalusi@nokia.com>
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

On Mon, Dec 08, 2008 at 01:40:05PM +0200, Peter Ujfalusi wrote:
> On Monday 08 December 2008 13:28:48 ext Mark Brown wrote:

> > Does the "Invalid" option work well in applications like alsamixer?

> Not quite well, the outmixer_event will just plain forbits the Invalid 
> combination (returns -1, which should have been -EINVAL). In alsamixer you 
> can not really select the "DACR2". With amixer you can.

Eew, ick.  This isn't going to work nicely at all without custom
controls or support in the core for masking out mux values.

> I have been wondering about this for a while but could not find a better 
> solution, yet.

Silently rewriting the values isn't nice but should work.

Given the nature of the control I suspect your current solution will be
OK for now - I'd not expect it to be updated interactively too often.
