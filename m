From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC] ASoC: Allow mulitple usage of codec and cpu
 dai
Date: Fri, 26 Feb 2010 11:26:05 +0000
Message-ID: <20100226112605.GB18864@rakim.wolfsonmicro.main>
References: <1267072011-11744-1-git-send-email-jassi.brar@samsung.com>
	<20100225100326.GC10141@rakim.wolfsonmicro.main>
	<1b68c6791002250300u4c6ff89am5009dc56187be6b1@mail.gmail.com>
	<20100225130619.GB11071@rakim.wolfsonmicro.main>
	<1b68c6791002251632q79cffa03r4a51a013c6bad81b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0655B24483
	for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2010 12:26:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1b68c6791002251632q79cffa03r4a51a013c6bad81b@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: jassi brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, Jassi Brar <jassi.brar@samsung.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 26, 2010 at 09:32:27AM +0900, jassi brar wrote:

> Also, I think we should look into if we can do without snd_soc_codec.active
> when we have snd_soc_dai.playback/capture.active counters.

Yes, the CODEC active counter has been pretty redundant for a long time
since the mute is a DAI-specific operation and all the CODEC active
counter is used for is muting on free.  I believe it's a hangover from
pre-DAPM days.
