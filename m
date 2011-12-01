From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3] sound/soc/codecs: add LAPIS
	Semiconductor ML26124
Date: Thu, 01 Dec 2011 20:36:20 +0100
Message-ID: <4ED7D734.4020301@metafoo.de>
References: <1322474755-18785-1-git-send-email-tomoya.rohm@gmail.com>	<4ED37CE3.6040008@metafoo.de>	<CANKRQnh7MnSQdKXvPJvSPzf-7afXmHip9LqR1cKCgB6HXqcnBg@mail.gmail.com>	<4ED4EE48.8070100@metafoo.de>
	<CANKRQniP=UUAPbbyoZNvxs16H7QZzS=O9zwt6kJu69u8s8qGTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
	(mailhost.informatik.uni-hamburg.de [134.100.9.70])
	by alsa0.perex.cz (Postfix) with ESMTP id 3AAC124343
	for <alsa-devel@alsa-project.org>; Thu,  1 Dec 2011 20:37:28 +0100 (CET)
In-Reply-To: <CANKRQniP=UUAPbbyoZNvxs16H7QZzS=O9zwt6kJu69u8s8qGTQ@mail.gmail.com>
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

On 12/01/2011 08:46 AM, Tomoya MORINAGA wrote:
> 2011/11/29 Lars-Peter Clausen <lars@metafoo.de>:
>>
>> Also this doesn't make much sense:
>> +       {"Input Mux", "Analog MIC in", "MICBIAS"},
>> +       {"Input Mux", "Digital MIC in", "MICBIAS"},
>>
>> You have mux, but both possible settings of the mux connect to the same
>> source, which pretty much makes the mux useless.
>>
> 
> Yes, you are right.
> This setting was miss-settings.
> This MICBIAS supplies to external MIC as reference voltage.
> So, I think MICBIAS shouldn't appear at this setting.
> I show modified settings.
>        /* input */
>        {"Input Mux", "Analog MIC SingleEnded in", "MIN"},
>        {"Input Mux", "Analog MIC Differential in", "MIN"},
>        {"Input Mux", "Digital MIC in", "MDIN"},
>        {"ADC", "PGA", "Input Mux"},
> 

The middle part(the control) of the path must either be a control attached to
the mixer on the left side(the sink) or a element of the mux's enum if a mux is
on the left side. If the left side is neither a mixer or a mux the middle part
is ignored.

The other problem probably is that you have one mux which lets you switch
between single-ended analog input, differential analog input and digital input.
The first two options are routed through PGA and ADC the later not.

- Lars
