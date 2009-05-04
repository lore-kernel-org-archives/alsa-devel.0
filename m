From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 1/2] ASoC: TWL4030: Add VDL analog bypass
Date: Mon, 4 May 2009 08:29:24 +0300
Message-ID: <200905040829.25180.peter.ujfalusi@nokia.com>
References: <2C7D3DF36ADFFC479B44490D912B616705F63E0BA7@dlee07.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id F214E1037ED
	for <alsa-devel@alsa-project.org>;
	Mon,  4 May 2009 07:29:47 +0200 (CEST)
In-Reply-To: <2C7D3DF36ADFFC479B44490D912B616705F63E0BA7@dlee07.ent.ti.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "ext Lopez Cruz, Misael" <x0052729@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

On Friday 01 May 2009 05:47:22 ext Lopez Cruz, Misael wrote:
> This patch adds voice downlink analog bypass switch. It follows
> the same approach as in other analog bypass switches.
> DAC switch is moved from 'DAC Voice' to 'Analog Voice Playback Mixer',
> that will also allow voice DAC to be powered in digital voice
> loopback (sidetone).
>
> Signed-off-by: Misael Lopez Cruz <x0052729@ti.com>

Generally this looks good, but it would have been better if you sent this 
series in three parts (now the first patch is doing two things):
0001: ASoC: TWL4030: Enable master analog loopback
0002: ASoC: TWL4030: Add VDL analog bypass
0003: ASoC: TWL4030: ASoC: TWL4030: Add voice digital loopback: sidetone

There is no mention about the master analog loopback switch in the first 
patch...

Either you could resend the series or Mark can modify the commit message for 
the first patch:
[PATCH 1/2] ASoC: TWL4030: Add VDL analog bypass and master loopback handling

Than to the end of the commit message:
"Handle the master analog loopback control based on the state of analog 
loopback switches"

Otherwise:
Acked-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
