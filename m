From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3] sound/soc/codecs: add LAPIS
	Semiconductor ML26124
Date: Tue, 29 Nov 2011 15:38:00 +0100
Message-ID: <4ED4EE48.8070100@metafoo.de>
References: <1322474755-18785-1-git-send-email-tomoya.rohm@gmail.com>	<4ED37CE3.6040008@metafoo.de>
	<CANKRQnh7MnSQdKXvPJvSPzf-7afXmHip9LqR1cKCgB6HXqcnBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-226.synserver.de (smtp-out-226.synserver.de
	[212.40.185.226])
	by alsa0.perex.cz (Postfix) with ESMTP id 6B023103B72
	for <alsa-devel@alsa-project.org>; Tue, 29 Nov 2011 15:36:59 +0100 (CET)
In-Reply-To: <CANKRQnh7MnSQdKXvPJvSPzf-7afXmHip9LqR1cKCgB6HXqcnBg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Mike Frysinger <vapier@gentoo.org>, qi.wang@intel.com, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, yong.y.wang@intel.com, kok.howg.ewe@intel.com, Daniel Mack <zonque@gmail.com>, Liam Girdwood <lrg@ti.com>, joel.clark@intel.com
List-Id: alsa-devel@alsa-project.org

On 11/29/2011 01:17 PM, Tomoya MORINAGA wrote:
> 2011/11/28 Lars-Peter Clausen <lars@metafoo.de>:
> 
>> Also none of the inputs is> routed to the ADC, which seems a bit strange.
> This same as my referencing "wm8731.c".Could you give me more information?
> 

The DAPM routes are used to do power management based on active path and for
this the routes should more or less represent the routing of internal audio
signals in your CODEC. I would expect the analog signals to go to the ADC on
the CODEC. And if you don't connect them in your DAPM routings ASoC will
probably not power-up the ADC since there are no active source signals.

Also this doesn't make much sense:
+	{"Input Mux", "Analog MIC in", "MICBIAS"},
+	{"Input Mux", "Digital MIC in", "MICBIAS"},

You have mux, but both possible settings of the mux connect to the same
source, which pretty much makes the mux useless.
