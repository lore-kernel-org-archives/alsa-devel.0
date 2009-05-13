From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/1] ASoC: TWL4030: Wait RAMP_DELAY
	on	headsetl_event: POST_PMD
Date: Wed, 13 May 2009 14:05:49 +0100
Message-ID: <20090513130548.GB10035@sirena.org.uk>
References: <1242040465-10835-1-git-send-email-peter.ujfalusi@nokia.com>
	<200905121616.08596.peter.ujfalusi@nokia.com>
	<20090512165625.e9852d18.jhnikula@gmail.com>
	<200905131557.09731.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 2AAC5103894
	for <alsa-devel@alsa-project.org>;
	Wed, 13 May 2009 15:05:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200905131557.09731.peter.ujfalusi@nokia.com>
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
Cc: "sakoman@gmail.com" <sakoman@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "getarunks@gmail.com" <getarunks@gmail.com>, "anuj.aggarwal@ti.com" <anuj.aggarwal@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, May 13, 2009 at 03:57:09PM +0300, Peter Ujfalusi wrote:

> Mark: About the  power up and down sequences in the soc-dapm.c file: are they 
> written in stone, or is it possible to make some - I think - minor 
> modification to the sequences?

The change you've made is to power the amplifiers down after the mixers.
That's going to cause problems on other systems - the result is going to
be that the amplifiers end up amplifying any noise the mixers make on
the way down which isn't good.  There's bits of the sequence that can be
fairly readily reordered but I'd worry about that particular change.
