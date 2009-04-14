From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH 1/2] ASoC: omap-mcbsp: Correct the DSP_B
	mode
Date: Tue, 14 Apr 2009 12:02:21 +0300
Message-ID: <20090414120221.f0e89499.jarkko.nikula@nokia.com>
References: <1239695131-30367-1-git-send-email-peter.ujfalusi@nokia.com>
	<1239695131-30367-2-git-send-email-peter.ujfalusi@nokia.com>
	<20090414112016.c0dec32a.jarkko.nikula@nokia.com>
	<200904141140.17195.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 3AF43244AF
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Apr 2009 11:01:41 +0200 (CEST)
In-Reply-To: <200904141140.17195.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 14 Apr 2009 10:40:16 +0200
"Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com> wrote:

> > But I fear this change makes it into DSP_B with inverted FS
> > polarity. Register srgr1 defines the FS length and it's active low.
> > I think this will be correct if you switch the polarity in
> > omap_mcbsp_dai_set_dai_fmt.
> 
> As I written in the introduction mail, one has to verify and pick the
> correct pair of DSP_A/_B mode and FS/clock polarity in order to have
> correct config... I think it is acceptable to assume, that whoever
> writes such a board file should have at least this level of
> understanding of the FS/bitclock and how the data is driven and how
> the data is sampled.
> 
The pairs must mach. It's clearly a bug if another end is have to set
different polarity than another. Those polarity defines are with
respect to the mode, not e.g. what's the McBSP default.


Jarkko
