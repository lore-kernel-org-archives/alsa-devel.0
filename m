From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Help about LineIn capture on WM8904
Date: Thu, 27 Oct 2011 16:41:34 +0100
Message-ID: <20111027154133.GA11127@opensource.wolfsonmicro.com>
References: <380ff786.1a7c.1333a148237.Coremail.gnuser@yeah.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 21CAE24905
	for <alsa-devel@alsa-project.org>;
	Thu, 27 Oct 2011 17:41:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <380ff786.1a7c.1333a148237.Coremail.gnuser@yeah.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: gnuser <gnuser@yeah.net>
Cc: dp@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 25, 2011 at 03:56:22PM +0800, gnuser wrote:

> 1) Since WM8731 works fine (both playback and capture) on Atmel's ref board,
> and playback is also OK for my case, can we get the conclusion that the PCM
> driver and DAI driver are OK? Does the clock configuration for my case also look
> OK? 

Yes, they should be fine - the clocking requirements for record are the
same as those for playback so if you're able to get output audio then
input audio should also work.

> 2) In my machine driver, I added the following DAPM components,

If you're not using a controllable microphone bias (which I guess you
aren't as the subject line says you are using line input) then you
shouldn't need any DAPM configuration at all - I'd recommend not doing
this until you've got audio working as it is a potential source of
error.

> 3) I used "arecord -d 8 -f S16_LE -c2 -r8000 8000.wav" to capture audio. But the
> captured data are something looks like
> 84 FF 73 FF  83 FF 70 FF
> 85 FF 72 FF  84 FF 71 FF
> 83 FF 72 FF  84 FF 72 FF
> 87 FF 71 FF  83 FF 71 FF

This looks rather like you've got an input path connected but muted.
Without knowing which path you're trying to configure I might be missing
somethig here...

> Simple mixer control 'Capture',0
>   Capabilities: cvolume cswitch penum
>   Capture channels: Front Left - Front Right
>   Limits: Capture 0 - 31
>   Front Left: Capture 5 [16%] [on]
>   Front Right: Capture 5 [16%] [on]

Unfortunately there's no TLV information on the control but is this
possibly too low?

> Simple mixer control 'HPL Mux',0
>   Capabilities: enum
>   Items: 'DAC' 'Bypass'
>   Item0: 'DAC'
> Simple mixer control 'HPR Mux',0
>   Capabilities: enum
>   Items: 'DAC' 'Bypass'
>   Item0: 'DAC'

When debugging it may be useful to configure a bypass path via the
controls above so you can hear the output directly - this makes
debugging much easier as there's immediate feedback on changes.  If
bypass works but recording doesn't move on to using the sidetone path
(noting that the gain is very low by default) in case there's an issue
in the digital configuration.

> Simple mixer control 'Right Capture Mux',0
>   Capabilities: enum
>   Items: 'IN1R' 'IN2R' 'IN3R'
>   Item0: 'IN2R'

These look like they might be defaults - are you sure the settings are
correct?
