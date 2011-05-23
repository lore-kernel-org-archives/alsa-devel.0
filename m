From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Does amixer has to be used to make a complete path
	in ASoC?
Date: Mon, 23 May 2011 09:01:18 +0800
Message-ID: <20110523010116.GA23049@opensource.wolfsonmicro.com>
References: <9383297B60843144AC17878B479520F1169F03C829@SJEXCHCCR01.corp.ad.broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 13FAF24432
	for <alsa-devel@alsa-project.org>;
	Mon, 23 May 2011 03:01:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9383297B60843144AC17878B479520F1169F03C829@SJEXCHCCR01.corp.ad.broadcom.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Feng Ye <fye@broadcom.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sun, May 22, 2011 at 05:41:14PM -0700, Feng Ye wrote:

Please fix your mail client to word wrap within paragraphs.  I've
reflowed your mail for legibility.

> I think the problem may not be in the driver, instead, amixer should
> be used to select the codec mixer settings to build a complete audio
> path (like the LEFT MIXER in wm8750).

Yes, exactly.

> I have following questions:

> 1.       Is my understanding correct? amixer has to be used before aplay?

Yes.

> 2.       Is there way to do it in the code instead of using amixer?

No.

> 3.       If amixer has to be used, where I can find sample wm8750
> amixer setting usage for a simple playback from I2S in to Lout1 &
> Rout1 out?

In general you need to look at the DAPM map in the driver and figure out
how to connect whatever your audio source is to an output - most of the
control will be in the CODEC.  Look at the DAPM routes between the
widgets and figure out what to connect - the driver source will have a
routing table like your driver has in the form:

	{ destination, control, source }

so if control is not NULL the control with the specified name needs to
be enabled.  The debugfs files for the DAPM widgets (look under asoc/ in
debugfs) can help here.
