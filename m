From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Consider the codec->active	also?when
	changing bias level
Date: Tue, 29 Sep 2009 11:10:23 +0100
Message-ID: <20090929101022.GE32420@sirena.org.uk>
References: <1254130688-6183-1-git-send-email-peter.ujfalusi@nokia.com>
	<20090928111735.GA32420@sirena.org.uk>
	<200909290913.14051.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 291241038CD
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Sep 2009 12:10:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200909290913.14051.peter.ujfalusi@nokia.com>
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

On Tue, Sep 29, 2009 at 09:13:13AM +0300, Peter Ujfalusi wrote:

> I see. So there is no mechanism in place which would keep the serial interface 
> up when there is an ongoing playback/capture regardless of the DAPM routing?

Not in 2.6.31.  Going forward the AIF widgets are the way to deal with
this.

> On the other hand it also make sense to set the codec bias level to ON state, 
> when there is ongoing playback/capture. Or not, not sure about it.

Not really - the digital parts of the system are not generally sensitive
to the quality of their supplies in the way that the analogue parts are.
