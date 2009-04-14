From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH 1/2] ASoC: omap-mcbsp: Correct the DSP_B
 mode
Date: Tue, 14 Apr 2009 15:49:00 +0300
Message-ID: <20090414154900.1e9dc607.jarkko.nikula@nokia.com>
References: <1239695131-30367-1-git-send-email-peter.ujfalusi@nokia.com>
	<200904141334.33497.peter.ujfalusi@nokia.com>
	<20090414142004.fee14e30.jarkko.nikula@nokia.com>
	<200904141532.30478.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id E0DDB2435B
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Apr 2009 14:48:17 +0200 (CEST)
In-Reply-To: <200904141532.30478.peter.ujfalusi@nokia.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, ext@alsa-project.org, Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, 14 Apr 2009 14:32:30 +0200
"Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com> wrote:

> Should it be like this instead:
> + temp_fmt ^= SND_SOC_DAIFMT_NB_IF;
> 
Absolutely yes, good catch :-)

> 
> We only need to invert the FS polarity and the bclk should stay as it is..
> Also should than this modified fmt stored to mcbsp_data->fmt later?
> 
No since it's used only inside omap_mcbsp_dai_set_dai_fmt to tune polarity for the mode default. That's why there is this temp_fmt variable.


Jarkko
